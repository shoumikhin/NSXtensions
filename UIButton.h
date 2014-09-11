//
// Created by Petr Korolev on 11/09/14.
// Copyright (c) 2014 Anthony Shoumikhin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIButton (X)

/**
 *  Set image for all states at once
 */
-(void)setImageForAllStates:(UIImage *)image;

/**
*  Set image for all states at once
*/
- (void)setTitleForAllStates:(NSString *)title;
@end