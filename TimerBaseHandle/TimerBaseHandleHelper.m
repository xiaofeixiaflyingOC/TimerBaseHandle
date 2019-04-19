//
//  TimerBaseHandleHelper.m
//  TimerBaseHandle
//
//  Created by shengxin on 2019/4/15.
//  Copyright © 2019 shengxin. All rights reserved.
//

#import "TimerBaseHandleHelper.h"

@interface TimerBaseHandleHelper()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic) CFRunLoopObserverRef observer;
@property (nonatomic) CFRunLoopRef runloop;
@property (nonatomic) dispatch_source_t source;

@end

@implementation TimerBaseHandleHelper

- (void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)startTimer{
//    [self startNSTimer];
    [self startDispatchSource];
}

- (void)startNSTimer{
    if (self.timer!=nil&&self.timer.valid==NO) {
        [self.timer invalidate];
    }
    _timerThread = [NSThread currentThread];
    NSLog(@"%@", [NSThread currentThread]);
    self.count = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"%@",@(self.count++));
    }];
    [self.timer fire];
    
    NSRunLoop *runloopObj = [NSRunLoop currentRunLoop];
    self.runloop =  [runloopObj getCFRunLoop];
    [runloopObj addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    
    self.observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        //       NSLog(@"----监听到RunLoop状态发生改变---%zd", activity);
        
        /**
         *  监测RunloopActivity 状态
         *    typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
         *       kCFRunLoopEntry         = (1UL << 0),  即将进入Loop
         *       kCFRunLoopBeforeTimers  = (1UL << 1),  即将处理 Timer
         *       kCFRunLoopBeforeSources = (1UL << 2),  即将处理 Source
         *       kCFRunLoopBeforeWaiting = (1UL << 5),  即将进入休眠
         *       kCFRunLoopAfterWaiting  = (1UL << 6),  刚从休眠中唤醒
         *       kCFRunLoopExit          = (1UL << 7),  即将退出Loop
         *   };
         */
        if (activity==kCFRunLoopEntry) {
            NSLog(@"----监听到RunLoop状态发生改变---%@", @"即将进入Loop");
        }else if (activity==kCFRunLoopBeforeTimers){
            NSLog(@"----监听到RunLoop状态发生改变---%@", @"即将处理 Timer");
        }else if (activity==kCFRunLoopBeforeSources){
            NSLog(@"----监听到RunLoop状态发生改变---%@", @"即将处理 Source");
        }else if (activity==kCFRunLoopBeforeWaiting){
            NSLog(@"----监听到RunLoop状态发生改变---%@", @"即将进入休眠");
        }else if (activity==kCFRunLoopAfterWaiting){
            NSLog(@"----监听到RunLoop状态发生改变---%@", @"刚从休眠中唤醒");
        }if (activity==kCFRunLoopExit){
            NSLog(@"----监听到RunLoop状态发生改变---%@", @"即将退出Loop");
        }
        
    });
    CFRunLoopAddObserver(self.runloop, self.observer, kCFRunLoopDefaultMode);
    
    CFRunLoopRun();
    CFRelease(self.observer);
}

- (void)startDispatchSource{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.source  = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.source,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.source, ^{
        NSLog(@"%@",@(self.count++));
    });
    //ource在suspend状态下，如果直接设置source = nil或者重新创建source都会造成crash。正确的方式是在resume状态下调用dispatch_source_cancel(source)后再重新创建。
    dispatch_resume(self.source);
}

- (void)stopTimer{
//    NSLog(@"%@", [NSThread currentThread]);
//    if (self.timer!=nil) {
//        [self.timer invalidate];
//        CFRunLoopStop(self.runloop);
//    }
     dispatch_source_cancel(self.source);
}
@end
