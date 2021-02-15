//
//  CheckImageVC.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/16.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "CheckImageVC.h"
#import "NSUtils.h"

@interface CheckImageVC ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;

@property(nonatomic, strong)UIView *backView;

@property(nonatomic, assign)BOOL visible;

@end

@implementation CheckImageVC

static NSMutableArray *idxs;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = white_color;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden = YES;
    [self load];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

-(void)load{
    _visible = YES;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT)];
    CGFloat imgH = SCREEN_HEIGHT - kStatusBarHeight - kBottomSafeAreaHeight;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _urls.count, imgH);
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.pagingEnabled = YES;
    
    int initI = 0;
    int initLen = (int)_urls.count;
    if (initLen > 10){
        if (_idx - 6 >= 0) {
            initI = _idx - 6;
        }
        if (_idx + 6 <= initLen) {
            initLen = _idx + 6;
        }
    }
    
    for (int i = initI; i < initLen; i++) {
        [self addBtnImageToScrollViewWithIdx:i imgH:imgH];
    }
    _scrollView.delegate = self;
    
    //滚动到指定图片
    _scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * _idx, 0);
    
    [self.view addSubview:_scrollView];
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44 + kStatusBarHeight)];
    _backView.backgroundColor = gray_color0;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, kStatusBarHeight, 100, 44);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:black_color forState:UIControlStateNormal];
    [backBtn.titleLabel sizeToFit];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:backBtn];
    
    [self.view addSubview:_backView];
}

-(void)addBtnImageToScrollViewWithIdx:(int)idx imgH:(CGFloat)imgH{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSData * data = [NSData dataWithContentsOfURL:weakSelf.urls[idx]];
        UIImage *image = [UIImage imageWithData:data];
        imageBtn.frame = CGRectMake(SCREEN_WIDTH * idx, 0, SCREEN_WIDTH, imgH);
        imageBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        if (image.size.height > SCREEN_WIDTH * 2){
            image = [NSUtils compressImage:image toTargetWidth:imgH * 2];
        }
        [idxs addObject:[NSString stringWithFormat:@"%d",idx]];
        [imageBtn setImage:image forState:UIControlStateNormal];
        [imageBtn.imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        imageBtn.clipsToBounds = YES;
        [imageBtn addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.scrollView addSubview:imageBtn];
        });
    });
}

-(void)imageClick:(UIButton*)btn{
    [UIView animateWithDuration:0.5 animations:^{
        if (self.visible){
            self.backView.layer.opacity = 0;
            self.visible = NO;
        } else {
            self.backView.layer.opacity = 1;
            self.visible = YES;
        }
    }];
    
}

-(void)back:(UIButton*)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
//即将开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    CGFloat sx = scrollView.contentOffset.x;
    int i = (int)sx / SCREEN_WIDTH;
    NSLog(@"即将开始拖拽1 i = %d", i);
}
//即将结束拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGFloat sx = scrollView.contentOffset.x;
    int i = (int)sx / SCREEN_WIDTH;
    NSLog(@"即将结束拖拽3 i = %d", i);
}
//即将减速滚动时
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    CGFloat sx = scrollView.contentOffset.x;
    int i = (int)sx / SCREEN_WIDTH;
    NSLog(@"即将减速滚动时4 i = %d", i);
}
//停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat sx = scrollView.contentOffset.x;
    int i = (int)sx / SCREEN_WIDTH;
    NSLog(@"停止滚动5 i = %d", i);
}

CGFloat prevX = 0;

//即将结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"结束拖拽2 decelerate = %d", decelerate);
    if (decelerate){
        NSLog(@"scrollView.contentOffset.x = %f", scrollView.contentOffset.x);
        CGFloat sx = scrollView.contentOffset.x;
        int i = (int)sx / SCREEN_WIDTH;
        NSLog(@"i = %d", i);
        CGFloat imgH = SCREEN_HEIGHT - kStatusBarHeight - kBottomSafeAreaHeight;
        if(!prevX) {
            prevX = sx;
        }
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            if (i+5 <= _urls.count && prevX < sx){
                NSString *idx1 = [NSString stringWithFormat:@"%d", i+5];
                if([idxs containsObject:idx1])return;
                [self addBtnImageToScrollViewWithIdx:i+5 imgH:imgH];
            }
            if (i-5 >= 0 && prevX > sx) {
                NSString *idx2 = [NSString stringWithFormat:@"%d", i-5];
                if([idxs containsObject:idx2])return;
                [self addBtnImageToScrollViewWithIdx:i-5 imgH:imgH];
            }
        });
        prevX = sx;
    }
}

@end
