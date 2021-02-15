//
//  PhotoListView.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/20.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "PhotoListView.h"

@implementation PhotoListView{
    PhotoListScrollView *photoListScrollView;
    CGRect initFrame;
}

-(instancetype)initPhotoListViewWithModels:(NSArray<PhotoListModel *> *)models withCellHeight:(CGFloat)cellHeight withFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        initFrame = frame;
        photoListScrollView = [[PhotoListScrollView alloc] initScrollViewWithModels:models withCellHeight:cellHeight withFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        photoListScrollView.scrollDelegate = self;
        self.backgroundColor = [black_color colorWithAlphaComponent:0.6];
        [self addSubview:photoListScrollView];
    }
    return self;
}

-(void)cellClickWithIdx:(int)idx WithIsUpdate:(BOOL)isUpdate{
    [self.photoListViewDelegate hiddenPhotoListViewWithIdx:idx WithIsUpdate:isUpdate];
}

@end
