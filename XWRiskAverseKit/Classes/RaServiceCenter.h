//
//  RaServiceCenter.h
//
//  Created by tianxuewei on 2017/12/8.
//

#import <Foundation/Foundation.h>


#define RaErrorDomain @"com.RiskAverse.Domain"

typedef NS_ENUM(NSUInteger, RaCrashType) {
    RaCrashType_Foundation = -10000,
    RaCrashType_UnrecognizedSelector,
    RaCrashType_NSNotification,
    RaCrashType_KVO,
};

@interface RaServiceCenter : NSObject


/**
 单例
 */
+ (instancetype)defaultCenter;

/**
 开启crash防护
 */
- (void)open;

/**
 开启crash防护，并启动crash上传Bugly

 @param appId Bugly AppId
 */
- (void)openAndStartBuglyWithAppId:(NSString *)appId;

/**
 关闭crash防护
 */
- (void)shut;

/**
 ra是否在工作

 @return bool
 */
- (BOOL)isWorking;

@end
