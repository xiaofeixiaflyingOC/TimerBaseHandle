//
//  TimerBaseHandleHelper.h
//  TimerBaseHandle
//
//  Created by shengxin on 2019/4/15.
//  Copyright © 2019 shengxin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimerBaseHandleHelper : NSObject
@property (nonatomic, strong, readonly) NSThread *timerThread;
- (void)startTimer;
- (void)stopTimer;
@end

NS_ASSUME_NONNULL_END
