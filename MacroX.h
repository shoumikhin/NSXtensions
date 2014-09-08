//
//  MacroX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

/**
 SHOW_ALERT(title, message, delegate, cancel, other)

 A macro to create and show a UIAlertView with the given title, message,
 deleagate and max two buttons with specified titles.
 */

#define SHOW_ALERT(__title__, __message__, __delegate__, __cancel__, __other__) \
do \
{ \
    [[[UIAlertView alloc] initWithTitle:__title__ message:__message__ delegate:__delegate__ cancelButtonTitle:__cancel__ otherButtonTitles:__other__, nil] show]; \
} \
while(0)

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
    #define SYNTHESIZE_SINGLETON_RETAIN_METHODS
#else
    #define SYNTHESIZE_SINGLETON_RETAIN_METHODS \
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

#define SYNTHESIZE_SINGLETON_FOR_CLASS_WITH_ACCESSOR(classname, accessorMethodName) \
\
+ (instancetype)accessorMethodName \
{ \
    static classname *accessorMethodName##Instance; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, \
    ^ \
    { \
        accessorMethodName##Instance = [super allocWithZone:nil]; \
        accessorMethodName##Instance = [accessorMethodName##Instance init]; \
    }); \
\
    return accessorMethodName##Instance; \
} \
\
+ (instancetype)allocWithZone:(NSZone *)zone \
{ \
    return [self accessorMethodName]; \
} \
\
- (instancetype)copyWithZone:(NSZone *)zone \
{ \
    return self; \
} \
\
SYNTHESIZE_SINGLETON_RETAIN_METHODS

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) SYNTHESIZE_SINGLETON_FOR_CLASS_WITH_ACCESSOR(classname, shared)

/**
 *  Several macros that might be handy to detect if the device is an iPhone, iPad, or iPhone5
 */

#define IS_WIDESCREEN ([[UIScreen mainScreen] bounds].size.height == 568)
#define IS_RETINA ([[UIScreen mainScreen] scale] == 2.0)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && IS_WIDESCREEN)