//
//  AppDelegate.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/6/17.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "LaunchViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(NSArray *)models{
    if(!_models){
        _models = [NSArray array];
    }
    return _models;
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    NSLog(@"shouldSaveApplicationState");
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreSecureApplicationState:(NSCoder *)coder {
    NSLog(@"shouldRestoreSecureApplicationState");
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"程序进入后台");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:1];
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
//    self.window.rootViewController= [[LaunchViewController alloc] init];
    self.window.rootViewController= [[UINavigationController alloc] initWithRootViewController: [[LaunchViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    //监听系统声音
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryAmbient error:nil];//重点方法
    //后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    //注，ios9上不加这一句会无效
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    self.Rotate = 0;
    
    return YES;
}

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    //为1的话,说明某个界面需要横竖屏转化
    if (_Rotate == 1) {
        return UIInterfaceOrientationMaskAll;
    } else {
        //为0的话,说明只需要竖屏
        return UIInterfaceOrientationMaskPortrait;
    }
}

// 是否支持设备自动旋转
- (BOOL)shouldAutorotate
{
    if (_Rotate == 1) {
        //为1的话,支持旋转
        return YES;
    }
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

@end
