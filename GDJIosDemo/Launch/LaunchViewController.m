//
//  LaunchViewController.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/6/17.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "LaunchViewController.h"
#import "DateFormat.h"
#import "TableVC.h"
#import "PhotoList.h"
#import "PhotoListModel.h"
#import "AppDelegate.h"

@interface LaunchViewController ()

@property(nonatomic,strong)NSArray<PhotoListModel *> *models;

@end

@implementation LaunchViewController

int skipTime = 5;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = blue_color;
    _lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 24)];
    _lable.text = @"gdj-ios-demo-启动页";\
    _lable.textAlignment = NSTextAlignmentCenter;
    _lable.center = self.view.center;
    [self.view addSubview:_lable];
    
    NSString *ctime = [DateFormat getCurrentTime:@"yyyy-MM-dd hh:mm:ss"];
    NSLog(@"ctime = %@", ctime);
    
    _skipBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, kStatusBarHeight, 48, 24)];
    _skipBtn.backgroundColor = gray_color0;
    [_skipBtn setTitle:@"跳过5s" forState:UIControlStateNormal];
    [_skipBtn setTitleColor:black_color forState:UIControlStateNormal];
    _skipBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    _skipBtn.layer.cornerRadius = 4;
    _skipBtn.layer.masksToBounds = YES;
    [_skipBtn addTarget:self action:@selector(skipClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_skipBtn];
    //    //传参 userinfo:dict
    //    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    //    [dict setObject:cell  forKey:@"cell"];
    //    [dict setObject:dataFilePath  forKey:@"dataFilePath"];
    //    [dict setObject:newTimer  forKey:@"newTimer"];
    
    //    NSThread *t1 = [[NSThread alloc] initWithTarget:self selector:@selector(actThread:) object:nil];
    //    [t1 start];
}

//-(void)actThread{
//    self.models = [[PhotoList sharePhotoList] getPhotoList];
//    AppDelegate *myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    myAppDelegate.models = self.models;
//}

- (void) timerAction{
    if (skipTime == 0) {
        [self skipClick];
        return;
    }
    skipTime--;
    [_skipBtn setTitle:[NSString stringWithFormat:@"跳过%ds",skipTime] forState:UIControlStateNormal];
}

- (void) skipClick {
    [_timer invalidate];
    _timer = nil;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFade;//跳转方式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    TableVC *vc = [TableVC new];
    [self.navigationController pushViewController:vc animated:NO];
    [self.navigationController.view.layer addAnimation:animation forKey:@"animation"];
    
    //    TableVC *vc = [TableVC new];
    //    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    dispatch_sync(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        self.models = [[PhotoList sharePhotoList] getPhotoList];
        AppDelegate *myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        myAppDelegate.models = self.models;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        });
    });
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //    dispatch_sync(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
    //        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    //    });
    
}

@end
