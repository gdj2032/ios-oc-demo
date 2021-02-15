//
//  CenterViewController.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/6/17.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.center = self.view.center;
    [self.view addSubview:button];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)backBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
