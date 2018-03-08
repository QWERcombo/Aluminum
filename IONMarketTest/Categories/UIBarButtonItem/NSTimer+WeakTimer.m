//
//  NSTimer+WeakTimer.m
//  MemoryRecycle
//
//  Created by wanhong on 2018/1/5.
//  Copyright © 2018年 wanhong. All rights reserved.
//

#import "NSTimer+WeakTimer.h"

@implementation NSTimer (WeakTimer)
+ (NSTimer *)weakTimer_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                                block:(void(^)(void))block
                                              repeats:(BOOL)repeats {
    return [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(weakTimerSelector:) userInfo:[block copy] repeats:repeats];
}


+ (void)weakTimerSelector:(NSTimer *)timer{
    void (^block)(void) = timer.userInfo;
    if(block) {
        block();
    }
    
}


@end
