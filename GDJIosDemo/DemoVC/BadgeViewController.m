//
//  BadgeViewController.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/1.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "BadgeViewController.h"
#import "UITabBar+Badge.h"

@interface BadgeViewController ()

@end

@implementation BadgeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];

    /**
    如果是需要点击tabbar隐藏、可以在
     - (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
     设置
     */
    
    UIButton *canleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 200, 200)];
    [canleBtn setTitle:@"取消全部小红点" forState:UIControlStateNormal];
    [canleBtn addTarget:self action:@selector(canleBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:canleBtn];
    
    // 系统的方法
    self.tabBarController.viewControllers[0].tabBarItem.badgeValue = @"1";
    
    [self showRedPoint];
}

//显示小红点
- (void)showRedPoint
{
    CGPoint badgePoint = CGPointMake(25, 10);
    self.tabBarController.tabBar.badgePoint = badgePoint;
    self.tabBarController.tabBar.badgeSize = CGSizeMake(20, 20);
    self.tabBarController.tabBar.badgeColor = [UIColor redColor];
    self.tabBarController.tabBar.badgeValue = @"1";
    [self.tabBarController.tabBar showBadgeOnItemIndex:2];
    
    
    CGPoint badgePoint1 = CGPointMake(25, -3);
    self.tabBarController.tabBar.badgePoint = badgePoint1;
    self.tabBarController.tabBar.badgeSize = CGSizeMake(20, 20);
    self.tabBarController.tabBar.badgeColor = [UIColor redColor];
    self.tabBarController.tabBar.badgeColor = [UIColor orangeColor];
    self.tabBarController.tabBar.badgeImage = [UIImage imageNamed:@"demo"];
    [self.tabBarController.tabBar showBadgeOnItemIndex:1];

    
    CGPoint badgePoint2 = CGPointMake(25, -3);
    self.tabBarController.tabBar.badgePoint = badgePoint2;
    self.tabBarController.tabBar.badgeSize = CGSizeMake(10, 10);
    self.tabBarController.tabBar.badgeColor = [UIColor redColor];
    self.tabBarController.tabBar.badgeImage = [UIImage imageNamed:@""];
    self.tabBarController.tabBar.badgeValue = @"";
    [self.tabBarController.tabBar showBadgeOnItemIndex:3];
}

# pragma mark - 取消小红点
- (void)canleBtn
{
    // 系统的方法
    self.tabBarController.viewControllers[0].tabBarItem.badgeValue = nil;
    
    [self.tabBarController.tabBar  hiddenRedPointOnIndex:1 animation:NO];
    [self.tabBarController.tabBar  hiddenRedPointOnIndex:2 animation:YES];
    [self.tabBarController.tabBar  hiddenRedPointOnIndex:3 animation:YES];
}






@end
