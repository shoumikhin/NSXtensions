//
//  UIWebView+X.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <UIKit/UIKit.h>

@interface UIColor (X)

/**
 Convert HTML color notation ("#RRGGBB") to UIColor.

 @return UIColor similar to given HTML color.
 */
+ (UIColor *)colorWithHTMLColor:(NSString *)HTMLColor DEPRECATED_ATTRIBUTE;

/**
 *  Convert hex string color from pattern #RBG, #ARGB, #RRGGBB, or #AARRGGBB (# is optional sign) to UIColor.
 *
 *  @param hexString input string color
 *
 *  @return Generated UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;
@end
