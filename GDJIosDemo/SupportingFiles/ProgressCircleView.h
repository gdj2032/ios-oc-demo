//
//  ProgressCircleView.h
//  DynaConnectShare
//
//  Created by 顾冬杰 on 2020/6/28.
//  Copyright © 2020 Dynabook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProgressCircleView : UIView

@property(assign,nonatomic)CGFloat startValue;
@property(assign,nonatomic)CGFloat lineWidth;
@property(assign,nonatomic)CGFloat value;
@property(strong,nonatomic)UIColor *lineColr;

- (void) changePersent:(CGFloat)persent;

@end

NS_ASSUME_NONNULL_END
