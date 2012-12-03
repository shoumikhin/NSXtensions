#import "UIViewX.h"

@implementation UIView (X)

- (id)searchForUIViewController
{
    id nextResponder = self.nextResponder;
    
    if ([nextResponder isKindOfClass:UIViewController.class])
        return nextResponder;
    else
        if ([nextResponder isKindOfClass:UIView.class])
            return [nextResponder searchForUIViewController];
        else
            return nil;
}

- (UIViewController *)viewController
{
    return (UIViewController *)[self searchForUIViewController];
}

- (BOOL)findAndResignFirstResponder
{
    if (self.isFirstResponder)
    {
        [self resignFirstResponder];
        
        return YES;     
    }
    
    for (UIView *subView in self.subviews)
        if ([subView findAndResignFirstResponder])
            return YES;

    return NO;
}

@end
