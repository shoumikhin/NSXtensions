#import "UIImageX.h"

@import Accelerate;

@implementation UIImage (X)

- (id)initWithContentsOfURL:(NSURL *)URL
{
    return [self initWithData:[NSData.alloc initWithContentsOfURL:URL]];
}

+ (UIImage *)imageWithContentsOfURL:(NSURL *)URL
{
    return [UIImage imageWithData:[NSData.alloc initWithContentsOfURL:URL]];
}

- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor
{
    CGFloat const EffectColorAlpha = 0.6;
    UIColor *effectColor = tintColor;
    size_t componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);

    if (2 == componentCount)
    {
        CGFloat b;

        if ([tintColor getWhite:&b alpha:NULL])
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
    }
    else
    {
        CGFloat r, g, b;

        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL])
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
    }

    return [self applyBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage
{
    if (self.size.width < 1 || self.size.height < 1)
        return nil;

    if (!self.CGImage)
        return nil;

    if (maskImage && !maskImage.CGImage)
        return nil;
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    
    if (hasBlur || hasSaturationChange)
    {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        
        vImage_Buffer effectOutBuffer;
        
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur)
        {
            CGFloat inputRadius = blurRadius * UIScreen.mainScreen.scale;
            uint32_t radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            
            if (radius % 2 != 1)
                radius += 1;

            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        
        BOOL effectImageBuffersAreSwapped = NO;
        
        if (hasSaturationChange)
        {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] =
            {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,                    1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            
            for (NSUInteger i = 0; i < matrixSize; ++i)
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            
            if (hasBlur)
            {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
        }
        
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
    
    UIImage *outputImage = nil;
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, UIScreen.mainScreen.scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextTranslateCTM(context, 0, -self.size.height);
        CGContextDrawImage(context, imageRect, self.CGImage);
        
        if (hasBlur)
        {
            CGContextSaveGState(context);
            
            if (maskImage)
                CGContextClipToMask(context, imageRect, maskImage.CGImage);

            CGContextDrawImage(context, imageRect, effectImage.CGImage);
            CGContextRestoreGState(context);
        }
        
        if (tintColor)
        {
            CGContextSaveGState(context);
            CGContextSetFillColorWithColor(context, tintColor.CGColor);
            CGContextFillRect(context, imageRect);
            CGContextRestoreGState(context);
        }
        
        outputImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return outputImage;
}

- (UIImage *)cropToRect:(CGRect)rect
{
    UIImage *ret = nil;
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, CGRectMake(self.scale * rect.origin.x, self.scale * rect.origin.y, self.scale * rect.size.width, self.scale * rect.size.height));
    
    ret = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    
    CGImageRelease(imageRef);
    
    return ret;
}

@end