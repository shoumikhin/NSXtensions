#import "UIApplicationX.h"

#import "MacroX.h"

#include <execinfo.h>

#define RETURN_ALERT_TIMEOUT 3.0

@implementation UIApplication (X)

SYNTHESIZE_STATIC_PROPERTY(NSString *, identifier,
{
    return NSBundle.mainBundle.bundleIdentifier;
})
    
SYNTHESIZE_STATIC_PROPERTY(NSString *, version,
{
    return [NSBundle.mainBundle objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
})

+ (CGRect)frame
{
    return [UIApplication frameOriented:UIApplication.sharedApplication.statusBarOrientation];
}

+ (CGRect)frameOriented:(UIInterfaceOrientation)orientation
{
    CGRect ret = UIScreen.mainScreen.bounds;
    UIApplication *application = UIApplication.sharedApplication;
    
    if (UIInterfaceOrientationIsLandscape(orientation))
        ret = CGRectMake(0.0, 0.0, ret.size.height, ret.size.width);
    
    if (!application.statusBarHidden)
    {
        ret.size.height -= MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
        ret.origin.y += MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
    }
    
    return ret;
}

+ (CGFloat)statusBarHeight
{
    return MIN(UIApplication.sharedApplication.statusBarFrame.size.width, UIApplication.sharedApplication.statusBarFrame.size.height);
}

+ (NSArray *)backtrace
{
    void *stack[0x80];
    int count = backtrace(stack, sizeof(stack)/sizeof(stack[0]));
    char **strings = backtrace_symbols(stack, count);
    NSMutableArray *ret = [NSMutableArray.alloc initWithCapacity:count];
    
    for (int i = 0; i < count; ++i)
	 	[ret addObject:@(strings[i])];
    
    free(strings);
    
    return ret;
}

+ (void)call:(NSString *)phoneNumber andShowReturn:(BOOL)shouldReturn
{
    if (!phoneNumber.length)
        return;

    if (![phoneNumber hasPrefix:@"tel://"])
        phoneNumber = [@"tel://" stringByAppendingString:phoneNumber];

    [self openURL:[NSURL URLWithString:phoneNumber] andShowReturn:shouldReturn];
}

+ (void)email:(NSString *)address andShowReturn:(BOOL)shouldReturn
{
    if (!address.length)
        return;

    if (![address hasPrefix:@"mailto://"])
        address = [@"mailto://" stringByAppendingString:address];
    
    [self openURL:[NSURL URLWithString:address] andShowReturn:shouldReturn];
}

+ (void)openURL:(NSURL *)url andShowReturn:(BOOL)shouldReturn
{
    if (!url)
        return;

#if !TARGET_IPHONE_SIMULATOR
    if ([UIApplication.sharedApplication canOpenURL:url])
    {
#endif
        [UIApplication.sharedApplication openURL:url];
        
        if (shouldReturn)
        {
            UILocalNotification *notification = UILocalNotification.new;

            notification.timeZone = NSTimeZone.systemTimeZone;
            notification.fireDate = [NSDate.date dateByAddingTimeInterval:RETURN_ALERT_TIMEOUT];
            notification.alertAction = @"Return";
            notification.alertBody = [NSString stringWithFormat:@"Back to %@", [NSBundle.mainBundle objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey]];
            notification.soundName = UILocalNotificationDefaultSoundName;
            
            [UIApplication.sharedApplication scheduleLocalNotification:notification];
        }
#if !TARGET_IPHONE_SIMULATOR
    }
#endif
}

@end
