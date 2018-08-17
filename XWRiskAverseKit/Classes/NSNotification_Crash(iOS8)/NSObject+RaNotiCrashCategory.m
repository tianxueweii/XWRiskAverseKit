//
//  NSObject+RaNotiCrashCategory.m
//  Pods
//
//  Created by tianxuewei on 2017/12/7.
//

#import "NSObject+RaNotiCrashCategory.h"

@implementation NSObject (RaNotiCrashCategory)

+ (void)load{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {

        Class class = [self class];
        [self raSwizzle_instanceMethod_class:class selector:NSSelectorFromString(@"dealloc") withSelector:@selector(ra_noti_dealloc)];
    }
}


#pragma mark - swizzed
- (void)ra_noti_dealloc{
    
    if ([[RaServiceCenter defaultCenter] isWorking] && ![[RaWhiteListUtil shareInstance] isContainsClass:[self class]]) {
        //提前释放所有观察者观察条目
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    [self ra_noti_dealloc];
}

@end
