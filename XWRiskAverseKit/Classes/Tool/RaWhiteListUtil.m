//
//  RaWhiteListUtil.m
//  Pods
//
//  Created by tianxuewei on 2017/12/11.
//

#import "RaWhiteListUtil.h"


@interface RaWhiteListUtil()

@property (nonatomic, copy) NSArray <NSString *>*whiteList;
@property (nonatomic, copy) NSArray <NSString *>*prefixWhiteList;

@end

@implementation RaWhiteListUtil


+ (instancetype)shareInstance{
    static id singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (BOOL)isContainsClass:(Class)cls{
    
    if (self.prefixWhiteList) {
        for (NSString *prefix in self.prefixWhiteList) {
            if([NSStringFromClass(cls) hasPrefix:prefix]){
                return YES;
            }
        }
    }
    
    if (self.whiteList) {
        return [self.whiteList containsObject:NSStringFromClass(cls)];
    }
    return NO;
}


- (void)registerWhiteList:(NSArray<NSString *> *)list{
    self.whiteList = list;
}

- (void)registerPreFixWhiteList:(NSArray<NSString *> *)list{
    self.prefixWhiteList = list;
}

@end
