//
//  AttributeString.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/9.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "AttributeString.h"

@implementation AttributeString

#pragma mark -- 富文本自适应高度
+ (CGSize)attributeHeightWithString:(NSString *)string lineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font width:(CGFloat)width {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpace;
    NSDictionary *attriDict = @{
                            NSParagraphStyleAttributeName:paragraphStyle,
                                NSKernAttributeName:@(kern),
                                NSFontAttributeName:font};
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attriDict context:nil].size;
    return size;
}

#pragma mark -- 设置行间距和字间距
- (NSAttributedString *)setAttributedWithString:(NSString *)string WithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern font:(UIFont *)font{
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    //调整行间距
    paragraphStyle.lineSpacing = lineSpace;
    NSDictionary *attriDict = @{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(kern),
        NSFontAttributeName:font};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string attributes:attriDict];
    return attributedString;
}

#pragma mark -- UITextView文字超链接
+(NSMutableAttributedString *)HyperLinkWithAllStr:(NSString *)allStr ChangeString:(NSString *)changeStr ChangeStrColor:(UIColor *)changeStrColor StrStyle:(NSInteger)style {
    NSString *str = [NSString stringWithFormat:@"%@", allStr];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str]; // assume string exists
    NSRange urlRange = [str rangeOfString:changeStr];
    [string addAttribute:NSLinkAttributeName
                   value:changeStr
                   range:urlRange];
    [string addAttribute:NSForegroundColorAttributeName
                   value:changeStrColor
                   range:urlRange];
    [string addAttribute:NSUnderlineStyleAttributeName
                   value:@(style)
                   range:urlRange];
    return string;
    
}

@end
