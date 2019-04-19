//
//  ViewController2.m
//  TimerBaseHandle
//
//  Created by shengxin on 2019/4/15.
//  Copyright © 2019 shengxin. All rights reserved.
//

#import "ViewController2.h"
#import "TimerBaseHandleHelper.h"
@interface ViewController2 ()

@property (nonatomic, strong) TimerBaseHandleHelper *timerHelper;
@end

@implementation ViewController2

- (void)dealloc{
   NSLog(@"%s",__func__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(100, 100, 100, 100)];
    [button setTitle:@"Close Time" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(closetTimer) forControlEvents:UIControlEventTouchUpInside];
    
    self.timerHelper = [[TimerBaseHandleHelper alloc] init];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.timerHelper startTimer];
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)closetTimer{
    //This method queues the message on the run loop of the target thread using the default run loop modes
//    [self performSelector:@selector(closeTime) onThread:self.timerHelper.timerThread withObject:nil waitUntilDone:YES];
//
//    self.timerHelper = nil;
    [self closeTime];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)closeTime{
    [self.timerHelper stopTimer];
}
@end
