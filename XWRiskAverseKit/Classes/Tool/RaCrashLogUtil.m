//
//  RaCrashLogUtil.m
//  Pods
//
//  Created by tianxuewei on 2017/12/8.
//

#import "RaCrashLogUtil.h"

#ifdef DEBUG
#define RaLog(...) NSLog(@"\n************ RiskAverse ************\n%@\n************     End    ************\n",[NSString stringWithFormat:__VA_ARGS__])
#else
#define RaLog(...)
#endif


@implementation RaCrashLogUtil


+ (void)ra_logWithType:(RaCrashType)type class:(Class)cls selector:(SEL)sel{
    RaLog(@"Export: %@ Crash \nClass:%@ Sel:%@",
          [self ra_crashTypeStringWithType:type],
          NSStringFromClass(cls),
          NSStringFromSelector(sel));
    
    //RaCrashType_KVO
}


+ (void)ra_logWithType:(RaCrashType)type class:(Class)cls selector:(SEL)sel info:(NSString *)info;{
    RaLog(@"Export: %@ Crash \nClass:%@ Sel:%@ \nInfo:%@",
          [self ra_crashTypeStringWithType:type],
          NSStringFromClass(cls),
          NSStringFromSelector(sel),
          info);
}


+ (void)ra_logWithType:(RaCrashType)type class:(Class)cls selector:(SEL)sel exception:(NSException *)exc{
    RaLog(@"Export: %@ Crash \nClass:%@ Sel:%@ \nExceptionName:%@ Reason:%@",
          [self ra_crashTypeStringWithType:type],
          NSStringFromClass(cls),
          NSStringFromSelector(sel),
          exc.name,
          exc.reason);
}



+ (NSString *)ra_crashTypeStringWithType:(RaCrashType)type{
    switch (type) {
        case RaCrashType_Foundation:
            return @"Foundation";
            
        case RaCrashType_NSNotification:
            return @"NSNotification";
            
        case RaCrashType_UnrecognizedSelector:
            return @"Unrecognized Selector";
        
        case RaCrashType_KVO:
            return @"KVO";
    }
}

@end
