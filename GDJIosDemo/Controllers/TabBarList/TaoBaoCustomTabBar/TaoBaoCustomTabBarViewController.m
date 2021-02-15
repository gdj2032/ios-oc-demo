//
//  CustomTabBarViewController.m
//  Hahn_Tabbar_Objc
//
//  Created by Hahn on 2019/6/28.
//  Copyright © 2019 Hahn. All rights reserved.
//

#import "TaoBaoCustomTabBarViewController.h"
#import "TaoBaoCustomTabBar.h"

@interface TaoBaoCustomTabBarViewController ()<UITabBarControllerDelegate, TaoBaoCustomTabBarDelegate>

@property (strong, nonatomic) TaoBaoCustomTabBar *customTabBar;

@end

@implementation TaoBaoCustomTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    TaoBaoCustomTabBar *tabBar = [[TaoBaoCustomTabBar alloc] init];
    //取消tabBar的透明效果
    tabBar.translucent = NO;
    // 设置tabBar的代理
    tabBar.myDelegate = self;
    // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：。
    [self setValue:tabBar forKey:@"tabBar"];
    self.customTabBar = tabBar;
    
    [self tabBarControllerAddChildViewController];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

# pragma mark - 添加子类的数据
- (void)tabBarControllerAddChildViewController
{
    NSArray *classControllers = [NSArray array];
    classControllers = @[@"HomeViewController", @"UserViewController",@"SettingViewController", @"SettingViewController", @"SettingViewController"];
    NSArray *titles = @[@"", @"我的", @"设置", @"附近", @"查看"];
    NSArray *normalImages = @[@"", @"user_normal", @"mycity_normal", @"setting_normal", @"setting_normal"];
    NSArray *selectImages = @[@"", @"user_highlight", @"mycity_highlight", @"setting_highlight", @"setting_highlight"];
    
    [self TabbarControllerAddSubViewsControllers:classControllers addTitleArray:titles addNormalImagesArray:normalImages addSelectImageArray:selectImages];
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
        vc.tabBarItem.tag = i;

    }
    
    self.viewControllers = conArr;
    self.tabBar.tintColor = [UIColor colorWithRed:255.0/255 green:204.0/255 blue:13.0/255 alpha:1];
    self.tabBar.translucent = NO;
    
    self.delegate = self;
}

#pragma TaoBaoCustomTabBarDelegate
/**
 *  点击了淘宝按钮
 */
- (void)tabBarDidClickPlusButton:(TaoBaoCustomTabBar *)tabBar
{
    self.selectedIndex =0;
    self.customTabBar.plusButton.hidden = YES;
}

# pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (viewController.tabBarItem.tag == 0) {
        self.customTabBar.plusButton.selected = NO;
        self.customTabBar.plusButton.hidden = NO;
        self.viewControllers[0].tabBarItem.image = [[UIImage imageNamed:@""] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.viewControllers[0].tabBarItem.title = @"";

        return YES;
    }else{
        self.customTabBar.plusButton.hidden = YES;
        self.viewControllers[0].tabBarItem.image = [[UIImage imageNamed:@"home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.viewControllers[0].tabBarItem.title = @"首页";
        return YES;
    }
}

@end
