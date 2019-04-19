//
//  ViewController.m
//  TimerBaseHandle
//
//  Created by shengxin on 2019/4/15.
//  Copyright © 2019 shengxin. All rights reserved.
//

#import "ViewController.h"

#import "ViewController2.h"
#import "ViewController1.h"
@interface ViewController ()


@property (nonatomic, strong) UINavigationController *navController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    ViewController1 *v1 = [[ViewController1 alloc] initWithNibName:nil bundle:nil];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:v1];
    self.navController.view.frame = self.view.bounds;
    [self addChildViewController:self.navController];
    [self.view addSubview:self.navController.view];
}



@end
