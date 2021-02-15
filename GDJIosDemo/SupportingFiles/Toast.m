//
//  ToastView.m
//  DynaConnect
//
//  Created by 顾冬杰 on 2020/6/19.
//  Copyright © 2020 Dynabook. All rights reserved.
//
/**
 
 demo:
 
 Toast *toast = [[Toast shareToast] showToast:@"发送剪切板成功!" duration:1.0];
 
 */

#import "Toast.h"

@implementation Toast

+ (instancetype)shareToast{
    static Toast *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[Toast alloc] init];
    });
    return singleton;
}

BOOL use = NO;
- (instancetype)showToast:(NSString *)message duration:(CGFloat)duration {
    duration = duration || 1;
    if (use) {
        [self.showTimer invalidate];
        _toastLabel.text = message;
        CGRect rect = [_toastLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_toastLabel.font} context:nil];
        CGFloat width = rect.size.width + 20;
        CGFloat height = rect.size.height + 20;
        CGFloat x = (SCREEN_WIDTH-width)/2;
        CGFloat y = SCREEN_HEIGHT-height - 80;
        _toastLabel.frame = CGRectMake(x, y, width, height);
        [[[UIApplication sharedApplication] keyWindow] addSubview:_toastLabel];
        _showTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(showTime) userInfo:nil repeats:NO];
        return self;
    };
    if ([message length] == 0) {
        return self;
    }
    use = YES;
    _toastLabel = [[Toast alloc]init];
    _toastLabel.layer.cornerRadius = 8;
    _toastLabel.layer.masksToBounds = YES;
    _toastLabel.userInteractionEnabled=YES;
    _toastLabel.backgroundColor = black_color;
    _toastLabel.numberOfLines = 0;
    _toastLabel.textAlignment = NSTextAlignmentCenter;
    _toastLabel.textColor = white_color;
    _toastLabel.font = [UIFont systemFontOfSize:15];
    _toastLabel.text = message;
    _toastLabel.alpha = 0;
    CGRect rect = [_toastLabel.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_toastLabel.font} context:nil];
    CGFloat width = rect.size.width + 20;
    CGFloat height = rect.size.height + 20;
    CGFloat x = (SCREEN_WIDTH-width)/2;
    CGFloat y = SCREEN_HEIGHT-height - 80;
    _toastLabel.frame = CGRectMake(x, y, width, height);
    [[[UIApplication sharedApplication] keyWindow] addSubview:_toastLabel];
    
    _showTimer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(showTime) userInfo:nil repeats:NO];
    
    [UIView animateWithDuration:0.2f animations:^{
        self.toastLabel.alpha = 0.8;
    }];
    return self;
}

- (void) showTime {
    [UIView animateWithDuration:0.2f animations:^{
        self.toastLabel.alpha = 0;
        [self.showTimer invalidate];
        use = NO;
    }];
}


@end
