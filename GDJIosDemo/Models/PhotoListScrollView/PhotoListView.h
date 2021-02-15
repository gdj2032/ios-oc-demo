//
//  PhotoListView.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/20.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoListModel.h"
#import "PhotoListScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PhotoListViewDelegate <NSObject>

-(void)hiddenPhotoListViewWithIdx:(int)idx WithIsUpdate:(BOOL)isUpdate;

@end

@interface PhotoListView : UIView<PhotoListScrollViewDelegate>

@property(nonatomic,assign)id<PhotoListViewDelegate> photoListViewDelegate;

-(instancetype)initPhotoListViewWithModels:(NSArray<PhotoListModel *>*)models withCellHeight:(CGFloat)cellHeight withFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
