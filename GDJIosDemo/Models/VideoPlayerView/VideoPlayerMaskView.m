//
//  VideoPlayerMaskView.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/29.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

//间隙
#define Padding 10
//顶部底部视图高度
#define TopBottomHeight 48

#import "VideoPlayerMaskView.h"

@implementation VideoPlayerMaskView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initViews];
        [self makeConstraints];
    }
    return self;
}
- (void)initViews{
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    [self addSubview:self.loadingView];
    [self addSubview:self.failButton];
    [self.topView addSubview:self.backButton];
    [self.topView addSubview:self.moreButton];
    [self.bottomView addSubview:self.playPauseButton];
    [self.bottomView addSubview:self.fullButton];
    [self.bottomView addSubview:self.currentTimeLabel];
    [self.bottomView addSubview:self.totalTimeLabel];
    [self.bottomView addSubview:self.progress];
    [self.bottomView addSubview:self.slider];
    self.topView.backgroundColor = [UIColor colorWithRed:0.00000f green:0.00000f blue:0.00000f alpha:0.20000f];
    self.bottomView.backgroundColor = [UIColor colorWithRed:0.00000f green:0.00000f blue:0.00000f alpha:0.20000f];
}
#pragma mark - 约束
- (void)makeConstraints{
    //顶部视图
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(TopBottomHeight);
    }];
    //底部视图
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(TopBottomHeight);
    }];
    //转子
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    //返回按钮
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Padding);
        if (@available(iOS 11.0, *)) {
            make.left.mas_equalTo(self.mas_safeAreaLayoutGuideLeft).mas_offset(Padding);
        } else {
            make.left.mas_equalTo(Padding);
        }
        make.bottom.mas_equalTo(-Padding);
        make.width.mas_equalTo(self.backButton.mas_height);
    }];
    //更多按钮
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Padding);
        if (@available(iOS 11.0, *)) {
            make.right.mas_equalTo(self.mas_safeAreaLayoutGuideRight).mas_offset(-Padding);
        } else {
            make.right.mas_equalTo(-Padding);
        }
        make.bottom.mas_equalTo(-Padding);
        make.width.mas_equalTo(self.moreButton.mas_height);
    }];
    //播放按钮
    [self.playPauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Padding);
        if (@available(iOS 11.0, *)) {
            make.left.mas_equalTo(self.mas_safeAreaLayoutGuideLeft).mas_offset(Padding);
        } else {
            make.left.mas_equalTo(Padding);
        }
        make.bottom.mas_equalTo(-Padding);
        make.width.mas_equalTo(self.playPauseButton.mas_height);
    }];
    //全屏按钮
    [self.fullButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-Padding);
        if (@available(iOS 11.0, *)) {
            make.right.mas_equalTo(self.mas_safeAreaLayoutGuideRight).mas_offset(-Padding);
        } else {
            make.right.mas_equalTo(-Padding);
        }
        make.top.mas_equalTo(Padding);
        make.width.mas_equalTo(self.fullButton.mas_height);
    }];
    //当前播放时间
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.playPauseButton.mas_right).mas_offset(Padding);
        make.width.mas_equalTo(45);
        make.centerY.mas_equalTo(self.bottomView);
    }];
    //总时间
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.fullButton.mas_left).mas_offset(-Padding);
        make.width.mas_equalTo(45);
        make.centerY.mas_equalTo(self.bottomView);
    }];
    //缓冲条
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.currentTimeLabel.mas_right).mas_offset(Padding).priority(50);
        make.right.mas_equalTo(self.totalTimeLabel.mas_left).mas_offset(-Padding);
        make.height.mas_equalTo(2);
        make.centerY.mas_equalTo(self.bottomView);
    }];
    //滑杆
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.progress);
    }];
    //失败按钮
    [self.failButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
}
#pragma mark -- 设置颜色
-(void)setProgressBackgroundColor:(UIColor *)progressBackgroundColor{
    _progressBackgroundColor = progressBackgroundColor;
    _progress.trackTintColor = progressBackgroundColor;
}
-(void)setProgressCacheColor:(UIColor *)progressCacheColor{
    _progressCacheColor = progressCacheColor;
    _progress.progressTintColor = progressCacheColor;
}
-(void)setProgressTrackTintColor:(UIColor *)progressTrackTintColor{
    _progressTrackTintColor = progressTrackTintColor;
    _slider.minimumTrackTintColor = _progressTrackTintColor;
}
#pragma mark - 懒加载
//顶部视图
- (UIView *) topView{
    if (_topView == nil){
        _topView = [[UIView alloc] init];
        _topView.userInteractionEnabled = YES;
    }
    return _topView;
}
//底部视图
- (UIView *) bottomView{
    if (_bottomView == nil){
        _bottomView = [[UIView alloc] init];
        _bottomView.userInteractionEnabled = YES;
    }
    return _bottomView;
}
//转子
- (LoadingView *) loadingView{
    if (_loadingView == nil){
        _loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_loadingView startAnimation];
    }
    return _loadingView;
}
//返回按钮
- (UIButton *) backButton{
    if (_backButton == nil){
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateHighlighted];
        [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
//更多按钮
-(UIButton *)moreButton{
    if (_moreButton == nil){
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setImage:[UIImage imageNamed:@"more_white"] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"more_white"] forState:UIControlStateHighlighted];
        [_moreButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}
//播放按钮
- (UIButton *) playPauseButton{
    if (_playPauseButton == nil){
        _playPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playPauseButton setImage:[UIImage imageNamed:@"play_white"] forState:UIControlStateNormal];
        [_playPauseButton setImage:[UIImage imageNamed:@"pause_white"] forState:UIControlStateSelected];
        [_playPauseButton addTarget:self action:@selector(playPauseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playPauseButton;
}
//全屏按钮
- (UIButton *) fullButton{
    if (_fullButton == nil){
        _fullButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullButton setImage:[UIImage imageNamed:@"full_screen"] forState:UIControlStateNormal];
        [_fullButton setImage:[UIImage imageNamed:@"exit_full_screen"] forState:UIControlStateSelected];
        [_fullButton addTarget:self action:@selector(fullButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullButton;
}
//当前播放时间
- (UILabel *) currentTimeLabel{
    if (_currentTimeLabel == nil){
        _currentTimeLabel = [[UILabel alloc] init];
        _currentTimeLabel.font = [UIFont systemFontOfSize:14];
        _currentTimeLabel.textColor = [UIColor whiteColor];
        _currentTimeLabel.adjustsFontSizeToFitWidth = YES;
        _currentTimeLabel.text = @"00:00";
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _currentTimeLabel;
}
//总时间
- (UILabel *) totalTimeLabel{
    if (_totalTimeLabel == nil){
        _totalTimeLabel = [[UILabel alloc] init];
        _totalTimeLabel.font = [UIFont systemFontOfSize:14];
        _totalTimeLabel.textColor = [UIColor whiteColor];
        _totalTimeLabel.adjustsFontSizeToFitWidth = YES;
        _totalTimeLabel.text = @"00:00";
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalTimeLabel;
}
//缓冲条
- (UIProgressView *) progress{
    if (_progress == nil){
        _progress = [[UIProgressView alloc] init];
    }
    return _progress;
}
//滑动条
- (UISlider *) slider{
    if (_slider == nil){
        _slider = [[UISlider alloc] init];
        [_slider setThumbImage:[UIImage imageNamed:@"slider_circle"] forState:UIControlStateNormal];
        // slider开始滑动事件
        [_slider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        // slider滑动中事件
        [_slider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        // slider结束滑动事件
        [_slider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
        //右边颜色
        _slider.maximumTrackTintColor = [UIColor clearColor];
        //添加slider点击手势
        _sliderGestrue = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(progressSliderTap:)];
        _sliderGestrue.delegate = self;
        [_slider addGestureRecognizer:_sliderGestrue];
    }
    return _slider;
}
//加载失败按钮
- (UIButton *) failButton
{
    if (_failButton == nil) {
        _failButton = [[UIButton alloc] init];
        _failButton.hidden = YES;
        [_failButton setTitle:@"加载失败,点击重试" forState:UIControlStateNormal];
        [_failButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _failButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _failButton.backgroundColor = [UIColor colorWithRed:0.00000f green:0.00000f blue:0.00000f alpha:0.50000f];
        [_failButton addTarget:self action:@selector(failButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _failButton;
}
#pragma mark - 按钮点击事件
//返回按钮
- (void)backButtonAction:(UIButton *)button{
    if (_delegate && [_delegate respondsToSelector:@selector(backClickMaskDelegate:)]) {
        [_delegate backClickMaskDelegate:button];
    }else{
        NSLog(@"未实现代理");
    }
}
- (void)moreButtonAction:(UIButton *)button{
    if (_delegate && [_delegate respondsToSelector:@selector(moreClickMaskDelegate:)]) {
        [_delegate moreClickMaskDelegate:button];
    }else{
        NSLog(@"未实现代理");
    }
}
//播放按钮
- (void)playPauseButtonAction:(UIButton *)button{
    button.selected = !button.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(playPauseClickMaskDelegate:)]) {
        [_delegate playPauseClickMaskDelegate:button];
    }else{
        NSLog(@"未实现代理");
    }
}
//全屏按钮
- (void)fullButtonAction:(UIButton *)button{
    button.selected = !button.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(fullClickMaskDelegate:)]) {
        [_delegate fullClickMaskDelegate:button];
    }else{
        NSLog(@"未实现代理");
    }
}
//失败按钮
- (void)failButtonAction:(UIButton *)button{
    self.failButton.hidden = YES;
    self.loadingView.hidden = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(failClickMaskDelegate:)]) {
        [_delegate failClickMaskDelegate:button];
    }else{
        NSLog(@"未实现代理");
    }
}
#pragma mark - 滑杆
//开始滑动
- (void)progressSliderTouchBegan:(UISlider *)slider{
    _sliderGestrue.enabled = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(progressSliderTouchBeganMaskDelegate:)]) {
        [_delegate progressSliderTouchBeganMaskDelegate:slider];
    }else{
        NSLog(@"未实现代理");
    }
}
//滑动中
- (void)progressSliderValueChanged:(UISlider *)slider{
    if (_delegate && [_delegate respondsToSelector:@selector(progressSliderValueChangedMaskDelegate:)]) {
        [_delegate progressSliderValueChangedMaskDelegate:slider];
    }else{
        NSLog(@"未实现代理");
    }
}
//滑动结束
- (void)progressSliderTouchEnded:(UISlider *)slider{
    _sliderGestrue.enabled = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(progressSliderTouchEndedMaskDelegate:)]) {
        [_delegate progressSliderTouchEndedMaskDelegate:slider];
    }else{
        NSLog(@"未实现代理");
    }
}
//点击slider
-(void)progressSliderTap:(UITapGestureRecognizer*)tap{
    CGPoint touchPoint = [tap locationInView:_slider];
    CGFloat value = (_slider.maximumValue - _slider.minimumValue) * (touchPoint.x / _slider.frame.size.width );
    [_slider setValue:value animated:YES];
    if (_delegate && [_delegate respondsToSelector:@selector(progressSliderTapMaskDelegate:)]) {
        [_delegate progressSliderTapMaskDelegate:value];
    }else{
        NSLog(@"未实现代理");
    }
}

@end
