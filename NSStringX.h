//
//  NSStringX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <Foundation/Foundation.h>

@interface NSString (X)

/**
 Get a first receiver's substring that matches a given regular expression.

 @param pattern A regular expression pattern to use for substring search.
 @param options Options for the given regular expression pattern.
 @return A receiver's substring that matches a given regular expression, or nil otherwise.
 */
- (NSString *)substringWithRegularExpressionPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options;

/**
 Add percent escapes for special characters.
 
 @return URL encoded string.
  */
- (NSString *)URLEncoded;

/**
 Replace percent escapes with correspnding characters.

 @return URL decoded string.
 */
- (NSString *)URLDecoded;

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
