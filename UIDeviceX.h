//
//  UIDeviceX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <UIKit/UIKit.h>

@interface UIDevice (X)

/**
 Get device hardware name.
 
 @return String representing device hadrware name.
 */
+ (NSString *)machineName;

/**
 Get device human readable name.
 
 @return String representing device human readable name.
 */
+ (NSString *)deviceName;

/**
 Check if it's iPhone.
 
 @return YES if iPhone.
 */
+ (BOOL)isPhone;

/**
 Check if it's iPhone with 4 inch display.
 
 @return YES if iPhone with 4 inch display.
 */
+ (BOOL)isPhone4Inch;

/**
 Check if it's iPad.
 
 @return YES if iPad.
 */
+ (BOOL)isPad;

/**
 Check if it's iPad with 8 inch display.
 
 @return YES if iPad.
 */
+ (BOOL)isPad8Inch;

/**
 Check if the current device is iOS Simulator.
 
 @return YES if the device is simulated.
 */
+ (BOOL)isSimulator;

/**
 Check if the device is jailbroken.
 
 @return YES if the device is jailbroken.
 */
+ (BOOL)isJailbroken;

/**
 Get Wi-Fi MAC address.
 
 @return Device Wi-Fi MAC address.
 */
+ (NSString *)WiFiMACAddress;

/**
 Get cellular MAC address.
 
 @return Device cellular MAC address.
 */
+ (NSString *)CellularMACAddress;

/**
 Get a unique device identifier which is identifierForVendor since 7.0 and SHA256 of the device MAC address before.
 
 @return A unique identifier for the device.
 */
+ (NSString *)uniqueIdentifier;

/**
 Get available system RAM.
 
 @return An amount of available system memory in Megabytes.
 */
+ (double)availableMemory;

typedef NS_ENUM(NSUInteger, UIDeviceResolution)
{
    UIDeviceResolutioniPhoneStandard,  //320x480
    UIDeviceResolutioniPhoneStandardHi,  //640x960
    UIDeviceResolutioniPhoneTallerHi,  //640x1136
    UIDeviceResolutioniPadStandard,  //1024x768
    UIDeviceResolutioniPadStandardHi  //2048x1536
};

/**
 Device screen resolution.
 
 @return A constant among enum of device resolutions.
 */
+ (UIDeviceResolution)resolution;

/**
 Check if a specific system version is supported.

 @param version String representing system version, e.g. @"7.0".
 @return YES if running on a system with given version or older.
 */
+ (BOOL)systemVersionIsAtLeast:(NSString *)version;

@end
