//
//  RaKVODelegate.m
//  Pods
//
//  Created by tianxuewei on 2017/12/13.
//

#import "RaKVODelegate.h"


@implementation RaMapInfo
@end

@implementation RaKVODelegate


- (NSMutableDictionary<NSString *,NSMutableArray<RaMapInfo *> *> *)ra_map{
    if (!_ra_map) {
        _ra_map = [NSMutableDictionary dictionary];
    }
    return _ra_map;
}

- (BOOL)registerIfNeedObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context;{
    
    NSMutableArray *infoArray = self.ra_map[keyPath] ?: [NSMutableArray array];
    
    if (infoArray.count) {
        for (RaMapInfo *info in infoArray) {
            if ((info.ra_observer == observer) && (info.ra_context == context)) {
                return NO;
            }
        }
    }
    
    RaMapInfo *newInfo = [RaMapInfo new];
    newInfo.ra_observer = observer;
    newInfo.ra_context = context;
    
    [infoArray addObject:newInfo];
    
    [self.ra_map setObject:infoArray forKey:keyPath];
    
    return YES;
}

- (BOOL)deregisterIfNeedObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context;{
    
    NSMutableArray *infoArray = self.ra_map[keyPath];
    __block BOOL isNeed = NO;
    
    [infoArray enumerateObjectsUsingBlock:^(RaMapInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ((obj.ra_observer == observer) &&
            (obj.ra_context == context)) {
            
            [infoArray removeObject:obj];
            //如果info不再有数据，则从map移除该keypath
            if (!infoArray.count) {
                [self.ra_map removeObjectForKey:keyPath];
            }
            *stop = YES;
            isNeed = YES;
        }
    }];
    
    return isNeed;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
   //转发消息
    for (RaMapInfo *info in self.ra_map[keyPath]) {
        if (info.ra_observer) {
            [info.ra_observer observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
}



@end
