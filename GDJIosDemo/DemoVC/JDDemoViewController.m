//
//  JDDemoViewController.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/9.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "JDDemoViewController.h"
#import "Demo1ViewController.h"

@interface JDDemoViewController ()

@end

@implementation JDDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *pushBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 200, 200)];
    [pushBtn setTitle:@"push" forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(pushBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBtn];
}

# pragma mark - push
- (void)pushBtn
{
    Demo1ViewController *vc = [[Demo1ViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
