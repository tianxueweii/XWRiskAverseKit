//
//  NSObject+RaMethodSwizzling.h
//  Pods
//
//  Created by tianxuewei on 2017/12/7.
//

#import <Foundation/Foundation.h>

@interface NSObject (RaMethodSwizzling)

+ (IMP)raSwizzle_class:(Class)class selector:(SEL)origSelector withIMP:(IMP)newIMP ;

+ (void)raSwizzle_instanceMethod_class:(Class)class selector:(SEL)origSelector withSelector:(SEL)newSelector;

+ (void)raSwizzle_classMethod_class:(Class)class selector:(SEL)origSelector withSelector:(SEL)newSelector;

@end
