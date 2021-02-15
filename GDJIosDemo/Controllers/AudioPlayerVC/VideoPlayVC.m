//
//  VideoPlayVC.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/22.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "VideoPlayVC.h"
#import "VideoPlayerView.h"
#import "VideoPlayerView.h"

@interface VideoPlayVC ()

@property(nonatomic,strong)VideoPlayerView *player;

@end

@implementation VideoPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:audioPath];
    _player = [[VideoPlayerView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, SCREEN_WIDTH, SCREEN_WIDTH * 9 / 16)];
    _player.url = url;
    [_player backButton:^(UIButton * _Nullable button) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view addSubview:_player];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 400, SCREEN_WIDTH, 200)];
    view1.backgroundColor = yellow_color;
    [self.view addSubview:view1];
}

//在控制器中实现这个方法.
//1.如果播放器是控制器,自定义.
//2.如果有导航控制器或tabBarController,自定义.
//因为in general, 普通vc是这哥俩的子vc.
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    NSLog(@"viewWillDisappear");
}

@end
