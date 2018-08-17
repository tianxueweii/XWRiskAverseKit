//
//  NSAttributedString+RaCategory.m
//  Masonry
//
//  Created by 季振宇 on 2017/12/21.
//

#import "NSAttributedString+RaCategory.h"

@implementation NSAttributedString (RaCategory)

+ (void)load {
    
    /************************** NSAttributedString Swizzling **************************/
    
    [self raSwizzle_instanceMethod_class:objc_getClass("NSConcreteAttributedString") selector:@selector(initWithString:) withSelector:@selector(ra_attributedString_initWithString:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("NSConcreteAttributedString") selector:@selector(initWithAttributedString:) withSelector:@selector(ra_attributedString_initWithAttributedString:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("NSConcreteAttributedString") selector:@selector(initWithString:attributes:) withSelector:@selector(ra_attributedString_initWithString:attributes:)];
    
    /************************** NSMutableAttributedString Swizzling **************************/
    
    [self raSwizzle_instanceMethod_class:objc_getClass("NSConcreteMutableAttributedString") selector:@selector(initWithString:) withSelector:@selector(ra_mutableAttributedString_initWithString:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("NSConcreteMutableAttributedString") selector:@selector(initWithString:attributes:) withSelector:@selector(ra_mutableAttributedString_initWithString:attributes:)];
}

#pragma mark -- =====================  NSAttributedString Swizzling Method  =====================

- (id)ra_attributedString_initWithString:(NSString *)str  {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_attributedString_initWithString:str];
    }
    
    id ra_obj;
    @try{
        ra_obj = [self ra_attributedString_initWithString:str];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSInvalidArgumentException) {
            ra_obj = nil;
        }
    }
    @finally{
        return ra_obj;
    }
}

- (id)ra_attributedString_initWithAttributedString:(NSAttributedString *)attrStr {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_attributedString_initWithAttributedString:attrStr];
    }
    
    id ra_obj;
    @try{
        ra_obj = [self ra_attributedString_initWithAttributedString:attrStr];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSInvalidArgumentException) {
            ra_obj = nil;
        }
    }
    @finally{
        return ra_obj;
    }
}

- (id)ra_attributedString_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_attributedString_initWithString:str attributes:attrs];
    }
    
    id ra_obj;
    @try{
        ra_obj = [self ra_attributedString_initWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSInvalidArgumentException) {
            ra_obj = nil;
        }
    }
    @finally{
        return ra_obj;
    }
}

#pragma mark -- =====================  NSMutableAttributedString Swizzling Method  =====================

- (id)ra_mutableAttributedString_initWithString:(NSString *)str  {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_mutableAttributedString_initWithString:str];
    }
    
    id ra_obj;
    @try{
        ra_obj = [self ra_mutableAttributedString_initWithString:str];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSInvalidArgumentException) {
            ra_obj = nil;
        }
    }
    @finally{
        return ra_obj;
    }
}

- (id)ra_mutableAttributedString_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_mutableAttributedString_initWithString:str attributes:attrs];
    }
    
    id ra_obj;
    @try{
        ra_obj = [self ra_mutableAttributedString_initWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSInvalidArgumentException) {
            ra_obj = nil;
        }
    }
    @finally{
        return ra_obj;
    }
}


@end
