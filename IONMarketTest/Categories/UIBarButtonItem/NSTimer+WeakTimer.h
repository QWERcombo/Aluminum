//
//  NSTimer+WeakTimer.h
//  MemoryRecycle
//
//  Created by wanhong on 2018/1/5.
//  Copyright © 2018年 wanhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (WeakTimer)

+ (NSTimer *)weakTimer_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)(void))block
                                       repeats:(BOOL)repeats;

@end
