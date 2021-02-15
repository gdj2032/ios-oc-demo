//
//  PhotoTableCellView.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/17.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "PhotoListScrollView.h"

@interface PhotoListScrollView()

@end

@implementation PhotoListScrollView{
    CGFloat photoListScrollViewRealH;
    int selectId;
}

-(instancetype)initScrollViewWithModels:(NSArray<PhotoListModel *> *)models withCellHeight:(CGFloat)cellHeight withFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        selectId = 0;
        CGFloat cellAllH = cellHeight * (models.count);
        photoListScrollViewRealH = frame.size.height;
        self.frame = CGRectMake(0, 0, frame.size.width, photoListScrollViewRealH);
        self.contentSize = CGSizeMake(SCREEN_WIDTH, cellAllH);
        self.delegate = self;
        [self initCellWithModels:(NSArray<PhotoListModel *> *)models withCellHeight:(CGFloat)cellHeight];
    }
    return self;
}

-(void)initCellWithModels:(NSArray<PhotoListModel *> *)models withCellHeight:(CGFloat)cellHeight{
    for (int i = 0; i < models.count; i++) {
        CGRect frame = CGRectMake(0, cellHeight * i, SCREEN_WIDTH, cellHeight);
        BOOL isSelected = (i == selectId);
        NSURL *imagePath = [models[i].list lastObject];
        PhotoListCellModel *model = [[PhotoListCellModel alloc] appWithImagePath:imagePath withTitle:models[i].title withNum:models[i].list.count withIsSelected:isSelected];
        PhotoListCell *cell = [[PhotoListCell alloc] initCellWithModel:model withFrame:frame];
        cell.photoListCellDelegate = self;
        [self addSubview:cell];
    }
}

-(void)cellClick:(UIButton *)btn{
    int tag = (int)btn.tag;
    if (tag == selectId) {
        [self.scrollDelegate cellClickWithIdx:tag WithIsUpdate:NO];
        return;
    }
    for (int i = 0; i<self.subviews.count; i++) {
        if (i == tag){
            selectId = tag;
            [self.subviews[i].subviews lastObject].hidden = NO;
            [self.scrollDelegate cellClickWithIdx:tag WithIsUpdate:YES];
        } else {
            [self.subviews[i].subviews lastObject].hidden = YES;
        }
    }
}

#pragma mark -- 点击空白处,让视图滚动到指定位置
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
    [self.scrollDelegate cellClickWithIdx:-1 WithIsUpdate:NO];
}

@end
