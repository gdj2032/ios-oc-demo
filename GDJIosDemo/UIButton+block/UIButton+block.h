//
//  UIButton+block.h
//  DynaConnect
//
//  Created by 顾冬杰 on 2020/7/9.
//  Copyright © 2020 Dynabook. All rights reserved.
//

#import <UIKit/UIKit.h>
 
typedef void(^ActionBlock)(UIButton* button);
 
@interface UIButton (block)
 
@property (nonatomic, copy) ActionBlock actionBlock;
 
/**
 button 添加点击block事件
 @param action 点击事件回调
 */
- (void)addAction:(ActionBlock)action;
 
/**
 button 添加点击block事件
 @param controlEvents 点击的方式
 @param action 点击事件回调
 */
- (void)addControlEvents:(UIControlEvents)controlEvents Action:(ActionBlock)action;
 
@end
