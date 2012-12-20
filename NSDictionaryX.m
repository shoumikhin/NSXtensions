#import "NSDictionaryX.h"

@implementation NSDictionary (X)

+ (NSDictionary *)dictionaryByMerging:(NSDictionary *)first with:(NSDictionary *)second
{
    NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithDictionary:first];
    
    [second enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {
        if (![first objectForKey:key])
        {
            if ([obj isKindOfClass:NSDictionary.class])
                ret[key] = [first[key] dictionaryByMergingWith:(NSDictionary *)obj];
            else
                ret[key] = obj;
        }
    }];
    
    return ret;
}

- (NSDictionary *)dictionaryByMergingWith:(NSDictionary *)other
{
    return [self.class dictionaryByMerging:self with:other];
}

@end
