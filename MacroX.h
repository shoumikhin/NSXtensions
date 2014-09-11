//
//  MacroX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

#define _QUOTE_(__text__) #__text__

/**
 TODO(message)

 A macro to mark a line of code with a "TODO" prefixed compiler warning.
 */

#define TODO(_text_) _Pragma(_QUOTE_(message("TODO: "_text_)))

/**
 FIXME(message)

 A macro to mark a line of code with a "FIXME" prefixed compiler warning.
 */

#define FIXME(_text_) _Pragma(_QUOTE_(message("FIXME: "_text_)))

/**
 SHOW_ALERT(title, message, delegate, cancelButtonTitle, ...)

 A macro to create and show a UIAlertView with the given title, message,
 deleagate and arbitrary number of buttons with specified titles.
 */

#define SHOW_ALERT(_title_, _message_, _delegate_, _cancelButtonTitle_, ...) \
({ \
    UIAlertView *_; \
    [_ = [UIAlertView.alloc initWithTitle:(_title_) message:(_message_) delegate:(_delegate_) cancelButtonTitle:(_cancelButtonTitle_) otherButtonTitles:__VA_ARGS__, nil] show], _; \
})

/**
 SYNTHESIZE_STATIC_PROPERTY(type, name, ...)

 A macro to rapidly implement a read-only static property of a given type and name.
 */

#define SYNTHESIZE_STATIC_PROPERTY(_type_, _name_, ...) \
+ (_type_)_name_ \
{ \
    static _type_ _name_; \
    static dispatch_once_t once; \
\
    dispatch_once(&once, \
    ^ \
    { \
        _type_ (^evaluate)() = ^{ do { __VA_ARGS__ } while(0); }; \
        _name_ = evaluate(); \
    }); \
\
    return _name_; \
}

/**
    SYNTHESIZE_SINGLETON_FOR_CLASS(classname)

    A macro to synthesize singleton boilerplate code for a given class.
    Place it under the @implementation section of the class.
    A single instance by default is accessible via `shared` method.
    At the first time it calls a default `init` constructor and creates an
    instance. Each next time the same instance is returned.
 */

#import <objc/runtime.h>

#if __has_feature(objc_arc)
    #define _SYNTHESIZE_SINGLETON_RETAIN_METHODS_
#else
    #define _SYNTHESIZE_SINGLETON_RETAIN_METHODS_ \
- (instancetype)retain \
{ \
    return self; \
} \
\
- (NSUInteger)retainCount \
{ \
    return NSUIntegerMax; \
} \
\
- (oneway void)release {} \
\
- (instancetype)autorelease \
{ \
    return self; \
}
#endif

#define _SYNTHESIZE_SINGLETON_FOR_CLASS_WITH_ACCESSOR_(_classname_, _accessor_) \
\
+ (instancetype)_accessor_ \
{ \
    static _classname_ *_accessor_; \
    static dispatch_once_t once; \
\
    dispatch_once(&once, ^{ _accessor_ = [[super allocWithZone:nil] init]; }); \
\
    return _accessor_; \
} \
\
+ (instancetype)allocWithZone:(NSZone *)zone \
{ \
    return self._accessor_; \
} \
\
- (instancetype)copyWithZone:(NSZone *)zone \
{ \
    return self; \
} \
\
_SYNTHESIZE_SINGLETON_RETAIN_METHODS_

#define SYNTHESIZE_SINGLETON_FOR_CLASS(_classname_) _SYNTHESIZE_SINGLETON_FOR_CLASS_WITH_ACCESSOR_(_classname_, shared)

/**
 *  Several macros that might be handy to detect if the device is an iPhone, iPad, or iPhone5
 */

#define IS_WIDESCREEN ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_RETINA ([[UIScreen mainScreen] scale] == 2.0)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && IS_WIDESCREEN)

/**
 *  Determining the orientation of the device
 */
#define LANDSCAPE UIInterfaceOrientationIsLandscape(self.interfaceOrientation)
#define LANDSCAPE_RIGHT [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft
#define LANDSCAPE_LEFT [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight
#define PORTRAIT UIInterfaceOrientationIsPortrait(self.interfaceOrientation)
#define PORTRAIT_REVERSE [UIDevice currentDevice].orientation == UIDeviceOrientationPortraitUpsideDown

/**
 *  Programmatically detect which iOS version is device running on:
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)