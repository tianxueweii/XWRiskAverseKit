//
//  RaKVODelegate.h
//  Pods
//
//  Created by tianxuewei on 2017/12/13.
//

#import <Foundation/Foundation.h>




@interface RaMapInfo : NSObject

@property (nonatomic, weak) NSObject *ra_observer;
@property (nonatomic) void * ra_context;

@end

@interface RaKVODelegate : NSObject

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMutableArray<RaMapInfo *> *>* ra_map;

- (BOOL)registerIfNeedObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context;
- (BOOL)deregisterIfNeedObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context;

@end
