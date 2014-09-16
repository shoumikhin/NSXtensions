//
// Created by Petr Korolev on 16/09/14.
// Copyright (c) 2014 Anthony Shoumikhin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (X)
/**
 *  @return new NSArray with objects, that passing test block
 */
- (NSArray *)filteredArrayUsingBlock:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))predicate;
@end