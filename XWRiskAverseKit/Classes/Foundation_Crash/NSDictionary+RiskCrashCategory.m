//
//  NSDictionary+RiskCrashCategory.m
//  Masonry
//
//  Created by 季振宇 on 2017/12/21.
//

#import "NSDictionary+RiskCrashCategory.h"

@implementation NSDictionary (RiskCrashCategory)

+ (void)load {
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSDictionaryM") selector:@selector(setObject:forKeyedSubscript:) withSelector:@selector(ra_dicM_setObject:forKey:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSDictionaryM") selector:@selector(removeObjectForKey:) withSelector:@selector(ra_dicM_removeObjectForKey:)];
}

- (void)ra_dicM_setObject:(id)object forKey:(id<NSCopying>)key {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        [self ra_dicM_setObject:object forKey:key];
        return;
    }
    
    @try{
        [self ra_dicM_setObject:object forKey:key];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
    }
    @finally{
    }
}

- (void)ra_dicM_removeObjectForKey:(id)key {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        [self ra_dicM_removeObjectForKey:key];
        return;
    }
    
    @try{
        [self ra_dicM_removeObjectForKey:key];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
    }
    @finally{
    }
}

@end
