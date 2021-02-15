//
//  AttributeString.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/9.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AttributeString : UIView

/* 自适应富文本的高度
 *
 * @param string    文字
 * @param lineSpace 行间距
 * @param kern      字间距
 * @param font      字体大小
 * @param width     文本宽度
 *
 * @return size
 */
+ (CGSize)attributeHeightWithString:(NSString *)string lineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font width:(CGFloat)width;

/*
 *  设置行间距和字间距
 *
 *  @param string    字符串
 *  @param lineSpace 行间距
 *  @param kern      字间距
 *  @param font      字体大小
 *
 *  @return 富文本
 */
- (NSAttributedString *)setAttributedWithString:(NSString *)string WithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font;

/**
 UITextView文字超链接
 
 @param allStr 整个字符串
 @param changeStr 需要更改为超链接的部分字符
 @param changeStrColor 超链接字符颜色
 @param style 超链接字符的样式
 @return 返回的字符串
 */
+(NSMutableAttributedString *)HyperLinkWithAllStr:(NSString *)allStr ChangeString:(NSString *)changeStr ChangeStrColor:(UIColor *)changeStrColor StrStyle:(NSInteger)style;

@end

NS_ASSUME_NONNULL_END
