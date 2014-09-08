#import "NSMutableArrayX.h"

@implementation NSMutableArray (X)

+ (id)arrayUsingWeakReferences
{
    return [self arrayUsingWeakReferencesWithCapacity:0];
}

+ (id)arrayUsingWeakReferencesWithCapacity:(NSUInteger)capacity
{
    CFArrayCallBacks callbacks = {0, NULL, NULL, CFCopyDescription, CFEqual};
    
    return (__bridge_transfer id)(CFArrayCreateMutable(0, capacity, &callbacks));
}

- (void)shuffle
{
    static BOOL seeded;

    if (!seeded)
    {
        seeded = YES;
        srandom((unsigned)time(NULL));
    }

    NSUInteger count = self.count;

    for (NSUInteger i = 0; i < count; ++i)
        [self exchangeObjectAtIndex:i withObjectAtIndex:i + random() % (count - i)];
}

- (void)enqueue:(id)anObject
{
    [self addObject:anObject];
}

- (id)dequeue
{
    if (!self.count)
        return nil;
    
    id headObject = self[0];
    
    if (headObject)
        [self removeObjectAtIndex:0];

    return headObject;
}

- (void)push:(id)anObject
{
    [self addObject:anObject];
}

- (id)pop
{
    id tailObject = self.lastObject;
    
    if (tailObject)
        [self removeLastObject];
    
    return tailObject;
}

@end
