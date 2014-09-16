//
//  UIButtonX.h
//
//  Created by Petr Korolev.
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <UIKit/UIKit.h>

@interface UIButton (X)

/**
 Set a title for all UIControl states at once.

 @param title A title to be set.
 */
- (void)setTitleForAllStates:(NSString *)title;

/**
 Set an image for all UIControl states at once.

 @param image An image to be set.
 */
-(void)setImageForAllStates:(UIImage *)image;

@end