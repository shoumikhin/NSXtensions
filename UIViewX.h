//
//  UIViewX.h
//
//  Copyright (c) 2012 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <UIKit/UIKit.h>

@interface UIView (X)

/**
 Get a parent view controller.
 
 @return Parent view controller.
 */
- (UIViewController *)viewController;

/**
 Search through the view hierarchy starting from this view and resign the first responder, if found.
 
 @return YES, if the first responder was resigned, NO otherwise.
 */
- (BOOL)findAndResignFirstResponder;

@end
