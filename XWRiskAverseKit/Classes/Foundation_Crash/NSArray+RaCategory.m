//
//  NSArray+RaCategory.m
//  Pods
//
//  Created by tianxuewei on 2017/12/5.
//

#import "NSArray+RaCategory.h"

@implementation NSArray (RaCategory)

+ (void)load{
    
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSArrayI") selector:@selector(objectAtIndex:) withSelector:@selector(ra_arrayI_objectAtIndex:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSArrayI") selector:@selector(objectAtIndexedSubscript:) withSelector:@selector(ra_arrayI_objectAtIndexedSubscript:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSPlaceholderArray") selector:@selector(initWithObjects:count:) withSelector:@selector(ra_arrayP_initWithObjects:count:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSArrayM") selector:@selector(objectAtIndex:) withSelector:@selector(ra_arrayM_objectAtIndex:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSArrayM") selector:@selector(objectAtIndexedSubscript:) withSelector:@selector(ra_arrayM_objectAtIndexedSubscript:)];
   
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSArrayM") selector:@selector(insertObject:atIndex:) withSelector:@selector(ra_arrayM_insertObject:atIndex:)];
    
}






- (id)ra_arrayI_objectAtIndex:(NSUInteger)index{
    
    Class class = [self class];
    
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_arrayI_objectAtIndex:index];
    }
    
    id ra_obj;
    @try{
        ra_obj = [self ra_arrayI_objectAtIndex:index];
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

- (id)ra_arrayI_objectAtIndexedSubscript:(NSUInteger)idx{
    
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_arrayI_objectAtIndexedSubscript:idx];
    }
    
    id ra_obj;
    @try{
        ra_obj = [self ra_arrayI_objectAtIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSRangeException) {
            ra_obj = nil;
        }
    }
    @finally{
        return ra_obj;
    }
}

- (instancetype)ra_arrayP_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt{
    
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_arrayP_initWithObjects:objects count:cnt];
    }

    
    id ra_instance;
    @try{
        ra_instance = [self ra_arrayP_initWithObjects:objects count:cnt];
    }
    @catch (NSException *exception){
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSInvalidArgumentException) {
            
            id  _Nonnull __unsafe_unretained newObjects[cnt];
        
            for (size_t i = 0; i < cnt; i++) {
                if (objects[i]) {
                    newObjects[i] = objects[i];
                }else{
                    newObjects[i] = [NSNull null];
                }
            }
            ra_instance = [self ra_arrayP_initWithObjects:newObjects count:cnt];
        }else{
            ra_instance = @[];
        }
    }
    @finally{
        return ra_instance;
    }
}



/**
 插入对象检查
 */
- (void)ra_arrayM_insertObject:(id)anObject atIndex:(NSUInteger)index{
    
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        [self ra_arrayM_insertObject:anObject atIndex:index];
        return;
    }
    
    @try{
        [self ra_arrayM_insertObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        //不考虑越界和传空同时出现的情况
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSRangeException) {
            if (index > self.count) {
                index = self.count;
            }
            [self ra_arrayM_insertObject:anObject atIndex:index];
        }
        if (exception.name == NSInvalidArgumentException) {
            anObject = [NSNull null];
            [self ra_arrayM_insertObject:anObject atIndex:index];
        }
    }
}

/**
 获取对象越界检查
 */
- (id)ra_arrayM_objectAtIndex:(NSUInteger)index{
    
    if (![[RaServiceCenter defaultCenter] isWorking]) {
        
        return [self ra_arrayM_objectAtIndex:index];
    }
    id ra_obj;
    @try{
        ra_obj = [self ra_arrayM_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:[self class] selector:_cmd exception:exception];
        if (exception.name == NSRangeException) {
            ra_obj = nil;
        }
    }
    @finally{
        return ra_obj;
    }
}

- (id)ra_arrayM_objectAtIndexedSubscript:(NSUInteger)idx{
    
    
    if (![[RaServiceCenter defaultCenter] isWorking]) {
        return [self ra_arrayM_objectAtIndexedSubscript:idx];
    }
    id ra_obj;
    @try{
        ra_obj = [self ra_arrayM_objectAtIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:[self class] selector:_cmd exception:exception];
        ra_obj = nil;
    }
    @finally{
        return ra_obj;
    }
}
@end
