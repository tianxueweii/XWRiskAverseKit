//
//  RaCrashLogUtil.h
//  Pods
//
//  Created by tianxuewei on 2017/12/8.
//



#import <Foundation/Foundation.h>


@interface RaCrashLogUtil : NSObject

/**
 log crash msg

 @param type crash type
 @param cls class
 @param sel selector
 */
+ (void)ra_logWithType:(RaCrashType)type class:(Class)cls selector:(SEL)sel;
/**
 log crash msg
 
 @param type crash type
 @param cls class
 @param sel selector
 @param info other info
 */
+ (void)ra_logWithType:(RaCrashType)type class:(Class)cls selector:(SEL)sel info:(NSString *)info;
/**
 log crash msg and exception msg

 @param type crash type
 @param cls class
 @param sel selector
 @param exc exception
 */
+ (void)ra_logWithType:(RaCrashType)type class:(Class)cls selector:(SEL)sel exception:(NSException *)exc;

+ (NSString *)ra_crashTypeStringWithType:(RaCrashType)type;

@end
