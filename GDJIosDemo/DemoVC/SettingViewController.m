//
//  SettingViewController.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/6/30.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

@end
