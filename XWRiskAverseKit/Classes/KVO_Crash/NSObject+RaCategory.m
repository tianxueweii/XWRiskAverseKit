//
//  NSObject+RaCategory.m
//  Masonry
//
//  Created by 季振宇 on 2017/12/21.
//

#import "NSObject+RaCategory.h"

@implementation NSObject (RaCategory)

+ (void)load {
    
//    [self raSwizzle_instanceMethod_class:[self class] selector:@selector(setValue:forKey:) withSelector:@selector(ra_object_setValue:forKey:)];
    
    [self raSwizzle_instanceMethod_class:[self class] selector:@selector(setValue:forKeyPath:) withSelector:@selector(ra_object_setValue:forKeyPath:)];
    
    [self raSwizzle_instanceMethod_class:[self class] selector:@selector(setValue:forUndefinedKey:) withSelector:@selector(ra_object_setValue:forUndefinedKey:)];
    
    [self raSwizzle_instanceMethod_class:[self class] selector:@selector(setValuesForKeysWithDictionary:) withSelector:@selector(ra_object_setValuesForKeysWithDictionary:)];
}

- (void)ra_object_setValue:(id)value forKey:(NSString *)key {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        [self ra_object_setValue:value forKey:key];
        return;
    }
    
    if (key == nil) {
        key = @"";
    }
    
    @try{
        [self ra_object_setValue:value forKey:key];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        
    }
    @finally{
    }
}

- (void)ra_object_setValue:(id)value forKeyPath:(NSString *)keyPath {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        [self ra_object_setValue:value forKeyPath:keyPath];
        return;
    }
    
    @try{
        [self ra_object_setValue:value forKeyPath:keyPath];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
    }
    @finally{
    }
}

- (void)ra_object_setValue:(id)value forUndefinedKey:(NSString *)key {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        [self ra_object_setValue:value forUndefinedKey:key];
        return;
    }
    
    @try{
        [self ra_object_setValue:value forUndefinedKey:key];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
    }
    @finally{
    }
}

- (void)ra_object_setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        [self ra_object_setValuesForKeysWithDictionary:keyedValues];
        return;
    }
    
    @try{
        [self ra_object_setValuesForKeysWithDictionary:keyedValues];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
    }
    @finally{
    }
}

////kvc中设置的key为nil时自动响应此方法
//-(id)valueForUndefinedKey:(NSString *)key{
//    return nil;
//}

@end
