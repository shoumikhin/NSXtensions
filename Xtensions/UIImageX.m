#import "UIImageX.h"

@implementation UIImage (X)

- (id)initWithContentsOfURL:(NSURL *)URL
{
    return [self initWithData:[NSData.alloc initWithContentsOfURL:URL]];
}

+ (UIImage *)imageWithContentsOfURL:(NSURL *)URL
{
    return [UIImage imageWithData:[NSData.alloc initWithContentsOfURL:URL]];
}

@end
