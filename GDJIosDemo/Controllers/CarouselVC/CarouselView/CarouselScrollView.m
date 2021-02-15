//
//  CarouselScrollView.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/6.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "CarouselScrollView.h"

@implementation CarouselScrollView{
    CGRect myFrame;
    NSTimer *scrollTimer;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        myFrame = frame;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.delegate = self;
        self.backgroundColor = [UIColor redColor];
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, myFrame.origin.y + myFrame.size.height-20, myFrame.size.width, 20)];
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetImage) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)resetImage{
    [self setContentOffset:CGPointMake(myFrame.size.width, 0)];
    self.pageControl.currentPage = 0;
}

-(void)setchangeTime:(NSTimeInterval)changeTime{
    if (scrollTimer) {
        [scrollTimer invalidate];
        scrollTimer = nil;
    }
    scrollTimer = [NSTimer scheduledTimerWithTimeInterval:changeTime target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    _changeTime = changeTime;
}

-(void)changeImage{
    CGPoint contentOffset = self.contentOffset;
    contentOffset.x = contentOffset.x+myFrame.size.width;
    [self setContentOffset:contentOffset animated:YES];
    //    CGRect rect = CGRectMake(contentOffset.x, myFrame.origin.y, myFrame.size.width, myFrame.size.height);
    //    [self scrollRectToVisible:rect animated:YES];
}

-(void)setImages:(NSArray *)images{
    _pageControl.numberOfPages = images.count;
    _pageControl.frame = CGRectMake(0, myFrame.origin.y + myFrame.size.height-20, 20*images.count, 20);
    self.location = _location;
    [self setContentSize:CGSizeMake((images.count+2)*myFrame.size.width, myFrame.size.height)];
    [self setContentOffset:CGPointMake(myFrame.size.width, 0)];
    
    UIImageView *firstImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, myFrame.size.width, myFrame.size.height)];
    firstImage.contentMode = UIViewContentModeScaleToFill;
    [firstImage setImage:[UIImage imageNamed:[images lastObject]]];
    [self addSubview:firstImage];
    for (int i = 0; i<images.count; i++) {
        ImageGesture *tapImage =[[ImageGesture alloc]initWithFrame:CGRectMake((i+1)*myFrame.size.width, 0, myFrame.size.width, myFrame.size.height)];
        tapImage.tag = i+10;
        tapImage.delegate = self;
        tapImage.contentMode = UIViewContentModeScaleToFill;
        [tapImage setImage:[UIImage imageNamed:images[i]]];
        [self addSubview:tapImage];
    }
    UIImageView *lastImage = [[UIImageView alloc]initWithFrame:CGRectMake((images.count+1)*myFrame.size.width, 0, myFrame.size.width, myFrame.size.height)];
    [lastImage setImage:[UIImage imageNamed:images[0]]];
    lastImage.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:lastImage];
    scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    
    _images = images;
}

-(void)imageClick:(id)sender{
    [self.scrollDelegate imageClick:sender];
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [scrollTimer invalidate];
    scrollTimer = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView1{
    scrollTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    if (scrollView1.contentOffset.x == 0) {
        scrollView1.contentOffset = CGPointMake(_images.count*myFrame.size.width, 0);
    }else if(scrollView1.contentOffset.x >= (_images.count+1)*myFrame.size.width){
        scrollView1.contentOffset = CGPointMake(myFrame.size.width, 0);
    }
    _pageControl.currentPage = scrollView1.contentOffset.x/myFrame.size.width-1;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView1{
    if (scrollView1.contentOffset.x == 0) {
        scrollView1.contentOffset = CGPointMake(_images.count*myFrame.size.width, 0);
    }else if(scrollView1.contentOffset.x >= (_images.count+1)*myFrame.size.width){
        scrollView1.contentOffset = CGPointMake(myFrame.size.width, 0);
    }
    _pageControl.currentPage = scrollView1.contentOffset.x/myFrame.size.width-1;
}

-(void)setLocation:(PageControlLocation)location{
    if (location == PageControlCenter) {
        _pageControl.frame = CGRectMake(myFrame.size.width/2-10*_images.count, myFrame.origin.y + myFrame.size.height-20, 20*_images.count, 20);
    }else if(location == PageControlLeft){
        _pageControl.frame = CGRectMake(0, myFrame.origin.y + myFrame.size.height-20, 20*_images.count, 20);
    }else if(location == PageControlRight){
        _pageControl.frame = CGRectMake(myFrame.size.width - 20*_images.count, myFrame.origin.y + myFrame.size.height-20, 20*_images.count, 20);
    }
    _location = location;
}

@end
