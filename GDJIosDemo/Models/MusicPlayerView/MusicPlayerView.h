//
//  MusicPlayerView.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/23.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MusicPlayerViewModel.h"
#import "DateFormat.h"
#import <MediaPlayer/MediaPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicPlayerView : UIView

@property(nonatomic,strong)MusicPlayerViewModel*musicData;

-(instancetype)initWithFrame:(CGRect)frame;

-(void)stop;

@end

NS_ASSUME_NONNULL_END
