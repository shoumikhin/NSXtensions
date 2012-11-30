//
//  NSStringX.h
//
//  Copyright (c) 2012 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <UIKit/UIKit.h>

@interface UIDevice (X)

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
+ (NSString *)uniqueID;

/**
 Get available system RAM.
 
 @return An amount of available system memory in Megabytes.
 */
+ (double)availableMemory;

@end
