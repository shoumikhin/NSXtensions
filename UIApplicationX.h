//
//  UIApplicationX.h
//
//  Copyright (c) 2012 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <UIKit/UIKit.h>

@interface UIApplication (X)

/**
 Application's bundle identifier.
 
 @return Application's bundle identifier.
 */
+ (NSString *)identifier;

/**
 Application's bundle version.
 
 @return Application's bundle version.
 */
+ (NSString *)version;

/**
 Get application's frame regardless current orientation.
 
 @return Frame of the main window.
 */
+ (CGRect)frame;

/**
 Get stack backtrace.
 
 @return Application's backtrace for current thread at place where this method is called.
 */
+ (NSArray *)backtrace;

@end