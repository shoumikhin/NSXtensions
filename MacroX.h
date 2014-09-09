//
//  MacroX.h
//
//  Copyright (c) 2014 Anthony Shoumikhin. All rights reserved under MIT license.
//  mailto:anthony@shoumikh.in
//

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

#define SYNTHESIZE_SINGLETON_FOR_CLASS_WITH_ACCESSOR(_classname_, _accessor_) \
\
+ (instancetype)_accessor_ \
{ \
    static _classname_ *_accessor_##Instance; \
    static dispatch_once_t once; \
    dispatch_once(&once, \
    ^ \
    { \
        _accessor_##Instance = [[super allocWithZone:nil] init]; \
    }); \
\
    return _accessor_##Instance; \
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
SYNTHESIZE_SINGLETON_RETAIN_METHODS

#define SYNTHESIZE_SINGLETON_FOR_CLASS(_classname_) SYNTHESIZE_SINGLETON_FOR_CLASS_WITH_ACCESSOR(_classname_, shared)
