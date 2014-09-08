#import "NSURLX.h"

@implementation NSURL (X)

- (NSURL *)hostURL
{
    NSMutableString *ret = NSMutableString.new;
    
    if (self.scheme.length)
        [ret appendFormat:@"%@://", self.scheme];
    
    if (self.host.length)
        [ret appendString:self.host];

    if (self.port)
        [ret appendFormat:@":%@", self.port];
    
	return [NSURL.alloc initWithString:ret];
}

@end
