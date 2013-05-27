#import "UIColorX.h"

@implementation UIColor (X)

+ (UIColor *)colorWithHTMLColor:(NSString *)HTMLColor
{
    NSUInteger rgb = 0;
    NSScanner *scanner = [NSScanner scannerWithString:HTMLColor];

    if ([HTMLColor hasPrefix:@"#"])
        scanner.scanLocation = 1;

    [scanner scanHexInt:&rgb];

    return [UIColor colorWithRed:((rgb & 0xFF0000) >> 0x10) / 255.0 green:((rgb & 0xFF00) >> 0x8) / 255.0 blue:(rgb & 0xFF) / 255.0 alpha:1.0];
}

@end
