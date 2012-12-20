//
//  NSObjectX.h
//
//  Copyright (c) 2012 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <Foundation/Foundation.h>

@interface NSObject (X)

/**
 Exchange methods' implementations.
 
 @param originalMethod Method to exchange.
 @param newMethod Method to exchange.
 */
+ (void)swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod;

/**
 Append a new method to an object.
 
 @param newMethod Method to exchange.
 @param aClass Host class.
 */
+ (void)appendMethod:(SEL)newMethod fromClass:(Class)aClass;

/**
 Replace a method in an object.
 
 @param newMethod Method to exchange.
 @param aClass Host class.
 */
+ (void)replaceMethod:(SEL)aMethod fromClass:(Class)aClass;

@end
