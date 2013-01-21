#import "UIWebViewX.h"

@implementation UIWebView (X)

- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL font:(UIFont *)font
{
    [self loadHTMLString:[NSString.alloc initWithFormat:@"<html> \n<style type=\"text/css\"> \nbody {font-family: \"%@\"; font-size: %f;}\n</style> \n</head> \n<body>%@</body> \n</html>", font.fontName, font.pointSize, string] baseURL:baseURL];
}

- (void)clearCookies
{
    NSHTTPCookieStorage *storage = NSHTTPCookieStorage.sharedHTTPCookieStorage;
    
    for (NSHTTPCookie *cookie in storage.cookies)
        [storage deleteCookie:cookie];

    [NSUserDefaults.standardUserDefaults synchronize];
}

@end
