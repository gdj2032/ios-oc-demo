//
//  AudioPlayerVC.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/22.
//  Copyright © 2020 顾冬杰. All rights reserved.
//
/**
     AVPlayer支持的视频格式（系统播放器支持的视频格式）
     H.264、MPEG-4，扩展名（压缩格式）：.mp4、.mov、.m4v、.m2v、.3gp、.3g2等
 */

#import "AudioPlayerVC.h"
#import "VideoPlayVC.h"
#import "MusicPlayerVC.h"
#import "RecordingVC.h"

@interface AudioPlayerVC ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

// 数据源
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation AudioPlayerVC

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.dataArray addObject:@"音乐播放器"];
    [self.dataArray addObject:@"视频播放器"];
    [self.dataArray addObject:@"录音"];
    [self.dataArray addObject:@"拍照"];
    [self.dataArray addObject:@"视频录制"];
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
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    vc.navigationItem.backBarButtonItem = item;
    if (indexPath.row == 0) {
        //音乐播放器
        MusicPlayerVC *tabbar = [[MusicPlayerVC alloc] init];
        if (@available(iOS 13, *)) {
            tabbar.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        tabbar.view.backgroundColor = white_color;
        [vc.navigationController pushViewController:tabbar animated:YES];
    }
    if (indexPath.row == 1) {
        //视频播放器
        VideoPlayVC *tabbar = [[VideoPlayVC alloc] init];
        if (@available(iOS 13, *)) {
            tabbar.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        tabbar.view.backgroundColor = white_color;
        [vc.navigationController pushViewController:tabbar animated:YES];
    }
    if (indexPath.row == 2) {
        //录音
        RecordingVC *tabbar = [[RecordingVC alloc] init];
        if (@available(iOS 13, *)) {
            tabbar.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        tabbar.view.backgroundColor = white_color;
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
