//
//  ImageGesture.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/6.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "ImageGesture.h"

@implementation ImageGesture

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
        [self addGestureRecognizer:gesture];
        
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void) imageClicked:(UIGestureRecognizer *) gesture
{
    if ([self.delegate respondsToSelector:@selector(imageClick:)])
    {
        [self.delegate imageClick:self];
    }
}

@end
