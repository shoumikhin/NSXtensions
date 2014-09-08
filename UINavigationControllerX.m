#import "UINavigationControllerX.h"

@implementation UINavigationController (X)

- (void)pushViewController:(UIViewController *)viewController withTransitionType:(NSString *)type
{
    [self pushViewController:viewController withTransitionType:type subtype:nil];
}

- (void)pushViewController:(UIViewController *)viewController withTransitionType:(NSString *)type subtype:(NSString *)subtype
{
    [self addTransitionWithType:type subtype:subtype];
    [self pushViewController:viewController animated:NO];
}

- (UIViewController *)popViewControllerWithTransitionType:(NSString *)type
{
    return [self popViewControllerWithTransitionType:type subtype:nil];
}

- (UIViewController *)popViewControllerWithTransitionType:(NSString *)type subtype:(NSString *)subtype
{
    [self addTransitionWithType:type subtype:subtype];
    
    return [self popViewControllerAnimated:NO];
}

- (NSArray *)popToRootViewControllerWithTransitionType:(NSString *)type
{
    return [self popToRootViewControllerWithTransitionType:type subtype:nil];
}

- (NSArray *)popToRootViewControllerWithTransitionType:(NSString *)type subtype:(NSString *)subtype
{
    [self addTransitionWithType:type subtype:subtype];
    
    return [self popToRootViewControllerAnimated:NO];
}

- (NSArray *)popToViewController:(UIViewController *)viewController withTransitionType:(NSString *)type
{
    return [self popToViewController:viewController withTransitionType:type subtype:nil];
}

- (NSArray *)popToViewController:(UIViewController *)viewController withTransitionType:(NSString *)type subtype:(NSString *)subtype
{
    [self addTransitionWithType:type subtype:subtype];
    
    return [self popToViewController:viewController animated:NO];
}

- (void)addTransitionWithType:(NSString *)type subtype:(NSString *)subtype
{
    CATransition *transition = CATransition.animation;
    
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.duration = UIApplication.sharedApplication.statusBarOrientationAnimationDuration;
    transition.type = type;
    transition.subtype = subtype;
    
    [self.view.layer addAnimation:transition forKey:nil];
}

@end

