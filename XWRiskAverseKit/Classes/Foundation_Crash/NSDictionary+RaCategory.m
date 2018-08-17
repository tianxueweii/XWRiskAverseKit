//
//  NSDictionary+RaCategory.m
//  Pods
//
//  Created by tianxuewei on 2017/12/4.
//

#import "NSDictionary+RaCategory.h"

@implementation NSDictionary (RaCategory)

+ (void)load{
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSPlaceholderDictionary") selector:@selector(initWithObjects:forKeys:count:) withSelector:@selector(ra_dicP_initWithObjects:forKeys:count:)];
}

/**
 简写初始化__NSPlaceholderDictionary容错处理
 */
- (instancetype)ra_dicP_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt{
    
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return  [self ra_dicP_initWithObjects:objects forKeys:keys count:cnt];
    }
    
    id ra_instance;
    @try{
        ra_instance = [self ra_dicP_initWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception){
        
       // [RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSInvalidArgumentException) {
            

            id  _Nonnull  newObjects[cnt];
            id  _Nonnull  newkeys[cnt];
            
            for (size_t i = 0; i < cnt; i++) {
                
                if (objects[i]) {
                    newObjects[i] = objects[i];
                }else{
                    newObjects[i] = [NSNull null];
                }
                if (keys[i]) {
                    newkeys[i] = keys[i];
                }else{
                    newkeys[i] = [NSNull null];
                }
            }
            ra_instance = [self ra_dicP_initWithObjects:newObjects forKeys:newkeys count:cnt];
            
        }else{
            ra_instance = @{};
        }
    }
    @finally{
        return ra_instance;
    }
    
}



@end
