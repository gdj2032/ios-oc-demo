//
//  VideoPlayerSettingModel.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/29.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "VideoPlayerSettingModel.h"

@implementation VideoPlayerSettingModel

+ (instancetype)defaultConfigure {
    VideoPlayerSettingModel *configure = [[VideoPlayerSettingModel alloc] init];
    configure.repeatPlay = NO;
    configure.mute = NO;
    configure.isLandscape = NO;
    configure.smallGestureControl = NO;
    configure.autoRotate = YES;
    configure.fullGestureControl = YES;
    configure.backPlay = YES;
    configure.progressBackgroundColor = [UIColor colorWithRed:0.54118
                                               green:0.51373
                                                blue:0.50980
                                               alpha:1.00000];
    configure.progressTrackTintColor = red_color;
    configure.progressCacheColor = [UIColor colorWithRed:0.84118
                                               green:0.81373
                                                blue:0.80980
                                               alpha:1.00000];
    configure.strokeColor = [UIColor whiteColor];
    configure.videoFillMode = VideoFillModeResize;
    configure.topViewHiddenType = TopViewHiddenNever;
    configure.toolBarDisappearTime = 3;
    return configure;
}

@end
