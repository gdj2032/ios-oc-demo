//
//  CarouselCell.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/6.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ImageGestureDelegate <NSObject>

-(void)imageClick:(id)sender;

@end

@interface ImageGesture: UIImageView

@property(nonatomic,assign)id<ImageGestureDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
