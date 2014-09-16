//
// Created by Petr Korolev on 16/09/14.
// Copyright (c) 2014 Anthony Shoumikhin. All rights reserved.
//

#import "NSArrayX.h"


@implementation NSArray (X)

- (NSArray *)filteredArrayUsingBlock:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return [self objectsAtIndexes:[self indexesOfObjectsPassingTest:predicate]];
}

@end