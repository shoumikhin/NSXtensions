//
//  NSDateX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <Foundation/Foundation.h>

@interface NSDate (X)

/**
 Get milliseconds passed since Jan, 1, 1970.
 */
+ (unsigned long long)millisecondsSince1970;

/**
 Get seconds passed after a given date.
 
 @param date Relative date.
 */
- (NSInteger)secondsAfterDate:(NSDate *)date;

/**
 Get minutes passed after a given date.
 
 @param date Relative date.
 */
- (NSInteger)minutesAfterDate:(NSDate *)date;

/**
 Get the number of minutes remaining to a given date.
 
 @param date Relative date.
 */
- (NSInteger)minutesBeforeDate:(NSDate *)date;

/**
 Get hours passed after a given date.
 
 @param date Relative date.
 */
- (NSInteger)hoursAfterDate:(NSDate *)date;

/**
 Get the number of hours remaining to a given date.
 
 @param date Relative date.
 */
- (NSInteger)hoursBeforeDate:(NSDate *)date;

/**
 Get days passed after a given date.
 
 @param date Relative date.
 */
- (NSInteger)daysAfterDate:(NSDate *)date;

/**
 Get the number of days remaining to a given date.
 
 @param date Relative date.
 */
- (NSInteger)daysBeforeDate:(NSDate *)date;

@end