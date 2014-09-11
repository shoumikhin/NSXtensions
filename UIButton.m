//
// Created by Petr Korolev on 11/09/14.
// Copyright (c) 2014 Anthony Shoumikhin. All rights reserved.
//

#import "UIButton.h"


@implementation UIButton (X)

- (void)setImageForAllStates:(UIImage *)image
{
    [self setImage:image forState:UIControlStateNormal|UIControlStateHighlighted|UIControlStateDisabled|UIControlStateSelected];
}

- (void)setTitleForAllStates:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal|UIControlStateHighlighted|UIControlStateDisabled|UIControlStateSelected];
}

@end