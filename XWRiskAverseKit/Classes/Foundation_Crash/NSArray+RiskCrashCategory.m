//
//  NSArray+RiskCrashCategory.m
//  Masonry
//
//  Created by 季振宇 on 2017/12/21.
//

#import "NSArray+RiskCrashCategory.h"

@implementation NSArray (RiskCrashCategory)

+ (void)load {
    
    [self raSwizzle_instanceMethod_class:objc_getClass("NSArray") selector:@selector(objectsAtIndexes:) withSelector:@selector(ra_arrayI_objectsAtIndexes:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSArrayM") selector:@selector(setObject:atIndexedSubscript:) withSelector:@selector(ra_arrayM_setObject:atIndexedSubscript:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSArrayM") selector:@selector(removeObjectAtIndex:) withSelector:@selector(ra_arrayM_removeObjectAtIndex:)];
}

- (id)ra_arrayI_objectsAtIndexes:(NSIndexSet *)indexes {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_arrayI_objectsAtIndexes:indexes];
    }
    
    id ra_obj;
    @try{
        ra_obj = [self ra_arrayI_objectsAtIndexes:indexes];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSRangeException) {
            ra_obj = nil;
        }
    }
    @finally{
        return ra_obj;
    }
}

- (void)ra_arrayM_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_arrayM_setObject:obj atIndexedSubscript:idx];
    }
    
    @try{
        [self ra_arrayM_setObject:obj atIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
    }
    @finally{
    }
}

- (void)ra_arrayM_removeObjectAtIndex:(NSUInteger)index {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        [self ra_arrayM_removeObjectAtIndex:index];
        return;
    }

    @try{
        [self ra_arrayM_removeObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
    }
    @finally{
    }
}

#pragma mark -- =====================  Handle Array NSRangeException  =====================

- (void)handleRangeException:(NSRange)range Array:(NSArray *)array CallbackObj:(id)obj LengthException:(id (^)(NSRange legalRange))exceptionBlock {
    if (range.location > array.count - 1) {
        obj = nil;
    }else if (range.length > array.count - 1 - range.location) {
        if (exceptionBlock) {
            obj = exceptionBlock([self makeLegalRange:range Array:array]);
        }
    }
}

- (NSRange)makeLegalRange:(NSRange)range Array:(NSArray *)array{
    return NSMakeRange(range.location, array.count - 1 - range.location);
}

@end
