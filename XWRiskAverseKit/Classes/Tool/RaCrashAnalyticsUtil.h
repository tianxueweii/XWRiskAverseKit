//
//  RaCrashAnalyticsUtil.h
//  Pods
//
//  Created by tianxuewei on 2017/12/14.
//

#import <Foundation/Foundation.h>


@interface RaCrashAnalyticsUtil : NSObject

/**
 单例
 
 @return ins
 */
+ (instancetype)shareInstance;

/**
 打开bugly

 @param appId buglyId
 */
- (void)openBugly:(NSString *)appId;



#pragma mark - 信息收集
/**
 收集crash信息

 @param type crash类型
 @param cls crash发生类
 @param sel crash发生方法
 */
- (void)collectCrashWithType:(RaCrashType)type class:(Class)cls selector:(SEL)sel;

/**
 收集crash信息

 @param type crash类型
 @param cls crash发生类
 @param sel crash发生方法
 @param exc 异常对象
 */
- (void)collectCrashWithType:(RaCrashType)type class:(Class)cls selector:(SEL)sel exception:(NSException *)exc;

/**
 收集crash信息

 @param type crash类型
 @param cls crash发生类
 @param sel crash发生方法
 @param info 相关信息
 */
- (void)collectCrashWithType:(RaCrashType)type class:(Class)cls selector:(SEL)sel info:(NSString *)info;

@end
