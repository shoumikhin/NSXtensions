//
//  NSErrorX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <Foundation/Foundation.h>

@interface NSError (X)

/**
 Get a friendly human-readable localized description by domain and error code.
 
 @return A human-readable localized error description. Returns nil if the domain
         or error code is unknown (not standard values).
 */
- (NSString *)friendlyLocalizedDescription;

/**
 Creates and initializes an NSError object for a given domain and code with
 a friendly human-readable localized description.

 @param domain The error domain.
 @param code The error code for the error.
 @return An NSError object for domain with the specified error code and a
         friendly human-readable localized description. The description is nil
         if the given domain or code is not standard.
 */
+ (instancetype)friendlyErrorWithDomain:(NSString *)domain andCode:(NSInteger)code;

@end
