//
//  UINavigationControllerX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <UIKit/UIKit.h>

@interface UINavigationController (X)

/**
 Animates push action with custom CoreAnimation transitions.
 
 @param viewController A controller to push.
 @param type CATransition type constant.
 @param subtype CATransition subtype constant.
 */
- (void)pushViewController:(UIViewController *)viewController withTransitionType:(NSString *)type subtype:(NSString *)subtype;
- (void)pushViewController:(UIViewController *)viewController withTransitionType:(NSString *)type;

/**
 Animates pop action with custom CoreAnimation transitions.
 
 @param viewController A controller to push.
 @param type CATransition type constant.
 @param subtype CATransition subtype constant.
 @return The view controller that was popped from the stack.
 */
- (UIViewController *)popViewControllerWithTransitionType:(NSString *)type subtype:(NSString *)subtype;
- (UIViewController *)popViewControllerWithTransitionType:(NSString *)type;

/**
 Animates pop to root view controller action with custom CoreAnimation transitions.
 
 @param type CATransition type constant.
 @param subtype CATransition subtype constant.
 @return An array of view controllers representing the items that were popped from the stack.
 */
- (NSArray *)popToRootViewControllerWithTransitionType:(NSString *)type subtype:(NSString *)subtype;
- (NSArray *)popToRootViewControllerWithTransitionType:(NSString *)type;

/**
 Animates pop to view controller action with custom CoreAnimation transitions.
 
 @param type CATransition type constant.
 @param subtype CATransition subtype constant.
 @return An array of view controllers representing the items that were popped from the stack.
 */
- (NSArray *)popToViewController:(UIViewController *)viewController withTransitionType:(NSString *)type subtype:(NSString *)subtype;
- (NSArray *)popToViewController:(UIViewController *)viewController withTransitionType:(NSString *)type;

@end
