//
//  Toast.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/6/19.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Toast : UILabel

@property(nonatomic, strong) UILabel *toastLabel;

@property(nonatomic, strong) NSTimer *showTimer;

+ (instancetype)shareToast;

/**
* @brief 轻提示
*
* @param message 提示内容
* @param duration 显示时间 default 1s
*
*/
- (instancetype)showToast:(NSString *)message duration:(CGFloat)duration;

@end

NS_ASSUME_NONNULL_END

