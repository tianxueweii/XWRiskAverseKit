//
//  NSObject+RaMethodSwizzling.m
//  Pods
//
//  Created by tianxuewei on 2017/12/7.
//

#import "NSObject+RaMethodSwizzling.h"

@implementation NSObject (RaMethodSwizzling)

+ (IMP)raSwizzle_class:(Class)class selector:(SEL)origSelector
                    withIMP:(IMP)newIMP {
    
    Method origMethod = class_getInstanceMethod(class,
                                                origSelector);
    IMP origIMP = method_getImplementation(origMethod);
    
    if(!class_addMethod(self, origSelector, newIMP,
                        method_getTypeEncoding(origMethod)))
    {
        method_setImplementation(origMethod, newIMP);
    }
    
    return origIMP;
}

+ (void)raSwizzle_instanceMethod_class:(Class)class selector:(SEL)origSelector withSelector:(SEL)newSelector{
    
    Method oriMethod = class_getInstanceMethod(class, origSelector);
    Method newMethod = class_getInstanceMethod(class, newSelector);
    method_exchangeImplementations(oriMethod, newMethod);
}


+ (void)raSwizzle_classMethod_class:(Class)class selector:(SEL)origSelector withSelector:(SEL)newSelector{
    
    Method oriMethod = class_getClassMethod(class, origSelector);
    Method newMethod = class_getClassMethod(class, newSelector);
    method_exchangeImplementations(oriMethod, newMethod);
}

@end
