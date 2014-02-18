//
//  UIApplicationX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
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
 Get application's status bar height.

 @return Status bar current height.
 */
+ (CGFloat)statusBarHeight;

/**
 Get stack backtrace.
 
 @return Application's backtrace for current thread at place where this method is called.
 */
+ (NSArray *)backtrace;

/**
 Call a phone number.
 
 @param phoneNumber Phone number to call.
 @param shouldReturn If YES then display a notification to return to this app.
 */
+ (void)call:(NSString *)phoneNumber andShowReturn:(BOOL)shouldReturn;

/**
 Send an email.
 
 @param address Email address.
 @param shouldReturn If YES then display a notification to return to this app.
 */
+ (void)email:(NSString *)address andShowReturn:(BOOL)shouldReturn;

/**
 Open URL in a default browser.
 
 @param url URL to open.
 @param shouldReturn If YES then display a notification to return to this app.
 */
+ (void)openURL:(NSURL *)url andShowReturn:(BOOL)shouldReturn;

@end