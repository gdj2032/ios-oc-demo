//
//  TestMaskView.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/30.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "TestMaskView.h"

@interface TestMaskView()

@end

@implementation TestMaskView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    [self addSubview:_topView];
    [self addSubview:_bottomView];
    [_topView addSubview:_backBtn];
    [_topView addSubview:_moreBtn];
    
    _topView.backgroundColor = [black_color colorWithAlphaComponent:0.2];
    _bottomView.backgroundColor = [black_color colorWithAlphaComponent:0.2];
}
#pragma mark --懒加载
-(UIView *)topView{
    if(!_topView){
        _topView = [[UIView alloc] init];
        _topView.userInteractionEnabled = YES;
    }
    return _topView;
}
-(UIView *)bottomView{
    if(!_bottomView){
        _bottomView = [[UIView alloc] init];
        _bottomView.userInteractionEnabled = YES;
    }
    return _bottomView;
}
-(UIButton *)backBtn{
    if(!_backBtn){
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
-(UIButton *)moreBtn{
    if(!_moreBtn){
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:[UIImage imageNamed:@"more_white"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}
-(UIButton *)playPauseBtn{
    if(!_playPauseBtn){
        _playPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playPauseBtn setImage:[UIImage imageNamed:@"play_white"] forState:UIControlStateNormal];
        [_playPauseBtn setImage:[UIImage imageNamed:@"pause_white"] forState:UIControlStateSelected];
        [_playPauseBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

#pragma mark ---------------点击
-(void)backClick:(UIButton*)btn{
    
}


@end
