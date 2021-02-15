//
//  Loading.h
//  DynaConnect
//
//  Created by 顾冬杰 on 2020/7/7.
//  Copyright © 2020 Dynabook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Loading : UIView

@property(nonatomic,strong)UIActivityIndicatorView *loading;

+ (instancetype)shareLoading;

- (instancetype) showLoadingWithFrame:(CGRect)frame;
- (void) startLoadingAction;
- (void) stopLoadingAction;

@end

NS_ASSUME_NONNULL_END
