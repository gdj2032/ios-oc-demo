//
//  MusicPlayerVC.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/22.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "MusicPlayerVC.h"

@interface MusicPlayerVC ()

@property(nonatomic,strong)MusicPlayerView *musicPlayerView;

@end

@implementation MusicPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //caocao
    //http://music.163.com/song/media/outer/url?id=108795.mp3
    NSString*path = [[NSBundle mainBundle] pathForResource:@"林俊杰 - 曹操" ofType:@"mp3"];
    MusicPlayerViewModel *musicData = [[MusicPlayerViewModel alloc] initWithIds:@"1" title:@"曹操" songer:@"林俊杰" details:@"林俊杰 - 曹操" path:path lyrics:@"[ti:曹操][ar:林俊杰][al:曹操(台湾版)][by:][offset:0][00:00.00]曹操 - 林俊杰 (JJ Lin)[00:05.43]词：林秋离[00:10.87]曲：林俊杰[00:16.30]编曲：Kenn C[00:21.74]制作人：吴剑泓[00:27.17]不是英雄不读三国[00:33.61]若是英雄[00:36.18]怎么能不懂寂寞[00:39.80]独自走下长坂坡[00:41.68]月光太温柔[00:43.30]曹操不啰唆[00:45.05]一心要拿荆州[00:46.87]用阴谋阳谋[00:48.49]明说暗夺的摸[00:52.18][00:53.56]东汉末年分三国[00:56.69]烽火连天不休[01:00.19]儿女情长被乱世左右[01:05.19]谁来煮酒[01:06.94]尔虞我诈是三国[01:09.94]说不清对与错[01:12.51][01:13.55]纷纷扰扰千百年以后[01:18.55]一切又从头[01:23.56][01:33.82]不是英雄不读三国[01:40.39]若是英雄[01:42.95]怎么能不懂寂寞[01:46.45]独自走下长坂坡[01:48.40]月光太温柔[01:49.97]曹操不啰唆[01:51.72]一心要拿荆州[01:53.47]用阴谋阳谋[01:55.22]明说暗夺的摸[01:59.04][02:00.28]东汉末年分三国[02:03.28]烽火连天不休[02:06.85]儿女情长被乱世左右[02:11.85]谁来煮酒[02:13.54]尔虞我诈是三国[02:16.67]说不清对与错[02:20.11]纷纷扰扰千百年以后[02:25.17]一切又从头[02:29.41][02:40.18]独自走下长坂坡[02:41.75]月光太温柔[02:43.25]曹操不啰唆[02:44.93]一心要拿荆州[02:46.81]用阴谋阳谋[02:48.50]明说暗夺的摸[02:53.06][02:53.63]东汉末年分三国[02:56.63]烽火连天不休[03:00.20]儿女情长被乱世左右[03:05.07]谁来煮酒[03:06.82]尔虞我诈是三国[03:09.95]说不清对与错[03:13.52]纷纷扰扰千百年以后[03:18.39]一切又从头" type:@"mp3"];
    _musicPlayerView = [[MusicPlayerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _musicPlayerView.musicData  = musicData;
    [self.view addSubview:_musicPlayerView];
    
    self.title = musicData.title;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    NSDictionary* dict=[NSDictionary dictionaryWithObject:white_color forKey:NSForegroundColorAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:black_color forKey:NSForegroundColorAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated{
    [_musicPlayerView stop];
}

-(void)remoteControlReceivedWithEvent:(UIEvent *)receivedEvent{
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        switch (receivedEvent.subtype) {
            case UIEventSubtypeRemoteControlTogglePlayPause:
//                [self playAndStopSong:self.playButton];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
//                [self playLastButton:self.lastButton];
                break;
            case UIEventSubtypeRemoteControlNextTrack:
//                [self playNextSong:self.nextButton];
                break;
            case UIEventSubtypeRemoteControlPlay:
//                [self playAndStopSong:self.playButton];
                break;
            case UIEventSubtypeRemoteControlPause:
//                [self playAndStopSong:self.playButton];
                break;
            default:
                break;
        }
    }
}

@end
