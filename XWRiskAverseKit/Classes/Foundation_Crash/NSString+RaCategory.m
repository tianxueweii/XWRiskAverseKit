//
//  NSString+RaCategory.m
//  Masonry
//
//  Created by 季振宇 on 2017/12/20.
//

#import "NSString+RaCategory.h"

@implementation NSString (RaCategory)

+ (void)load {

    /************************** NSString Swizzling **************************/
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSCFConstantString") selector:@selector(characterAtIndex:) withSelector:@selector(ra_string_characterAtIndex:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSCFConstantString") selector:@selector(substringFromIndex:) withSelector:@selector(ra_string_substringFromIndex:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSCFConstantString") selector:@selector(substringToIndex:) withSelector:@selector(ra_string_substringToIndex:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSCFConstantString") selector:@selector(substringWithRange:) withSelector:@selector(ra_string_substringWithRange:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSCFConstantString") selector:@selector(stringByReplacingOccurrencesOfString:withString:) withSelector:@selector(ra_string_StringByReplacingOccurrencesOfString:withString:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSCFConstantString") selector:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) withSelector:@selector(ra_string_stringByReplacingOccurrencesOfString:withString:options:range:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSCFConstantString") selector:@selector(stringByReplacingCharactersInRange:withString:) withSelector:@selector(ra_string_stringByReplacingCharactersInRange:withString:)];
    
    /************************** NSMutableString Swizzling **************************/
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSCFString") selector:@selector(replaceCharactersInRange:withString:) withSelector:@selector(ra_mutableString_replaceCharactersInRange:withString:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSCFString") selector:@selector(insertString:atIndex:) withSelector:@selector(ra_mutable_insertString:atIndex:)];
    
    [self raSwizzle_instanceMethod_class:objc_getClass("__NSCFString") selector:@selector(deleteCharactersInRange:) withSelector:@selector(ra_mutable_deleteCharactersInRange:)];
}

#pragma mark -- =====================  NSString Swizzling Method  =====================

- (unichar)ra_string_characterAtIndex:(NSUInteger)index {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_string_characterAtIndex:index];
    }
    
    unichar ra_obj;
    @try{
        ra_obj = [self ra_string_characterAtIndex:index];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        //        if (exception.name == NSRangeException) {
        //            ra_obj = 0x0100;
        //        }
    }
    @finally{
        return ra_obj;
    }
}

- (id)ra_string_substringFromIndex:(NSUInteger)from {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_string_substringFromIndex:from];
    }
    
    id ra_obj;
    @try{
        ra_obj = [self ra_string_substringFromIndex:from];
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

- (id)ra_string_substringToIndex:(NSUInteger)to {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_string_substringToIndex:to];
    }
    
    id ra_obj;
    @try{
        ra_obj = [self ra_string_substringToIndex:to];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSRangeException) {
            ra_obj = [self ra_string_substringToIndex:self.length - 1];
        }
    }
    @finally{
        return ra_obj;
    }
}

- (id)ra_string_substringWithRange:(NSRange)range {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_string_substringWithRange:range];
    }
    
    id ra_obj;
    @try{
        ra_obj = [self ra_string_substringWithRange:range];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSRangeException) {
            __weak typeof(self) weakSelf = self;
            [self handleRangeException:range String:self CallbackObj:ra_obj LengthException:^id(NSRange legalRange) {
                return [weakSelf ra_string_substringWithRange:legalRange];
            }];
        }
    }
    @finally{
        return ra_obj;
    }
}

- (id)ra_string_StringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_string_StringByReplacingOccurrencesOfString:target withString:replacement];
    }

    id ra_obj;
    @try{
        ra_obj = [self ra_string_StringByReplacingOccurrencesOfString:target withString:replacement];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSInvalidArgumentException) {
            ra_obj = self;
        }
    }
    @finally{
        return ra_obj;
    }
}

