//
//  SuperViewController.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/9.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "SuperViewController.h"

@interface SuperViewController ()

@end

@implementation SuperViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 如果KVO、观察者有改变
    // 京东tabbar
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isAnimation:) name:@"isAnimation" object:nil];
    
    // 滑动隐藏Tabbar
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isSliding:) name:@"isSliding" object:nil];
}

// 京东tabbar 得到监听值
- (void)isAnimation:(NSNotification *)notification{
    NSNumber *number = [notification object];
    int num = [number intValue];
    if (num == 0) {
        self.tabBarController.tabBar.frame = CGRectMake(self.tabBarController.tabBar.frame.origin.x, self.tabBarController.tabBar.frame.origin.y + self.tabBarController.tabBar.frame.size.height, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.tabBarController.tabBar.frame = CGRectMake(self.tabBarController.tabBar.frame.origin.x, self.tabBarController.tabBar.frame.origin.y - self.tabBarController.tabBar.frame.size.height, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
        }];
    }
}

// 滑动隐藏Tabbar得到监听值
- (void)isSliding:(NSNotification *)notification{
    NSNumber *number = [notification object];
    int num = [number intValue];
    
    if (num == 0) {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.tabBarController.tabBar.frame = CGRectMake(self.tabBarController.tabBar.frame.origin.x, SCREEN_HEIGHT + self.tabBarController.tabBar.frame.size.height, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
            
            self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x, 0 - self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
            
        }];
        
    }else{
        
        [UIView animateWithDuration:0.5 animations:^{
            self.tabBarController.tabBar.frame = CGRectMake(self.tabBarController.tabBar.frame.origin.x, SCREEN_HEIGHT - self.tabBarController.tabBar.frame.size.height, self.tabBarController.tabBar.frame.size.width, self.tabBarController.tabBar.frame.size.height);
            
            self.navigationController.navigationBar.frame = CGRectMake(self.navigationController.navigationBar.frame.origin.x, 0 + self.navigationController.navigationBar.frame.size.height, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
        }];
        
        
    }
}
@end

