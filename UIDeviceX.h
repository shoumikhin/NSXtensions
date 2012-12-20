//
//  UIDeviceX.h
//
//  Copyright (c) 2012 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <UIKit/UIKit.h>

@interface UIDevice (X)

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
 Get a unique device identifier which is computed as SHA256 hash of the device MAC address.
 
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
 Device resolution.
 
 @return A constant among enum of device resolutions.
 */
+ (UIDeviceResolution)resolution;

@end
