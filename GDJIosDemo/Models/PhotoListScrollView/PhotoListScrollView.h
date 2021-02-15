//
//  PhotoListScrollView.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/17.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoListModel.h"
#import "PhotoListCellModel.h"
#import "PhotoListCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PhotoListScrollViewDelegate <NSObject>

-(void)cellClickWithIdx:(int)idx WithIsUpdate:(BOOL)isUpdate;

@end

@interface PhotoListScrollView : UIScrollView<UIScrollViewDelegate,PhotoListCellDelegate>

@property (nonatomic,assign) id<PhotoListScrollViewDelegate> scrollDelegate;

-(instancetype)initScrollViewWithModels:(NSArray<PhotoListModel *> *)models withCellHeight:(CGFloat)cellHeight withFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
