//
//  UIDeviceX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIResolution)
{
    UIResolutionUnknown,
    UIResolutioniPhone,     //320x480
    UIResolutioniPhone2X,   //640x960
    UIResolutioniPhoneHi2X, //640x1136
    UIResolutioniPhoneHi3X, //960x1704
    UIResolutioniPad,       //1024x768
    UIResolutioniPad2X      //2048x1536
};

@interface UIDevice (X)

/**
 Get a unique device identifier which is identifierForVendor since 7.0 and SHA256 of the device MAC address before.

 @return A unique identifier for the device.
 */
+ (NSString *)uniqueIdentifier;

/**
 Get device hardware name.
 
 @return String representing the device hardware name.
 */
+ (NSString *)machineName;

/**
 Get device human readable name.
 
 @return String representing the device human readable name.
 */
+ (NSString *)deviceName;

/**
 Check if a specific system version is supported.
 
 @param version String representing system version, e.g. @"8.0".
 @return YES if running on a system with given version or older.
 */
+ (BOOL)systemVersionIsAtLeast:(NSString *)version;

/**
 Device screen resolution.
 
 @return A constant in the enum of device resolutions.
 */
+ (UIResolution)resolution;

/**
 Get available system RAM.
 
 @return An amount of available system memory in Megabytes.
 */
+ (double)availableMemory;

/**
 Check if the current device is iOS Simulator.
 
 @return YES if the device is simulated.
 */
+ (BOOL)isSimulator;

/**
 Check if it's iPhone.
 
 @return YES if iPhone.
 */
+ (BOOL)isPhone;

/**
 Check if it's iPad.
 
 @return YES if iPad.
 */
+ (BOOL)isPad;

/**
 Check if it's iPod.
 
 @return YES if iPod.
 */
+ (BOOL)isPod;

/**
 Check if it's Apple TV.
 
 @return YES if Apple TV.
 */
+ (BOOL)isAppleTV;

/**
 Check if the device is jailbroken.
 
 @return YES if the device is jailbroken.
 */
+ (BOOL)isJailbroken;

/**
 Get Wi-Fi MAC address.
 
 @return Device Wi-Fi MAC address.
 */
+ (NSString *)WiFiMACAddress NS_DEPRECATED_IOS(2_0, 7_0);

/**
 Get cellular MAC address.

 @return Device cellular MAC address.
 */
+ (NSString *)CellularMACAddress NS_DEPRECATED_IOS(2_0, 7_0);

@end
