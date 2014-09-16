#import "UIButtonX.h"

@implementation UIButton (X)

- (void)setTitleForAllStates:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:nil forState:UIControlStateHighlighted];
    [self setTitle:nil forState:UIControlStateDisabled];
    [self setTitle:nil forState:UIControlStateSelected];
}

- (void)setImageForAllStates:(UIImage *)image
{
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:nil forState:UIControlStateHighlighted];
    [self setImage:nil forState:UIControlStateDisabled];
    [self setImage:nil forState:UIControlStateSelected];
}

@end