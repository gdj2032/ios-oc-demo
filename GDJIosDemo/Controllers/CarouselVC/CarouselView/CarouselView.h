//
//  CarouselView.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/6.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarouselScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CarouselViewDelegate <NSObject>

-(void)imageClick:(UIImageView *)imageView;

@end

@interface CarouselView : UIView<CarouselScrollViewDelegate>

@property (nonatomic,retain) NSArray *images; //图片数组
@property (nonatomic,assign) NSTimeInterval changeTime;//轮播时间
@property (nonatomic,retain) UIColor *selectedColor;//当前选中页的颜色
@property (nonatomic,retain) UIColor *disSelectedColor;//未选中页的颜色
@property (nonatomic,assign) PageControlLocation location; //页面对应点的位置
@property (nonatomic,assign) id<CarouselViewDelegate> cvDelegate;

@end

NS_ASSUME_NONNULL_END
