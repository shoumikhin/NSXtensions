#import "NSSetX.h"

@implementation NSSet (X)

- (NSDictionary *)indexedDictionary
{
    NSMutableDictionary *ret = NSMutableDictionary.new;
    NSUInteger i = 0;
    
    for (id object in self.allObjects)
        ret[@(i++).stringValue] = object;

    return ret;
}

@end
