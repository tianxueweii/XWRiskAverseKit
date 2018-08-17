//
//  NSObject+RaUnrecognizedSELCategory.m
//  Pods
//
//  Created by tianxuewei on 2017/12/7.
//

#import "NSObject+RaUnrecognizedSELCategory.h"



@implementation NSObject (RaUnrecognizedSELCategory)

+ (void)load{
    [self raSwizzle_instanceMethod_class:[self class] selector:@selector(forwardingTargetForSelector:) withSelector:@selector(ra_forwardingTargetForSelector:)];
    
}

/**
 检查sel是否在class中被实现，最高检查到NSObject

 @param cls 检查的类
 @param sel 方法
 @return yes/no
 */
+ (BOOL)ra_isClass:(Class)cls overrideSelector:(SEL)sel{
   
    if (cls == [NSObject class]) {
        return NO;
    }
    
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(cls, &count);
    
    //此处遍历方法可以优化
    for (size_t i = 0; i < count; i++) {
        
        Method temp = methodList[i];
        SEL selName = method_getName(temp);
        if([NSStringFromSelector(sel) isEqualToString:NSStringFromSelector(selName)]){
            return YES;
        }
    }
    return [self ra_isClass:[cls superclass] overrideSelector:sel];
}

/**
 判断是否系统类

 @param cls 类
 @return yes/no
 */
- (BOOL)ra_isSystemClass:(Class)cls{
    NSString *className = NSStringFromClass(cls);
    return [className hasPrefix:@"_"];
}

- (id)ra_forwardingTargetForSelector:(SEL)aSelector{
    
    //获取当前转发对象
    id ra_obj = [self ra_forwardingTargetForSelector:aSelector];
    Class class = [self class];
    
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return ra_obj;
    }
    
    //对象为空，则构建新的转发对象
    if (!ra_obj) {
        
        //未复写完整转发则报告错误
        if(![[self class] ra_isClass:[self class] overrideSelector:@selector(forwardInvocation:)]){
            //统计错误
            [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_UnrecognizedSelector class:class selector:aSelector];
            //将消息转发到靶对象
            Class RaTargetCls = NSClassFromString(@"RaTargetCls");
            if (!RaTargetCls)
            {
                RaTargetCls = objc_allocateClassPair([NSObject class], "RaTargetCls", 0);
                objc_registerClassPair(RaTargetCls);
            }
            class_addMethod(RaTargetCls, aSelector, imp_implementationWithBlock(^int(){
                return 0;
            }),[NSStringFromSelector(aSelector) UTF8String]);
            
            return [RaTargetCls new];
        }
    }
    return ra_obj;
}


@end
