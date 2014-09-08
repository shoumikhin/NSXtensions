//
//  UIViewX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#import <UIKit/UIKit.h>

@interface UIView (X)

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic, readonly) CGFloat bottom;
@property (nonatomic, readonly) CGFloat right;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;


/**
 Get a parent view controller.
 
 @return Parent view controller.
 */
- (UIViewController *)viewController;

/**
 Get a superview of specific class.
 
 @param aClass Specific class to search.
 @return Superview of class specified.
 */
- (UIView *)superviewOfClass:(Class)aClass;

/**
 Search through the view hierarchy starting from this view and resign the first responder, if found.
 
 @return YES, if the first responder was resigned, NO otherwise.
 */
- (BOOL)resignFirstResponderRecursively;

/**
 Move view to a new position with animaton.
 
 @param destination New coordinates for view's frame origin.
 @param duration Duration of animation in seconds.
 @param options Animation options.
 */
- (void)moveTo:(CGPoint)destination duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options;

@end
