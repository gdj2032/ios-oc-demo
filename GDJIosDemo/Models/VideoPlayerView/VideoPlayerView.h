//
//  VideoPlayerView.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/29.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoPlayerMaskView.h"
#import "VideoPlayerSettingModel.h"
#import "DateFormat.h"
#import "GCDTimerManager.h"

typedef void(^BackButtonBlock)(UIButton * _Nullable button);
typedef void(^EndBolck)(void);

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayerView : UIView

///视频url
@property (nonatomic, strong) NSURL                   *url;

///更新播放器基本设置
- (void)updateWithConfigure:(void(^)(VideoPlayerSettingModel *setting))settingBlock;

///播放
- (void)playVideo;
///暂停
- (void)pauseVideo;
///返回按钮回调方法，只有小屏会调用，全屏点击默认回到小屏
- (void)backButton:(BackButtonBlock) backButton;
///播放完成回调
- (void)endPlay:(EndBolck) end;
///销毁播放器
- (void)destroyPlayer;

@end

NS_ASSUME_NONNULL_END
