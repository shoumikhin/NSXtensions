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
    return (UIViewController *)self.searchForUIViewController;
}

- (UIView *)superviewOfClass:(Class)aClass
{
	UIView *view = self.superview;
    
	while (view)
    {
        if ([view isKindOfClass:aClass])
			break;
		else
			view = view.superview;
	}
    
	return view;
}

- (BOOL)resignFirstResponderRecursively
{
    if (self.isFirstResponder)
    {
        [self resignFirstResponder];
        
        return YES;     
    }
    
    for (UIView *subView in self.subviews)
        if (subView.resignFirstResponderRecursively)
            return YES;

    return NO;
}

- (void)moveTo:(CGPoint)destination duration:(NSTimeInterval)seconds options:(UIViewAnimationOptions)options
{
    [UIView animateWithDuration:seconds delay:0.0 options:options animations:^
    {
        self.frame = CGRectMake(destination.x, destination.y, self.frame.size.width, self.frame.size.height);
    }
    completion:nil];
}

@end
