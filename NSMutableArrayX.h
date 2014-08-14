//
//  NSMutableArrayX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (X)

/**
 A new array storing weak references to objects.
 */
+ (id)arrayUsingWeakReferences;

/**
 A new array storing weak references to objects.
 
 @param capacity Array's capacity.
 */
+ (id)arrayUsingWeakReferencesWithCapacity:(NSUInteger)capacity;

/**
 Randomly shuffle the array's content.
 */
- (void)shuffle;

/**
 Append an object to the array.
 
 @param anObject An object to enqueue.
 */
- (void)enqueue:(id)anObject;

/**
 Get the first enqueued object and remove it from the array.
 
 @return The first object of the array.
 */
- (id)dequeue;

/**
 Append an object to the array.
 
 @param anObject An object to push.
 */
- (void)push:(id)anObject;

/**
 Get the last pushed object and remove it from the array.
 
 @return The last object of the array.
 */
- (id)pop;

@end
