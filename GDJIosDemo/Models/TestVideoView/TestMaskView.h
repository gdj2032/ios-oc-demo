//
//  TestMaskView.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/30.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestMaskView : UIView

@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UIButton *moreBtn;

@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIButton *playPauseBtn;
@property(nonatomic,strong)UIButton *fullBtn;
@property(nonatomic,strong)UILabel *currentTimeLabel;
@property(nonatomic,strong)UILabel *totalTimeLabel;
@property(nonatomic,strong)UIProgressView *progress;
@property(nonatomic,strong)UISlider *slider;

@end

NS_ASSUME_NONNULL_END
