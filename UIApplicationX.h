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
 Makes a call.
 
 @param phoneNumber Phone number to call.
 @param shouldSchedule Schedule a returning local notification or not.
 */
+ (void)call:(NSString *)phoneNumber andScheduleReturnNotification:(BOOL)shouldSchedule;

/**
 Sends an e-mail.
 
 @param emailAddress E-mail address of receiver.
 @param shouldSchedule Schedule a returning local notification or not.
 */
+ (void)mail:(NSString *)emailAddress andScheduleReturnNotification:(BOOL)shouldSchedule;

/**
 Opens site link in Web-browser.
 
 @param siteAddress Site link to open.
 @param shouldSchedule Schedule a returning local notification or not.
 */
+ (void)openSite:(NSString *)siteAddress andScheduleReturnNotification:(BOOL)shouldSchedule;


@end