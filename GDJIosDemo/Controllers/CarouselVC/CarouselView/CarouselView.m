//
//  CarouselView.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/6.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "CarouselView.h"

@implementation CarouselView {
    CarouselScrollView *carouselScrollView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        carouselScrollView = [[CarouselScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        carouselScrollView.scrollDelegate = self;
        [self addSubview:carouselScrollView];
        [self addSubview:carouselScrollView.pageControl];
    }
    return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow{
    [self resetImage];
}

-(void)setImages:(NSArray *)images{
    carouselScrollView.images = images;
    _images = images;
}

-(void)setChangeTime:(NSTimeInterval)changeTime{
    carouselScrollView.changeTime = changeTime;
    _changeTime = changeTime;
}

-(void)setSelectedColor:(UIColor *)selectedColor{
    carouselScrollView.pageControl.currentPageIndicatorTintColor = selectedColor;
    _selectedColor = selectedColor;
}

-(void)setDisSelectedColor:(UIColor *)disSelectedColor{
    carouselScrollView.pageControl.pageIndicatorTintColor = disSelectedColor;
    _disSelectedColor = disSelectedColor;
}

-(void)setLocation:(PageControlLocation)location{
    carouselScrollView.location = location;
    _location = location;
}

-(void)resetImage{
    [carouselScrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    carouselScrollView.pageControl.currentPage = 0;
}

-(void)imageClick:(UIImageView *)imageView{
    [self.cvDelegate imageClick:imageView];
}

@end


