//
//  CarouselScrollView.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/6.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageGesture.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    PageControlCenter = 1,
    PageControlLeft,
    PageControlRight
} PageControlLocation;

typedef enum {
    ImageStationWithLocal = 1,
    ImageStationWithURL,
} ImageStation;

@protocol CarouselScrollViewDelegate <NSObject>

-(void)imageClick:(UIImageView *)imageView;

@end

@interface CarouselScrollView: UIScrollView<UIScrollViewDelegate,ImageGestureDelegate>

@property (nonatomic,retain) NSArray *images; //图片数组
@property (nonatomic,assign) NSTimeInterval changeTime;//轮播时间
@property (nonatomic,retain) UIPageControl *pageControl;
@property (nonatomic,assign) PageControlLocation location; //页面对应点的位置
@property (nonatomic,assign) id<CarouselScrollViewDelegate> scrollDelegate;

@end

NS_ASSUME_NONNULL_END
