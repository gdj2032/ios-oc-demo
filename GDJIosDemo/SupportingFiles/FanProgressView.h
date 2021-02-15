//
//  FanProgressView.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/22.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    FanStartAngleTop = 1,
    FanStartAngleLeft,
    FanStartAngleRight,
    FanStartAngleBottom,
} FanProgressStartAngle;

NS_ASSUME_NONNULL_BEGIN

@interface FanProgressView : UIView

+(instancetype)shareFanProgressView;

-(instancetype)initFanProgressViewWithFrame:(CGRect)frame WithRadius:(CGFloat)radius withFillColor:(UIColor*)fillColor withStartAngle:(FanProgressStartAngle)startAngle;

-(void)changeProgress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
