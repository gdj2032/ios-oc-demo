//
//  AlertView.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/9.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertView : UIView

+ (AlertView *)shareAlertView;

/**
 * @brief 带有单按钮的弹出视图 颜色可以不填
 *
 * @param title 标题
 * @param message 内容
 * @param btnTitle 按钮标题
 * @param btnTitleColor 按钮颜色
 * @param completion 按钮点击事件
 *
 */
- (void)alertWithTitle:(NSString *)title message:(NSString *)message btnTitle:(NSString *)btnTitle btnTitleColor:(nullable UIColor *)btnTitleColor completion:(void(^__nullable)(void))completion;

/**
 * @brief 带有双按钮的弹出视图 颜色可以不填
 *
 * @param title 标题
 * @param message 内容
 * @param leftBtnTitle 左侧按钮标题
 * @param leftBtnTitleColor 左侧按钮颜色
 * @param leftBtnClicked 左侧按钮点击事件
 * @param rightBtnTitle 右侧按钮标题
 * @param rightBtnTitleColor 右侧按钮颜色
 * @param rightBtnClicked 右侧按钮点击事件
 *
 */
- (void)alertWIthTitle:(NSString *)title message:(NSString *)message leftBtnTitle:(NSString *)leftBtnTitle leftBtnTitleColor:(nullable UIColor *)leftBtnTitleColor leftBtnClicked:(void(^__nullable)(void))leftBtnClicked rightBtnTitle:(NSString *)rightBtnTitle rightBtnTitleColor:(nullable UIColor *)rightBtnTitleColor rightBtnClicked:(void(^__nullable)(void))rightBtnClicked;

/**多行文本，左对齐*/
- (void)alertWithTitle:(NSString *)title messageToLeft:(NSString *)message btnTitle:(NSString *)btnTitle btnTitleColor:(nullable UIColor *)btnTitleColor completion:(void(^__nullable)(void))completion;
@end

NS_ASSUME_NONNULL_END