- (id)ra_string_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_string_stringByReplacingOccurrencesOfString:target
                                                         withString:replacement
                                                            options:options
                                                              range:searchRange];
    }
    
    id ra_obj;
    @try{
        ra_obj = [self ra_string_stringByReplacingOccurrencesOfString:target
                                                           withString:replacement
                                                              options:options
                                                                range:searchRange];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSInvalidArgumentException) {
            ra_obj = self;
        }else if (exception.name == NSRangeException) {
            if (searchRange.location >= self.length) {
                ra_obj = self;
            }else if (searchRange.length >= self.length) {
                ra_obj = [self ra_string_stringByReplacingOccurrencesOfString:target
                                                                  withString:replacement
                                                                     options:options
                                                                       range:NSMakeRange(searchRange.location, self.length - 1)];
            }
        }
    }
    @finally{
        return ra_obj;
    }
}

- (id)ra_string_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_string_stringByReplacingCharactersInRange:range withString:replacement];
    }
    
    id ra_obj;
    @try{
        ra_obj = [self ra_string_stringByReplacingCharactersInRange:range withString:replacement];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSInvalidArgumentException) {
            ra_obj = self;
        }else if (exception.name == NSRangeException) {
            if (range.location >= self.length) {
                ra_obj = self;
            }else if (range.length >= self.length) {
                ra_obj = [self ra_string_stringByReplacingCharactersInRange:NSMakeRange(range.location, self.length - 1)
                                                                 withString:replacement];
            }
        }
    }
    @finally{
        return ra_obj;
    }
}

#pragma mark -- =====================  NSMutableString Swizzling Method  =====================

- (id)ra_mutableString_replaceCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_mutableString_replaceCharactersInRange:range withString:replacement];
    }
    
    id ra_obj;
    @try{
        ra_obj = [self ra_mutableString_replaceCharactersInRange:range withString:replacement];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSInvalidArgumentException) {
            ra_obj = self;
        }else if (exception.name == NSRangeException) {
            if (range.location >= self.length) {
                ra_obj = self;
            }else if (range.length >= self.length) {
                ra_obj = [self ra_mutableString_replaceCharactersInRange:NSMakeRange(range.location, self.length - 1)
                                                              withString:replacement];
            }
        }
    }
    @finally{
        return ra_obj;
    }
}

- (void)ra_mutable_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        [self ra_mutable_insertString:aString atIndex:loc];
        return;
    }
    
    @try{
        [self ra_mutable_insertString:aString atIndex:loc];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
    }
    @finally{
    }
}

- (id)ra_mutable_deleteCharactersInRange:(NSRange)range {
    Class class = [self class];
    if (![[RaServiceCenter defaultCenter] isWorking] || [[RaWhiteListUtil shareInstance] isContainsClass:class]) {
        return [self ra_mutable_deleteCharactersInRange:range];
    }
    
    id ra_obj;
    @try{
        ra_obj = [self ra_mutable_deleteCharactersInRange:range];
    }
    @catch (NSException *exception) {
        //[RaCrashLogUtil ra_logWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        [[RaCrashAnalyticsUtil shareInstance] collectCrashWithType:RaCrashType_Foundation class:class selector:_cmd exception:exception];
        if (exception.name == NSRangeException) {
            __weak typeof(self) weakSelf = self;
            [self handleRangeException:range String:self CallbackObj:ra_obj LengthException:^id(NSRange legalRange) {
                return [weakSelf ra_mutable_deleteCharactersInRange:legalRange];
            }];
        }
    }
    @finally{
        return ra_obj;
    }
}

#pragma mark -- =====================  Handle String NSRangeException  =====================

- (void)handleRangeException:(NSRange)range String:(NSString *)string CallbackObj:(id)obj LengthException:(id (^)(NSRange legalRange))exceptionBlock {
    if (range.location > string.length - 1) {
        obj = nil;
    }else if (range.length > string.length - 1 - range.location) {
        if (exceptionBlock) {
            obj = exceptionBlock([self makeLegalRange:range String:string]);
        }
    }
}

- (NSRange)makeLegalRange:(NSRange)range String:(NSString *)string{
    return NSMakeRange(range.location, string.length - 1 - range.location);
}

@end


