#import "UIAlertViewX.h"

#import <objc/runtime.h>

@interface XAlertViewWrapper : NSObject

@property (copy) UIAlertViewCompletionBlock completionBlock;

@end

@implementation XAlertViewWrapper

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.completionBlock)
        self.completionBlock(alertView, buttonIndex);
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    if (self.completionBlock)
        self.completionBlock(alertView, alertView.cancelButtonIndex);
}

@end

static const char kXAlertViewWrapper;

@implementation UIAlertView (X)

- (void)showWithCompletion:(UIAlertViewCompletionBlock)completionBlock
{
    XAlertViewWrapper *alertViewWrapper = XAlertViewWrapper.new;

    alertViewWrapper.completionBlock = completionBlock;
    self.delegate = alertViewWrapper;

    objc_setAssociatedObject(self, &kXAlertViewWrapper, alertViewWrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    [self show];
}

@end
