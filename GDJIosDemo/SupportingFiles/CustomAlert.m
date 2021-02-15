//
//  CustomAlert.m
//  DynaConnect
//
//  Created by 顾冬杰 on 2020/7/8.
//  Copyright © 2020 Dynabook. All rights reserved.
//

#import "CustomAlert.h"
#import "AttributeString.h"
#import "UIButton+block.h"

@interface CustomAlert () <UITextViewDelegate>

///回调富文本点击
@property (nonatomic, copy) void (^keyBlock) (NSString *key);

@end

@implementation CustomAlert

static CGFloat alertW = 270;

+(instancetype)shareCustomAlert {
    static CustomAlert *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[CustomAlert alloc] init];
    });
    return singleton;
}

- (instancetype)initCustomAlertWithTitle:(NSString *)title withMessage:(NSString *)message clickTitle:(NSString*)clickTitle withLeftText:(NSString *)leftText withRightText:(NSString *)rightText withleftComplete:(void (^__nullable)(void))leftComplete withrightComplete:(void (^__nullable)(void))rightComplete withKey:(NSString *)key{
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _view.backgroundColor = [black_color colorWithAlphaComponent:0.4];
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, alertW, 100)];
    _alertView.backgroundColor = white_color;
    _alertView.layer.cornerRadius = 20;
    _alertView.layer.masksToBounds = YES;
    
    //title
    _title = [[UILabel alloc] initWithFrame: CGRectMake(0, 8, alertW, 54)];
    _title.text = title;
    _title.numberOfLines = 0;
    _title.textColor = black_color;
    _title.font = [UIFont systemFontOfSize:18];
    _title.textAlignment = NSTextAlignmentCenter;
    CGSize titlesize = [AttributeString attributeHeightWithString:title lineSpace:0 kern:0 font:_title.font width:alertW];
    _title.frame = CGRectMake(0, 8, alertW, titlesize.height);
    
    CGFloat titleYH = _title.frame.size.height + _title.frame.origin.y;
    
    //message
    _message = [[UITextView alloc] init];
    _message.delegate = self;
    _message.editable = NO;
    _message.selectable = YES;
    _message.scrollEnabled = NO;
    _message.dataDetectorTypes = UIDataDetectorTypeAll;
    _message.backgroundColor = white_color;
    _message.textColor = black_color;
    _message.text = message;
    //高度自适应
    _message.textContainerInset = UIEdgeInsetsZero;
    _message.textContainer.lineFragmentPadding = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:message];
    if(clickTitle) {
        [attributedString addAttribute:NSLinkAttributeName
                                 value:[NSString stringWithFormat:@"clickTitle://key=%@", key]
                                 range:[[attributedString string] rangeOfString:clickTitle]];
    }
    //保证字符串的完整性不会因为是英文或者数字的整体换行
    NSMutableParagraphStyle* linebreak = [[NSMutableParagraphStyle alloc]init];
    linebreak.lineBreakMode = NSLineBreakByCharWrapping;
    linebreak.lineSpacing = 2;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:linebreak range:NSMakeRange (0, attributedString.length)];
    _message.attributedText = attributedString;
    _message.font = [UIFont systemFontOfSize:16];
    _message.linkTextAttributes = @{
        NSForegroundColorAttributeName: blue_color,
        NSUnderlineColorAttributeName: [UIColor clearColor],
        NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
    };
    CGSize msgsize = [AttributeString attributeHeightWithString:message lineSpace:linebreak.lineSpacing kern:0 font:_message.font width:alertW-20];
    _message.frame = CGRectMake(10, titleYH + 10, alertW - 20, msgsize.height);
    //灰色线
    CGFloat lineY = _message.frame.origin.y + _message.frame.size.height;
    _line = [[UILabel alloc] initWithFrame: CGRectMake(0, lineY, alertW, 1)];
    _line.backgroundColor = gray_color0;
    
    //按钮
    CGFloat btnY = lineY + 1;
    CGFloat btnH = 48;
    //不同意
    _leftBtn = [[UIButton alloc] initWithFrame: CGRectMake(0, btnY, alertW / 2, btnH)];
    [_leftBtn setTitle:leftText forState:UIControlStateNormal];
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_leftBtn setTitleColor:blue_color forState:UIControlStateNormal];
    [_leftBtn setTitleColor:gray_color0 forState:UIControlStateHighlighted];
    
    __weak typeof(self) weakSelf = self;
    
    _leftBtn.actionBlock = ^(UIButton *btn) {
        [weakSelf closeAlert];
        leftComplete();
    };
    
    //按钮之间的线
    _btnline = [[UILabel alloc] initWithFrame: CGRectMake((alertW - 1) / 2, btnY, 1, btnH)];
    _btnline.backgroundColor = gray_color0;
    
    //同意
    _rightBtn = [[UIButton alloc] initWithFrame: CGRectMake(alertW / 2, btnY, alertW / 2, btnH)];
    [_rightBtn setTitle:rightText forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_rightBtn setTitleColor:blue_color forState:UIControlStateNormal];
    [_rightBtn setTitleColor:gray_color0 forState:UIControlStateHighlighted];
    _rightBtn.actionBlock = ^(UIButton *btn) {
        [weakSelf closeAlert];
        rightComplete();
    };
    
    [_alertView addSubview:_rightBtn];
    [_alertView addSubview:_btnline];
    [_alertView addSubview:_leftBtn];
    [_alertView addSubview:_line];
    [_alertView addSubview:_message];
    [_alertView addSubview:_title];
    
    CGFloat alertH = btnY + btnH;
    _alertView.frame = CGRectMake(0, 0, alertW, alertH);
    _alertView.center = _view.center;
    
    [_view addSubview:_alertView];
    
    _view.layer.opacity = 0;
    
    [self showAlert];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:_view];
    return self;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    if ([[URL scheme] isEqualToString:@"clickTitle"]) {
        NSArray *array = [[NSString stringWithFormat:@"%@",URL] componentsSeparatedByString:@"//key="];
        [self closeAlert];
        self.keyBlock(array[1]);
        return NO;
    }
    return YES;
}

-(void)richTextClick:(RichTextBlock)key{
    self.keyBlock = key;
}

- (void)showAlert {
    [UIView animateWithDuration:0.2 animations:^{
        self.view.layer.opacity = 1;
    }];
}

- (void)closeAlert {
    [UIView animateWithDuration:0.2 animations:^{
        self.view.layer.opacity = 0;
    }];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    if (action == @selector(paste:))//禁止粘贴
//        return NO;
//    if (action == @selector(select:))// 禁止选择
//        return NO;
//    if (action == @selector(selectAll:))// 禁止全选
//        return NO;
//    return [super canPerformAction:action withSender:sender];
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController)
    {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end
