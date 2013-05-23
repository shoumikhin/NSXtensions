#import "NSDictionaryX.h"

@implementation NSDictionary (X)

+ (NSDictionary *)dictionaryByMerging:(NSDictionary *)first with:(NSDictionary *)second
{
    if (!first)
        return second;

    if (!second)
        return first;

    NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithDictionary:first];
    
    [second enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {
        if (!first[key])
            ret[key] = obj;
    }];
    
    return ret;
}

- (NSDictionary *)mergeWith:(NSDictionary *)other
{
    return [self.class dictionaryByMerging:self with:other];
}

@end
