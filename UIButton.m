//
// Created by Petr Korolev on 11/09/14.
// Copyright (c) 2014 Anthony Shoumikhin. All rights reserved.
//

#import "UIButton.h"


@implementation UIButton (X)

- (void)setImageForAllStates:(UIImage *)image
{
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateHighlighted];
    [self setImage:image forState:UIControlStateDisabled];
    [self setImage:image forState:UIControlStateSelected];
}

- (void)setTitleForAllStates:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
    [self setTitle:title forState:UIControlStateDisabled];
    [self setTitle:title forState:UIControlStateSelected];
}

@end