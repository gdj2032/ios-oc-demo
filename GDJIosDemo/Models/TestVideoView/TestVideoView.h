//
//  TestVideoView.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/30.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DateFormat.h"
#import "TestMaskView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestVideoView : UIView

@property(nonatomic,strong)NSURL *url;

@end

NS_ASSUME_NONNULL_END
