//
//  TableCellViewModal.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/6/18.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "TableCellViewModel.h"
#import "TableViewCell.h"
#import "TableCellModel.h"
#import "TabBarListViewController.h"
#import "CarouselVC.h"
#import "AlertVC.h"
#import "CameraVC.h"
#import "RichTextVC.h"
#import "ProgressVC.h"
#import "AudioPlayerVC.h"
#import "TestVC.h"
#import <Photos/Photos.h>

@interface TableCellViewModel()

@end

@implementation TableCellViewModel

- (NSArray *)tablelist{
    if (_tablelist == nil) {
        NSArray *arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tablelist.plist" ofType:nil]];
        //创建可变数据来保存一个一个的模型对象
        NSMutableArray *arrayModals = [NSMutableArray array];//空的可变数组
        for (NSDictionary *dict in arr) {
            TableCellModel *modal = [TableCellModel appWithDict:dict];
            [arrayModals addObject:modal];
        }
        _tablelist = arrayModals;
    }
    return _tablelist;
}

#pragma mark -- 初始化tableview
-(instancetype)initWithTableView:(UITableView*)tableView {
    self=[super init];
    self.tableView=tableView;
    [self getInfoWithView:self.tableView];
    return self;
}

#pragma mark -- 获取数据
-(void)getInfoWithView:(UITableView*)tableView{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView reloadData];
}

-(NSInteger)numberOfSections{
    return 1;
}

-(NSInteger)numberOfItemsInSection:(NSInteger)section{
    return self.tablelist.count;
}

-(NSString*)titleForHeaderInSection:(NSInteger)section{
    return nil;
}

#pragma mark -- cell高度
-(float)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

#pragma mark -- 点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"点击了%@", cell.model.title);
    NSString *page = cell.model.page;
    UITableViewController * vc = (UITableViewController*)tableView.dataSource;//用tableView获取控制器
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    vc.navigationItem.backBarButtonItem = item;
    if([page isEqualToString:@"TabBarList"]){
        TabBarListViewController *tabvc = [[TabBarListViewController alloc] init];
        tabvc.view.backgroundColor = white_color;
        [vc.navigationController pushViewController:tabvc animated:YES];
    }
    if([page isEqualToString:@"AlertVC"]){
        AlertVC *tabvc = [[AlertVC alloc] init];
        tabvc.view.backgroundColor = white_color;
        [vc.navigationController pushViewController:tabvc animated:YES];
    }
    if ([page isEqualToString:@"ProgressVC"]) {
        ProgressVC *tabvc = [[ProgressVC alloc] init];
        tabvc.view.backgroundColor = white_color;
        [vc.navigationController pushViewController:tabvc animated:YES];
    }
    if ([page isEqualToString:@"CarouselVC"]) {
        CarouselVC *tabvc = [[CarouselVC alloc] init];
        tabvc.view.backgroundColor = white_color;
        [vc.navigationController pushViewController:tabvc animated:YES];
    }
    if ([page isEqualToString:@"RichTextVC"]) {
        RichTextVC *tabvc = [[RichTextVC alloc] init];
        tabvc.view.backgroundColor = white_color;
        [vc.navigationController pushViewController:tabvc animated:YES];
    }
    if ([page isEqualToString:@"CameraVC"]) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {}];
        CameraVC *tabvc = [[CameraVC alloc] init];
        tabvc.view.backgroundColor = white_color;
        [vc.navigationController pushViewController:tabvc animated:YES];
    }
    if ([page isEqualToString:@"AudioPlayerVC"]) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {}];
        AudioPlayerVC *tabvc = [[AudioPlayerVC alloc] init];
        tabvc.view.backgroundColor = white_color;
        [vc.navigationController pushViewController:tabvc animated:YES];
    }
    if ([page isEqualToString:@"TestVC"]) {
        TestVC *tabvc = [[TestVC alloc] init];
        tabvc.view.backgroundColor = white_color;
        [vc.navigationController pushViewController:tabvc animated:YES];
    }
}

-(TableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    TableViewCell *cell=[TableViewCell cellWithTableView:tableView indexPath:indexPath];
    cell.model = _tablelist[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
@end
