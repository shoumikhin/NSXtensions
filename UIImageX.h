//
//  UIImageX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <UIKit/UIKit.h>

@interface UIImage (X)

/**
 Download an image with URL.
 
 @return A new image with contents of URL.
 */
- (id)initWithContentsOfURL:(NSURL *)URL;
+ (UIImage *)imageWithContentsOfURL:(NSURL *)URL;

/**
 Apply the blur effect to the image.
 
 @param blurRadius
 @param tintColor
 @param saturationDeltaFactor
 @param maskImage
 @return A new modified image.
 */
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

/**
 Crops an image to a given rect inside image's frame.
 
 @param rect Rectangle to crop from original image.
 @return A new image representing a cropped part of the original.
 */
- (UIImage *)cropToRect:(CGRect)rect;

@end
