//
//  AnimationTabBarViewController.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/9.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "AnimationTabBarViewController.h"

// 音效框架
#import <AudioToolbox/AudioToolbox.h>

@interface AnimationTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation AnimationTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    NSArray *titles = @[@"首页", @"附近", @"发布", @"聊天", @"我的"];
    NSArray *normalImages = @[@"home_normal", @"mycity_normal", @"mycity_normal", @"message_normal", @"setting_normal"];
    NSArray *selectImages = @[@"home_highlight", @"mycity_highlight", @"mycity_highlight", @"message_highlight", @"setting_highlight"];
    
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

# pragma mark - UITabBarControllerDelegate
/**
 点击TabBar的时候调用
 */
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self animationWithIndex:item.tag];
}

- (void)animationWithIndex:(NSInteger) index {
    // 得到当前tabbar的下标
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    /**
     对当前下标的tabbar使用帧动画
     可以根据UI的具体要求进行动画渲染
     */
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount = 1;
    pulse.autoreverses = YES;
    pulse.fromValue = [NSNumber numberWithFloat:0.7];
    pulse.toValue = [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
    [self playSoundEffect:@"music" type:@"wav"];
}

# pragma mark - 播放音效的方法
- (void)playSoundEffect:(NSString *)name type:(NSString *)type{
    // 获取音效文件路径
    NSString *resoucePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    SystemSoundID soundID;
    // 地址转换和赋值
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:resoucePath], &soundID);
    // 开始播放音效
    AudioServicesPlaySystemSound(soundID);
}

@end

