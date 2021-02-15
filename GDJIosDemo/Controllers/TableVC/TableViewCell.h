//
//  TableViewCell.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/6/18.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TableCellModel;

@protocol TableViewCellDelegate <NSObject>
@end

@interface TableViewCell : UITableViewCell

@property(nonatomic,strong)TableCellModel *model;

@property(nonatomic,strong)UILabel *skipBtn;

+(instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
