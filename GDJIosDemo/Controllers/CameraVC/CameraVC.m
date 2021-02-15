//
//  CameraVC.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/13.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "CameraVC.h"

@interface CameraVC ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, assign)PhotoListModel *currentModel;
@property(nonatomic, strong)UIActivityIndicatorView *loading;
@property(nonatomic, strong)UIView *topView;
@property(nonatomic, strong)UIButton *backBtn;
@property(nonatomic, strong)UIButton *currentBtn; //当前照片集的按钮
@property(nonatomic, strong)UILabel *titleLabel; //照片集名称
@property(nonatomic, strong)UIImageView *arrowImage; //图标
@property(nonatomic, strong)PhotoListView *photoListView; //所有照片集视图

@end

@implementation CameraVC{
    CGRect initPhotoListViewFrame;
    BOOL isShowList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self load];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}

-(void)load{
    self.view.backgroundColor = white_color;
    isShowList = NO;
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44 + kStatusBarHeight)];
    _topView.backgroundColor = gray_color;
    
//    _loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    _loading.hidesWhenStopped = YES;
//    _loading.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    _loading.backgroundColor = gray_color0;
//    _loading.color = [UIColor blackColor];
//    _loading.layer.opacity = 0.6;
//    [_loading startAnimating];
//    [self.view addSubview:_loading];

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _topView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - _topView.frame.size.height)];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    AppDelegate *myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    _models = myAppDelegate.models;
    
    PhotoListModel *firmodels = [_models firstObject];
    _currentModel = firmodels;
    [self showWithURLs:_currentModel];
    [self initPhotoScrollView];
    [self showTopView];
    [self.view addSubview:_topView];
//    [_loading stopAnimating];
}


-(void)showTopView{
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(RESERVE_WIDTH, kStatusBarHeight, 60, 44);
    [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [_backBtn setTitleColor:black_color forState:UIControlStateNormal];
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    _currentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _currentBtn.backgroundColor = gray_color2;
    _currentBtn.layer.cornerRadius = 12;
    _currentBtn.layer.masksToBounds = YES;
    _currentBtn.userInteractionEnabled = YES;
    [_currentBtn addTarget:self action:@selector(showHiddenPhotoListViewClick) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = [_currentModel title];
    _titleLabel.font = [UIFont systemFontOfSize:16.0];
    _titleLabel.textColor = black_color;
    [_titleLabel sizeToFit];
    CGFloat titleW = _titleLabel.frame.size.width;
    _titleLabel.frame = CGRectMake(10, 0, titleW, 28);
    
    _arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(10 + titleW + 12, 4, 20, 20)];
    _arrowImage.backgroundColor = white_color;
    _arrowImage.layer.cornerRadius = 10;
    _arrowImage.layer.masksToBounds = YES;
    [_arrowImage setImage:[UIImage imageNamed:@"arrow_down"]];
    
    CGFloat cbtnW = titleW + 28 + 20 + 4;
    _currentBtn.frame = CGRectMake((SCREEN_WIDTH - cbtnW)/2, kStatusBarHeight + 8, cbtnW, 28);
    
    [_currentBtn addSubview:_arrowImage];
    [_currentBtn addSubview:_titleLabel];
    [_topView addSubview:_backBtn];
    [_topView addSubview:_currentBtn];
}

-(void)initPhotoScrollView{
    CGFloat photoListY = _topView.frame.size.height;
    CGFloat photoListViewH = SCREEN_HEIGHT - photoListY;
    CGFloat cellH = 60;
    CGRect f = CGRectMake(0, photoListY, SCREEN_WIDTH, photoListViewH);
    initPhotoListViewFrame = f;
    _photoListView = [[PhotoListView alloc] initPhotoListViewWithModels:_models withCellHeight:cellH withFrame:f];
    _photoListView.photoListViewDelegate = self;
    [self.view addSubview:_photoListView];
     _photoListView.frame = CGRectMake(initPhotoListViewFrame.origin.x, initPhotoListViewFrame.origin.y - initPhotoListViewFrame.size.height, initPhotoListViewFrame.size.width, initPhotoListViewFrame.size.height);
}

-(void)showWithURLs:(PhotoListModel*)pmodel {
    NSInteger col = 4;
    CGFloat imgW = SCREEN_WIDTH/col;
    CGFloat imgH = imgW;
    NSArray *arr = [pmodel list];
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, imgH * ((arr.count / col) + 1));
    for (int i = 0; i < arr.count; i++) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
            CGFloat imgX = imgW *(i % col);
            CGFloat imgY = imgH * (i / col);
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(imgX, imgY, imgW, imgH);
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = black_color.CGColor;
            NSData * data = [NSData dataWithContentsOfURL:arr[i]];
            UIImage *img = [UIImage imageWithData:data];
            if (img.size.width > imgW * 2) {
                img = [NSUtils compressImage:img toTargetWidth:imgW*2];
            }
            [btn setImage:img forState:UIControlStateNormal];
            btn.tag = i;
            btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
            [btn addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.scrollView addSubview:btn];
            });
        });
    }
}

