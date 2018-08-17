//
//  RaCrashAnalyticsUtil.m
//  Pods
//
//  Created by tianxuewei on 2017/12/14.
//

#import "RaCrashAnalyticsUtil.h"


@interface RaCrashAnalyticsUtil()

@property (nonatomic, assign) BOOL isUpdateCrashMsg;

@end

@implementation RaCrashAnalyticsUtil

+ (instancetype)shareInstance{
    static id singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}


- (void)openBugly:(NSString *)appId;{
    [Bugly startWithAppId:appId];
    _isUpdateCrashMsg = YES;
}


- (void)collectCrashWithType:(RaCrashType)type class:(Class)cls selector:(SEL)sel{
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"%@ Crash Happend To Class:%@ Sel:%@", [RaCrashLogUtil ra_crashTypeStringWithType:type], NSStringFromClass(cls), NSStringFromSelector(sel)]
                                };
    
    NSError *error = [NSError errorWithDomain:RaErrorDomain
                                         code:type
                                     userInfo:userInfo];
    
    [RaCrashLogUtil ra_logWithType:type class:cls selector:sel];
    
    
    if (_isUpdateCrashMsg) {
        [Bugly reportError:error];
    }
}

- (void)collectCrashWithType:(RaCrashType)type class:(Class)cls selector:(SEL)sel exception:(NSException *)exc{
    
    [RaCrashLogUtil ra_logWithType:type class:cls selector:sel exception:exc];
    
    if (_isUpdateCrashMsg) {
        [Bugly reportException:exc];
    }
}

- (void)collectCrashWithType:(RaCrashType)type class:(Class)cls selector:(SEL)sel info:(NSString *)info;{
    
    
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"%@ Crash Happend To Class:%@ Sel:%@", [RaCrashLogUtil ra_crashTypeStringWithType:type], NSStringFromClass(cls), NSStringFromSelector(sel)] ,
                                NSLocalizedFailureReasonErrorKey : info
                                };
    
    NSError *error = [NSError errorWithDomain:RaErrorDomain
                                         code:type
                                     userInfo:userInfo];
    
    [RaCrashLogUtil ra_logWithType:type class:cls selector:sel info:info];
    
    if (_isUpdateCrashMsg) {
        [Bugly reportError:error];
    }
}

@end
