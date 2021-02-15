//
//  VideoPlayerMaskView.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/29.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingView.h"
#import "Masonry.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VideoPlayerMaskViewDelegate <NSObject>
///返回按钮代理
- (void)backClickMaskDelegate:(UIButton *)button;
///更多按钮代理
- (void)moreClickMaskDelegate:(UIButton *)button;
///播放按钮代理
- (void)playPauseClickMaskDelegate:(UIButton *)button;
///全屏按钮代理
- (void)fullClickMaskDelegate:(UIButton *)button;
///开始滑动
- (void)progressSliderTouchBeganMaskDelegate:(UISlider *)slider;
///滑动中
- (void)progressSliderValueChangedMaskDelegate:(UISlider *)slider;
///滑动结束
- (void)progressSliderTouchEndedMaskDelegate:(UISlider *)slider;
///点击slider
- (void)progressSliderTapMaskDelegate:(CGFloat)value;
///失败按钮代理
- (void)failClickMaskDelegate:(UIButton *)button;
@end

@interface VideoPlayerMaskView : UIView<UIGestureRecognizerDelegate>

/**顶部视图*/
@property (nonatomic,strong) UIView *topView;
/**底部视图*/
@property (nonatomic,strong) UIView *bottomView;
/**loading*/
@property (nonatomic,strong) LoadingView *loadingView;
/**顶部视图返回按钮*/
@property (nonatomic,strong) UIButton *backButton;
/**顶部视图更多按钮*/
@property (nonatomic,strong) UIButton *moreButton;
/**底部视图播放按钮*/
@property (nonatomic,strong) UIButton *playPauseButton;
/**底部视图全屏按钮*/
@property (nonatomic,strong) UIButton *fullButton;
/**底部视图当前播放时间*/
@property (nonatomic,strong) UILabel *currentTimeLabel;
/**底部视图视频总时间*/
@property (nonatomic,strong) UILabel *totalTimeLabel;
/**缓冲进度条*/
@property (nonatomic,strong) UIProgressView *progress;
/**播放进度条*/
@property (nonatomic,strong) UISlider *slider;
@property (nonatomic,strong) UITapGestureRecognizer *sliderGestrue;
/**加载失败按钮*/
@property (nonatomic,strong) UIButton *failButton;
/**代理*/
@property (nonatomic,weak) id<VideoPlayerMaskViewDelegate> delegate;
/**进度条背景颜色*/
@property (nonatomic,strong) UIColor *progressBackgroundColor;
/**缓冲条缓冲进度颜色*/
@property (nonatomic,strong) UIColor *progressCacheColor;
/**进度条播放完成颜色*/
@property (nonatomic,strong) UIColor *progressTrackTintColor;

@end

NS_ASSUME_NONNULL_END
