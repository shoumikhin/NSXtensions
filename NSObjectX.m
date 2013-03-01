#import "NSObjectX.h"

#import <objc/runtime.h>

BOOL method_swizzle(Class klass, SEL origSel, SEL altSel)
{
    if (!klass)
        return NO;

    Method __block origMethod, __block altMethod;

    void (^find_methods)() = ^
    {
        unsigned methodCount = 0;
        Method *methodList = class_copyMethodList(klass, &methodCount);

        origMethod = altMethod = NULL;

        if (methodList)
            for (unsigned i = 0; i < methodCount; ++i)
            {
                if (method_getName(methodList[i]) == origSel)
                    origMethod = methodList[i];

                if (method_getName(methodList[i]) == altSel)
                    altMethod = methodList[i];
            }

        free(methodList);
    };

    find_methods();

    if (!origMethod)
    {
        origMethod = class_getInstanceMethod(klass, origSel);

        if (!origMethod)
           return NO;

        if (!class_addMethod(klass, method_getName(origMethod), method_getImplementation(origMethod), method_getTypeEncoding(origMethod)))
           return NO;
     }

    if (!altMethod)
    {
        altMethod = class_getInstanceMethod(klass, altSel);

        if (!altMethod)
            return NO;

        if (!class_addMethod(klass, method_getName(altMethod), method_getImplementation(altMethod), method_getTypeEncoding(altMethod)))
            return NO;
    }

    find_methods();

    if (!origMethod || !altMethod)
        return NO;

    method_exchangeImplementations(origMethod, altMethod);

    return YES;
}

void method_append(Class toClass, Class fromClass, SEL selector)
{
    if (!toClass || !fromClass || !selector)
        return;

    Method method = class_getInstanceMethod(fromClass, selector);

    if (!method)
        return;

    class_addMethod(toClass, method_getName(method), method_getImplementation(method), method_getTypeEncoding(method));
}

void method_replace(Class toClass, Class fromClass, SEL selector)
{
    if (!toClass || !fromClass || ! selector)
        return;

    Method method = class_getInstanceMethod(fromClass, selector);

    if (!method)
        return;

    class_replaceMethod(toClass, method_getName(method), method_getImplementation(method), method_getTypeEncoding(method));
}

@implementation NSObject (X)

+ (void)swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod
{
    method_swizzle(self.class, originalMethod, newMethod);
}

+ (void)appendMethod:(SEL)newMethod fromClass:(Class)aClass
{
    method_append(self.class, aClass, newMethod);
}

+ (void)replaceMethod:(SEL)aMethod fromClass:(Class)aClass
{
    method_replace(self.class, aClass, aMethod);
}

@end
