#import "UIViewX.h"

@implementation UIView (X)

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;

    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;

    frame.origin.y = y;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    self.x = origin.x;
    self.y = origin.y;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;

    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;

    frame.size.height = height;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    self.width = size.width;
    self.height = size.height;
}

- (CGFloat)dx
{
    return self.x + self.width;
}

- (void)setDx:(CGFloat)dx
{
    self.x = dx - self.width;
}

- (CGFloat)dy
{
    return self.y + self.height;
}

- (void)setDy:(CGFloat)dy
{
    self.y = dy - self.height;
}

- (CGVector)bound
{
    return CGVectorMake(self.dx, self.dy);
}

- (void)setBound:(CGVector)bound
{
    self.dx = bound.dx;
    self.dy = bound.dy;
}

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
