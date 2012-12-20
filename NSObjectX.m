#import "NSObjectX.h"

#import <objc/runtime.h>

BOOL method_swizzle(Class klass, SEL origSel, SEL altSel, BOOL forInstance)
{
	if (!klass)
		return NO;
    
	Class iterKlass = (forInstance ? klass : klass->isa);
	Method origMethod = NULL, altMethod = NULL;
	unsigned int methodCount = 0;
	Method *mlist = class_copyMethodList(iterKlass, &methodCount);
    
	if (mlist)
    {
		int i;
        
		for (i = 0; i < methodCount; ++i)
        {
			if (method_getName(mlist[i]) == origSel)
                origMethod = mlist[i];
            
			if (method_getName(mlist[i]) == altSel)
				altMethod = mlist[i];
		}
	}
    
	if (!origMethod)
    {
		origMethod = class_getInstanceMethod(iterKlass, origSel);
        
		if (!origMethod)
			return NO;
        
		if (!class_addMethod(iterKlass, method_getName(origMethod), method_getImplementation(origMethod), method_getTypeEncoding(origMethod)))
			return NO;
	}
    
	if (!altMethod)
    {
		altMethod = class_getInstanceMethod(iterKlass, altSel);
        
		if (!altMethod)
			return NO;
        
		if (!class_addMethod(iterKlass, method_getName(altMethod), method_getImplementation(altMethod), method_getTypeEncoding(altMethod)))
			return NO;
	}
    
	free(mlist);
    
	origMethod = NULL;
	altMethod = NULL;
	methodCount = 0;
	mlist = class_copyMethodList(iterKlass, &methodCount);
    
	if (mlist)
    {
		int i;
        
		for (i = 0; i < methodCount; ++i)
        {
			if (method_getName(mlist[i]) == origSel)
				origMethod = mlist[i];
            
			if (method_getName(mlist[i]) == altSel)
				altMethod = mlist[i];
		}
	}
    
	if (!origMethod || !altMethod)
		return NO;
    
	method_exchangeImplementations(origMethod, altMethod);
    
	free(mlist);
    
	return YES;
}

void method_append(Class aClass, Class bClass, SEL bSel)
{
	if (!aClass || !bClass)
        return;
    
	Method bMethod = class_getInstanceMethod(bClass, bSel);
	class_addMethod(aClass, method_getName(bMethod), method_getImplementation(bMethod), method_getTypeEncoding(bMethod));
}

void method_replace(Class toClass, Class fromClass, SEL aSelector)
{
	if(!toClass || !fromClass)
        return;

	Method aMethod = class_getInstanceMethod(fromClass, aSelector);
	class_replaceMethod(toClass, method_getName(aMethod), method_getImplementation(aMethod), method_getTypeEncoding(aMethod));
}

@implementation NSObject (X)

+ (void)swizzleMethod:(SEL)originalMethod withMethod:(SEL)newMethod
{
	method_swizzle(self.class, originalMethod, newMethod, YES);
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
