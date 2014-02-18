//
//  UIAlertViewX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <UIKit/UIKit.h>

typedef void (^UIAlertViewCompletionBlock)(UIAlertView *alertView, NSInteger buttonIndex);

@interface UIAlertView (X)

/**
 Display an alert and execute a completion block when any button is tapped.

 @param completionBlock A block to execute when alert is dismissed.
 */
- (void)showWithCompletion:(UIAlertViewCompletionBlock)completionBlock;

@end
