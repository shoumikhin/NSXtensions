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

+ (NSArray *)backtrace
{
    void *stack[0x80];
    int count = backtrace(stack, sizeof(stack)/sizeof(stack[0]));
    char **strings = backtrace_symbols(stack, count);
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; ++i)
	 	[ret addObject:@(strings[i])];
    
    free(strings);
    
    return ret;
}

@end
