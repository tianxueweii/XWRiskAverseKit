//
//  RaServiceCenter.m
//  Masonry
//
//  Created by tianxuewei on 2017/12/8.
//

#import "RaServiceCenter.h"


@interface RaServiceCenter(){
    BOOL isWorking;
}
@end

@implementation RaServiceCenter

+ (instancetype)defaultCenter{
    static id singletonCenter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonCenter = [[self alloc] init];
    });
    return singletonCenter;
}

- (void)open{
    isWorking = YES;
}

- (void)shut{
    isWorking = NO;
}

- (BOOL)isWorking{
    return isWorking;
}

- (void)openAndStartBuglyWithAppId:(NSString *)appId{
    [self open];
    [[RaCrashAnalyticsUtil shareInstance] openBugly:appId];
}

@end
