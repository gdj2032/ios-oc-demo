//
//  VideoPlayerSettingModel.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/29.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,VideoFillMode){
    VideoFillModeResize = 0,       ///<拉伸占满整个播放器，不按原比例拉伸
    VideoFillModeResizeAspect,     ///<按原视频比例显示，是竖屏的就显示出竖屏的，两边留黑
    VideoFillModeResizeAspectFill, ///<按照原比例拉伸占满整个播放器，但视频内容超出部分会被剪切
};
typedef NS_ENUM(NSUInteger, TopViewHiddenType) {
    TopViewHiddenNever = 0, ///<小屏和全屏都不隐藏
    TopViewHiddenAlways,    ///<小屏和全屏都隐藏
    TopViewHiddenSmall,     ///<小屏隐藏，全屏不隐藏
};

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayerSettingModel : UIView

/**后台返回是否自动播放，默认Yes,会跟随用户，如果是播放状态进入后台，返回会继续播放*/
@property (nonatomic, assign) BOOL                    backPlay;
/**重复播放,默认No*/
@property (nonatomic, assign) BOOL                    repeatPlay;
/**当前页面是否支持横屏,默认NO*/
@property (nonatomic, assign) BOOL                    isLandscape;
/**自动旋转，默认Yes*/
@property (nonatomic, assign) BOOL                    autoRotate;
/**静音,默认为NO*/
@property (nonatomic, assign) BOOL                    mute;
/**小屏手势控制,默认NO*/
@property (nonatomic, assign) BOOL                    smallGestureControl;
/**全屏手势控制,默认Yes*/
@property (nonatomic, assign) BOOL                    fullGestureControl;;
/**视图消失时间，默认10s*/
@property (nonatomic, assign) NSInteger               toolBarDisappearTime;
/**拉伸方式，默认全屏填充*/
@property (nonatomic, assign) VideoFillMode           videoFillMode;
/**顶部视图隐藏方式，默认不隐藏*/
@property (nonatomic, assign) TopViewHiddenType    topViewHiddenType;

/**进度条背景颜色*/
@property (nonatomic, strong) UIColor                 *progressBackgroundColor;
/**缓冲条缓冲进度颜色*/
@property (nonatomic, strong) UIColor                 *progressCacheColor;
/**进度条播放完成颜色*/
@property (nonatomic, strong) UIColor                 *progressTrackTintColor;
/**转子背景颜色*/
@property (nonatomic, strong) UIColor                 *strokeColor;

/**
 默认配置
 @return 配置
 */
+ (instancetype)defaultConfigure;

@end

NS_ASSUME_NONNULL_END
