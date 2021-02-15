//
//  CustomAlert.h
//  DynaConnect
//
//  Created by 顾冬杰 on 2020/7/8.
//  Copyright © 2020 Dynabook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RichTextBlock)(NSString *key);

@interface CustomAlert : UIView

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UITextView *message;
@property (nonatomic, strong) UILabel *line;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UILabel *btnline;
@property (nonatomic, strong) UIButton *rightBtn;

+ (instancetype)shareCustomAlert;

-(instancetype) initCustomAlertWithTitle:(NSString*)title withMessage:(NSString*)message clickTitle:(NSString*__nullable)clickTitle withLeftText:(NSString*)leftText withRightText:(NSString*)rightText withleftComplete:(void(^__nullable)(void))leftComplete withrightComplete:(void(^__nullable)(void))rightComplete withKey:(NSString *__nullable)key;

-(void) showAlert;

-(void) closeAlert;

///回调富文本点击
- (void)richTextClick:(RichTextBlock) key;

@end

NS_ASSUME_NONNULL_END
