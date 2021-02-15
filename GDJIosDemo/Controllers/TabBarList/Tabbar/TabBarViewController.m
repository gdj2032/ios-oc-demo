//
//  TabBarViewController.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/6/30.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
    [self tabBarControllerAddChildViewController];
}

# pragma mark - 添加子类的数据
- (void)tabBarControllerAddChildViewController
{
    NSArray *classControllers = [NSArray array];
    
    if (self.isBadge) {
        classControllers = @[@"BadgeViewController", @"HomeViewController", @"UserViewController", @"SettingViewController"];
        NSArray *titles = @[@"圆点", @"首页", @"我的", @"设置"];
        NSArray *normalImages = @[@"mycity_normal", @"home_normal", @"user_normal", @"setting_normal"];
        NSArray *selectImages = @[@"mycity_highlight", @"home_highlight", @"user_highlight", @"setting_highlight"];
        [self TabbarControllerAddSubViewsControllers:classControllers addTitleArray:titles addNormalImagesArray:normalImages addSelectImageArray:selectImages];
    }else{
        classControllers = @[@"HomeViewController", @"UserViewController", @"SettingViewController"];
        NSArray *titles = @[@"首页", @"我的", @"设置"];
        NSArray *normalImages = @[@"home_normal", @"user_normal", @"setting_normal"];
        NSArray *selectImages = @[@"home_highlight", @"user_highlight", @"setting_highlight"];
        [self TabbarControllerAddSubViewsControllers:classControllers addTitleArray:titles addNormalImagesArray:normalImages addSelectImageArray:selectImages];
    }
    
    
}


# pragma mark - 初始化Tabbar里面的元素
- (void)TabbarControllerAddSubViewsControllers:(NSArray *)classControllersArray addTitleArray:(NSArray *)titleArray addNormalImagesArray:(NSArray *)normalImagesArray addSelectImageArray:(NSArray *)selectImageArray
{
    NSMutableArray *conArr = [NSMutableArray array];
    
    for (int i = 0; i < classControllersArray.count; i++) {
        
        Class cts = NSClassFromString(classControllersArray[i]);
        UIViewController *vc = [[cts alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:vc];
        [conArr addObject:naVC];
        
        UIImage *normalImage = [[UIImage imageNamed:normalImagesArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectImage = [[UIImage imageNamed:selectImageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleArray[i] image:normalImage selectedImage:selectImage];
        
    }
    
    self.viewControllers = conArr;
    self.tabBar.tintColor = blue_color;
    self.tabBar.translucent = NO;
    
}

@end
