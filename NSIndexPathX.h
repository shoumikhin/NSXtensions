//
//  NSIndexPathX.h
//
//  Copyright (c) 2015 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (X)

/**
 Creates a new index path with a given string representation.

 @param path A string representing the index path (integer components separated by dots).
 @return A new index path object or nil if invalid string representation is passed.
 */
+ (NSIndexPath *)indexPathWithString:(NSString *)path;

/**
 Get the string representation of the index path which is simply the index path 
 integer components separated by dots.

 @return A string representing the index path.
 */
- (NSString *)stringValue;

/**
 Get the first path component in the index path.

 @return The first path component in the index path.
 */
- (NSUInteger)firstIndex;

/**
 Get the last path component in the index path.
 
 @return The last path component in the index path.
 */
- (NSUInteger)lastIndex;

@end
