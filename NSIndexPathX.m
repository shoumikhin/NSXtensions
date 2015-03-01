#import "NSIndexPathX.h"

@implementation NSIndexPath (X)

+ (NSIndexPath *)indexPathWithString:(NSString *)path
{
    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndexes:NULL length:0];

    for (NSString *component in [path componentsSeparatedByString:@"."])
        indexPath = [indexPath indexPathByAddingIndex:component.integerValue];

    return indexPath;
}

- (NSString *)stringValue
{
    if (!self.length)
        return @"";

    NSMutableString *path = [NSMutableString.alloc initWithFormat:@"%lu", (unsigned long)self.firstIndex];

    for (int i = 1; i < self.length; ++i)
        [path appendFormat:@".%lu", (unsigned long)[self indexAtPosition:i]];

    return path;
}

- (NSUInteger)firstIndex
{
    return [self indexAtPosition:0];
}

- (NSUInteger)lastIndex
{
    return [self indexAtPosition:self.length - 1];
}

@end
