//
//  ViewController1.m
//  TimerBaseHandle
//
//  Created by shengxin on 2019/4/15.
//  Copyright © 2019 shengxin. All rights reserved.
//

#import "ViewController1.h"
#import "ViewController2.h"
@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(100, 100, 100, 100)];
    [button setTitle:@"Push Timer" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(startTimer) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)startTimer{
    ViewController2 *v = [[ViewController2 alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:v animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
