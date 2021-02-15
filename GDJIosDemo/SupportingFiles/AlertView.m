//
//  AlertView.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/9.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

+ (AlertView *)shareAlertView {
    static AlertView *view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[AlertView alloc]init];
        
    });
    return view;
}

/**多行文本，左对齐*/
- (void)alertWithTitle:(NSString *)title messageToLeft:(NSString *)message btnTitle:(nonnull NSString *)btnTitle btnTitleColor:(nullable UIColor*)btnTitleColor  completion:(void (^__nullable)(void))completion {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    NSArray *subViews = alertC.view.subviews[0].subviews[0].subviews[0].subviews[0].subviews[0].subviews;
   // UILabel *titleLb = subViews[0];
    UILabel *messageLb = subViews[2];
    messageLb.textAlignment = NSTextAlignmentLeft;
    UIAlertAction *action = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if(completion) {
            completion();
        }
    }];
    if (btnTitleColor) {
        [action setValue:btnTitleColor  forKey:@"_titleTextColor"];
    }
    [alertC addAction:action];
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    [topVC presentViewController:alertC animated:YES completion:nil];
}

- (void)alertWithTitle:(NSString *)title message:(NSString *)message btnTitle:(nonnull NSString *)btnTitle btnTitleColor:(nullable UIColor*)btnTitleColor  completion:(void (^__nullable)(void))completion {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if(completion) {
            completion();
        }
    }];
    if (btnTitleColor) {
        [action setValue:btnTitleColor  forKey:@"_titleTextColor"];
    }
    [alertC addAction:action];
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    [topVC presentViewController:alertC animated:YES completion:nil];
}

- (void)alertWIthTitle:(NSString *)title message:(NSString *)message leftBtnTitle:(NSString *)leftBtnTitle leftBtnTitleColor:(nullable UIColor *)leftBtnTitleColor leftBtnClicked:(void (^__nullable)(void))leftBtnClicked rightBtnTitle:(NSString *)rightBtnTitle rightBtnTitleColor:(nullable UIColor *)rightBtnTitleColor rightBtnClicked:(void (^__nullable)(void))rightBtnClicked {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:leftBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(leftBtnClicked) {
            leftBtnClicked();
        }
    }];
    if (leftBtnTitleColor) {
        [action1 setValue:leftBtnTitleColor forKey:@"_titleTextColor"];
    }
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:rightBtnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(rightBtnClicked) {
            rightBtnClicked();
        }
    }];
    if (rightBtnTitleColor) {
        [action2 setValue:rightBtnTitleColor forKey:@"_titleTextColor"];
    }
    
    [alertC addAction:action1];
    [alertC addAction:action2];
    
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    [topVC presentViewController:alertC animated:YES completion:nil];
}

@end
