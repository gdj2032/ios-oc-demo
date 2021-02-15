//
//  Loading.m
//  DynaConnect
//
//  Created by 顾冬杰 on 2020/7/7.
//  Copyright © 2020 Dynabook. All rights reserved.
//

#import "Loading.h"

@implementation Loading

+ (instancetype)shareLoading {
    static Loading *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[Loading alloc] init];
    });
    return singleton;
}

- (instancetype)showLoadingWithFrame:(CGRect)frame {
    _loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _loading.hidesWhenStopped = YES;
    _loading.frame = frame;
    _loading.backgroundColor = gray_color1;
    _loading.color = [UIColor blackColor];
    _loading.layer.opacity = 0.6;
    [self startLoadingAction];
    [[[UIApplication sharedApplication] keyWindow] addSubview:_loading];
    return self;
}

- (void)startLoadingAction {
    [_loading startAnimating];
}

- (void)stopLoadingAction {
    [_loading stopAnimating];
}

@end
