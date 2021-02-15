//
//  TabBarListViewController.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/6/29.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "TabBarListViewController.h"
#import "TabBarViewController.h"
#import "CustomTabBarViewController.h"
#import "TaoBaoCustomTabBarViewController.h"
#import "AnimationTabBarViewController.h"
#import "JDAnimationTabBarViewController.h"
#import "SlidingTabbarViewController.h"

@interface TabBarListViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

// 数据源
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation TabBarListViewController

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = white_color;
    [self.dataArray addObject:@"普通的tabbar"];
    [self.dataArray addObject:@"自定义小红点Tabbar"];
    [self.dataArray addObject:@"凸起来的加号按钮tabbar"];
    [self.dataArray addObject:@"淘宝按钮tabbar"];
    [self.dataArray addObject:@"动画按钮tabbar"];
    [self.dataArray addObject:@"京东起弹Tabbar"];
    [self.dataArray addObject:@"滑动隐藏Tabbar"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    //先从缓存池中区
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];;
    //缓存池中没有再创建，并添加标识，cell移出缓存池以复用
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = blue_color;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewController * vc = (UITableViewController*)tableView.dataSource;//用tableView获取控制器
    if (indexPath.row == 0) {
        //普通的tabbar
        TabBarViewController *tabbar = [[TabBarViewController alloc] init];
        if (@available(iOS 13, *)) {
            tabbar.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [vc.navigationController pushViewController:tabbar animated:YES];
    } else if (indexPath.row == 1) {
        //自定义小红点Tabbar
        TabBarViewController *tabbar = [[TabBarViewController alloc] init];
        tabbar.isBadge = YES;
        if (@available(iOS 13, *)) {
            tabbar.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [vc.navigationController pushViewController:tabbar animated:YES];
    } else if (indexPath.row == 2) {
        //凸起来的加号按钮tabbar
        CustomTabBarViewController *tabbar = [[CustomTabBarViewController alloc] init];
        if (@available(iOS 13, *)) {
            tabbar.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [vc.navigationController pushViewController:tabbar animated:YES];
    } else if (indexPath.row == 3) {
        //淘宝按钮tabbar
        TaoBaoCustomTabBarViewController *tabbar = [[TaoBaoCustomTabBarViewController alloc] init];
        if (@available(iOS 13, *)) {
            tabbar.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [vc.navigationController pushViewController:tabbar animated:YES];
    } else if (indexPath.row == 4) {
        //动画按钮tabbar
        AnimationTabBarViewController *tabbar = [[AnimationTabBarViewController alloc] init];
        if (@available(iOS 13, *)) {
            tabbar.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [vc.navigationController pushViewController:tabbar animated:YES];
    } else if (indexPath.row == 5) {
        //京东起弹Tabbar
        JDAnimationTabBarViewController *tabbar = [[JDAnimationTabBarViewController alloc] init];
        if (@available(iOS 13, *)) {
            tabbar.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [vc.navigationController pushViewController:tabbar animated:YES];
    } else if (indexPath.row == 6) {
        //滑动隐藏Tabbar
        SlidingTabbarViewController *tabbar = [[SlidingTabbarViewController alloc] init];
        if (@available(iOS 13, *)) {
            tabbar.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [vc.navigationController pushViewController:tabbar animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //在UITableViewController ScrollView等页面的侧滑返回无效问题
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

@end
