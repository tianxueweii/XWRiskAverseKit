//
//  NSObject+RaKVOCrashCategory.m
//  Pods
//
//  Created by tianxuewei on 2017/12/12.
//
//  被观察者
//
#import "NSObject+RaKVOCrashCategory.h"
#import "RaKVODelegate.h"



@interface NSObject()

/**
 {
  observer : @{keypath : @[context, ...], ...},
  observer : @{keypath : @[context, ...], ...}
 }
 */
@property (nonatomic, strong) RaKVODelegate *ra_kvoDelegate;


@end

@implementation NSObject (RaKVOCrashCategory)

+ (void)load{
    Class class = [self class];
    
    [self raSwizzle_instanceMethod_class:class selector:@selector(addObserver:forKeyPath:options:context:) withSelector:@selector(ra_addObserver:forKeyPath:options:context:)];
    [self raSwizzle_instanceMethod_class:class selector:@selector(removeObserver:forKeyPath:context:) withSelector:@selector(ra_removeObserver:forKeyPath:context:)];
    [self raSwizzle_instanceMethod_class:class selector:@selector(removeObserver:forKeyPath:) withSelector:@selector(ra_removeObserver:forKeyPath:)];
    [self raSwizzle_instanceMethod_class:class selector:NSSelectorFromString(@"dealloc") withSelector:@selector(ra_kvo_dealloc)];

}


- (void)setRa_kvoDelegate:(RaKVODelegate *)ra_kvoDelegate{
    objc_setAssociatedObject(self, @selector(ra_kvoDelegate), ra_kvoDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RaKVODelegate *)ra_kvoDelegate{
    return objc_getAssociatedObject(self, _cmd);
}


- (void)ra_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{

    //未开启防护或该类在白名单中，则执行原方法并返回
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:[self class]]) {
        [self ra_addObserver:observer forKeyPath:keyPath options:options context:context];
        return;
    }
    
    if (!self.ra_kvoDelegate) {
        self.ra_kvoDelegate = [[RaKVODelegate alloc] init];
    }
    
    if(![self.ra_kvoDelegate registerIfNeedObserver:observer forKeyPath:keyPath context:context]){
        //已经注册观察者信息，报告错误
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_KVO class:[self class] selector:_cmd info:[NSString stringWithFormat:@"keyPath:%@ context:%p 该观察者已经注册",keyPath, context]];
        return;
    }else{
        [self ra_addObserver:self.ra_kvoDelegate forKeyPath:keyPath options:options context:context];
    }
    
}

- (void)ra_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context
{
    //未开启防护或该类在白名单中，则执行原方法并返回
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:[self class]]) {
        [self ra_removeObserver:observer forKeyPath:keyPath context:context];
        return;
    }
    
    if (![self.ra_kvoDelegate deregisterIfNeedObserver:observer forKeyPath:keyPath context:context]){
        //已经注册观察者信息，报告错误
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_KVO class:[self class] selector:_cmd info:[NSString stringWithFormat:@"keyPath:%@ context:%p 该观察者已经移除或未注册",keyPath, context]];
        return;
    }else{
        //正确移除
        [self ra_removeObserver:self.ra_kvoDelegate forKeyPath:keyPath context:context];
    }
}

- (void)ra_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath{
    
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:[self class]]) {
        [self ra_removeObserver:observer forKeyPath:keyPath];
        return;
    }
    
    @try{
        [self ra_removeObserver:observer forKeyPath:keyPath];
    }
    @catch (NSException *exception){
         //[[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_KVO class:[self class] selector:_cmd info:@"未使用 removeObserver:forKeyPath:context: 移除观察者"];
        if(![self.ra_kvoDelegate deregisterIfNeedObserver:observer forKeyPath:keyPath context:nil]){
            //已经注册观察者信息，报告错误
            [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_KVO class:[self class] selector:_cmd info:[NSString stringWithFormat:@"keyPath:%@ context:nil 该观察者已经移除或未注册",keyPath]];
            return;
        }else{
            [self ra_removeObserver:self.ra_kvoDelegate forKeyPath:keyPath context:nil];
        }
    }
    
}

- (void)ra_kvo_dealloc{
    
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:[self class]]) {
        [self ra_kvo_dealloc];
        return;
    }
    
    if (self.ra_kvoDelegate && ([[[UIDevice currentDevice] systemVersion] floatValue] < 11.0)) {
        [self.ra_kvoDelegate.ra_map enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSMutableArray<RaMapInfo *> * _Nonnull obj, BOOL * _Nonnull stop) {
            if (obj.count){
                for (RaMapInfo *info in obj){
                    [self ra_removeObserver:self.ra_kvoDelegate forKeyPath:key context:info.ra_context];
                    [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_KVO class:[self class] selector:_cmd info:[NSString stringWithFormat:@"keyPath:%@ context:%@ 未正确移除",key, info.ra_context]];
                }
            }
        }];
    }
    self.ra_kvoDelegate = nil;
    [self ra_kvo_dealloc];
}


@end
