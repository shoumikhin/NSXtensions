//
//  NSStringX.h
//
//  Copyright (c) 2013 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <Foundation/Foundation.h>

@interface NSString (X)

/**
 Get MD5 hash.
 
 @return MD5 hash sum of own contents.
 */
- (NSString *)MD5;

/**
 Get SHA256 hash.
 
 @return SHA256 hash sum of own contents.
 */
- (NSString *)SHA256;

/**
 Get a string which has dashes according to pretty UUID representation.
 
 @return A copy of a string with dashes according to pretty UUID representation or empty string, if initial string lenght is not equal to 32.
 */
- (NSString *)likeUUID;

@end
