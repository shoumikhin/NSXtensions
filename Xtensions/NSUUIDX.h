//
//  NSUUIDX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <Foundation/Foundation.h>

@interface NSUUID (X)

/**
 Generate a new UUID.

 @return A unique identifier.
 */
+ (NSString *)makeUUID;

@end
