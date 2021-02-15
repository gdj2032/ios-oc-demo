//
//  TableCellViewModal.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/6/18.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TableViewCell,UITableView;

NS_ASSUME_NONNULL_BEGIN

@interface TableCellViewModel : NSObject

@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) NSArray *tablelist;

-(instancetype)initWithTableView:(UITableView*)tableView;

-(NSInteger)numberOfSections;
-(NSInteger)numberOfItemsInSection:(NSInteger)section;

-(TableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath;

-(float)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
