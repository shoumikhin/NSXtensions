#import "UIImageX.h"

@implementation UIImage (X)

- (id)initWithContentsOfURL:(NSURL *)URL
{
    return [self initWithData:[NSData dataWithContentsOfURL:URL]];
}

+ (UIImage *)imageWithContentsOfURL:(NSURL *)URL
{
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:URL]];
}

@end
