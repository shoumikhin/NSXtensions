#import "UIApplicationX.h"

#include <execinfo.h>

@implementation UIApplication (X)

+ (NSString *)identifier
{
    static NSString *s_identifier;
    
    if (!s_identifier)
        s_identifier = NSBundle.mainBundle.bundleIdentifier;
    
    return s_identifier;
}

+ (NSString *)version
{
    static NSString *s_version;
    
    if (!s_version)
        s_version = [NSBundle.mainBundle objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    
    return s_version;
}

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

+ (void)call:(NSString *)phoneNumber andScheduleReturnNotification:(BOOL)shouldSchedule
{
    if (![phoneNumber hasPrefix:@"tel://"])
        phoneNumber = [@"tel://" stringByAppendingString:phoneNumber];
    
    [self openURL:phoneNumber andScheduleReturnNotification:shouldSchedule];
}

+ (void)mail:(NSString *)emailAddress andScheduleReturnNotification:(BOOL)shouldSchedule
{
    if (![emailAddress hasPrefix:@"mailto://"])
        emailAddress = [@"mailto://" stringByAppendingString:emailAddress];
    
    [self openURL:emailAddress andScheduleReturnNotification:shouldSchedule];
}

+ (void)openSite:(NSString *)siteAddress andScheduleReturnNotification:(BOOL)shouldSchedule
{
    if (!([siteAddress hasPrefix:@"http://"] || [siteAddress hasPrefix:@"https://"]))
        siteAddress = [@"http://" stringByAppendingString:siteAddress];
    
    [self openURL:siteAddress andScheduleReturnNotification:shouldSchedule];
}

+ (void)openURL:(NSString *)urlString andScheduleReturnNotification:(BOOL)shouldSchedule
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    UIApplication *sharedApp = [UIApplication sharedApplication];
    
#if !TARGET_IPHONE_SIMULATOR
    if ([sharedApp canOpenURL:url]) {
#endif
        [sharedApp openURL:url];
        
        if (shouldSchedule) {
            UILocalNotification *notification = [UILocalNotification new];
            notification.timeZone = [NSTimeZone systemTimeZone];
            notification.fireDate = [[NSDate date] dateByAddingTimeInterval:3.0f];
            notification.alertAction = @"Return";
            notification.alertBody = [NSString stringWithFormat:@"Return to %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
            notification.soundName = UILocalNotificationDefaultSoundName;
            
            [sharedApp scheduleLocalNotification:notification];
        }
#if !TARGET_IPHONE_SIMULATOR
    }
#endif
}


@end