-(void)showHiddenPhotoListViewClick{
    if (isShowList){
        [self closePhotoListView];
    } else {
        [self showPhotoListView];
    }
}

-(void)imageClick:(UIButton*)btn{
    int tag = (int) btn.tag;
    NSLog(@"tag = %d",tag);
    CheckImageVC *vc = [[CheckImageVC alloc] init];
    vc.idx = tag;
    vc.urls = [_currentModel list];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 监控视图滚动位置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //    NSLog(@"scrollView.contentOffset.y = %f", scrollView.contentOffset.y);
}
#pragma mark -- 即将开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //    NSLog(@"即将开始拖拽");
}
#pragma mark -- 即将结束拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"即将结束拖拽");
}
//#pragma mark -- 结束拖拽时
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    //    NSLog(@"结束拖拽时");
//}
//#pragma mark -- 即将减速滚动时
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    //    NSLog(@"即将减速滚动时");
//}
//#pragma mark -- 停止滚动
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    //    NSLog(@"停止滚动");
//}
//#pragma mark -- 点击空白处,让视图滚动到指定位置
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    //点击空白处,让视图滚动到指定位置
//    //    _scrollview.contentOffset = CGPointMake(0, 0);
//    //    NSLog(@"touchesBegan");
//    //    CGFloat width = self.view.frame.size.width;
//    //    CGFloat height = self.view.frame.size.height;
//    //    [_scrollView scrollRectToVisible:CGRectMake(0, 0, width, height / 2) animated:YES];
//}

-(void)showPhotoListView{
    isShowList = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.photoListView.frame = self->initPhotoListViewFrame;
        CGAffineTransform transform = self.arrowImage.transform;
        self.arrowImage.transform = CGAffineTransformRotate(transform, M_PI);
    }];
}

-(void)closePhotoListView{
    isShowList = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.photoListView.frame = CGRectMake(self->initPhotoListViewFrame.origin.x, self->initPhotoListViewFrame.origin.y - self->initPhotoListViewFrame.size.height, self->initPhotoListViewFrame.size.width, self->initPhotoListViewFrame.size.height);
        CGAffineTransform transform = self.arrowImage.transform;
        self.arrowImage.transform = CGAffineTransformRotate(transform, M_PI);
    }];
}

-(void)hiddenPhotoListViewWithIdx:(int)idx WithIsUpdate:(BOOL)isUpdate{
    NSLog(@"CameraVC hiddenPhotoListView");
    if (isUpdate) {
        _currentModel = _models[idx];
        [self showWithURLs:_currentModel];
        [UIView animateWithDuration:0.3 animations:^{
            self.titleLabel.text = self.currentModel.title;
            [self.titleLabel sizeToFit];
            CGFloat titleW = self.titleLabel.frame.size.width;
            self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, titleW, self.currentBtn.frame.size.height);
            self.arrowImage.frame = CGRectMake(titleW + 22, self.arrowImage.frame.origin.y, self.arrowImage.frame.size.width, self.arrowImage.frame.size.height);
            CGFloat cbtnW = titleW + self.titleLabel.frame.size.height + self.arrowImage.frame.size.height + 4;
            self.currentBtn.frame = CGRectMake((SCREEN_WIDTH - cbtnW)/2, self.currentBtn.frame.origin.y, cbtnW, self.currentBtn.frame.size.height);
        }];
    }
    [self closePhotoListView];
}

@end
