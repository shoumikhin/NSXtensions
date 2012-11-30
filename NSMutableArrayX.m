#import "NSMutableArrayX.h"

@implementation NSMutableArray (X)

- (void)shuffle
{
    static BOOL seeded;
    
    if (!seeded)
    {
        seeded = YES;
        srandom(time(NULL));
    }
    
    NSUInteger count = self.count;
    
    for (NSUInteger i = 0; i < count; ++i)
    {
        int nElements = count - i;
        int n = (random() % nElements) + i;
        
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
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
