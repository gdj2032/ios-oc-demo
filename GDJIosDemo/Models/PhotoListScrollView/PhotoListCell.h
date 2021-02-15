//
//  PhotoListCell.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/17.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoListCellModel.h"
#import "NSUtils.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PhotoListCellDelegate <NSObject>

-(void)cellClick:(UIButton*)btn;

@end

@interface PhotoListCell : UIButton

@property (nonatomic,assign) id<PhotoListCellDelegate> photoListCellDelegate;

-(instancetype)initCellWithModel:(PhotoListCellModel*)model withFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
