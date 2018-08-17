//
//  RaWhiteListUtil.h
//  Pods
//
//  Created by tianxuewei on 2017/12/11.
//

#import <Foundation/Foundation.h>

@interface RaWhiteListUtil : NSObject

/**
 单例

 @return ins
 */
+ (instancetype)shareInstance;

/**
 检查该类是否在白名单内

 @param cls class
 @return yes/no
 */
- (BOOL)isContainsClass:(Class)cls;

/**
 注册拦截白名单，填写的白名单类不会被拦截
 */
- (void)registerWhiteList:(NSArray <NSString *>*)list;

/**
 注册前缀白名单
 ps：例如添加[@"Zb"]进入前缀白名单，则所有Zb为前缀的类都不会被拦截
 */
- (void)registerPreFixWhiteList:(NSArray <NSString *>*)list;

@end
