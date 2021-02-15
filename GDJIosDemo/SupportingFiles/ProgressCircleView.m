//
//  CircleView.m
//  DynaConnect
//
//  Created by 顾冬杰 on 2020/6/28.
//  Copyright © 2020 Dynabook. All rights reserved.
//

#import "ProgressCircleView.h"

@interface ProgressCircleView()
@property(strong,nonatomic)UIBezierPath *path;
@property(strong,nonatomic)CAShapeLayer *shapeLayer;
@property(strong,nonatomic)CAShapeLayer *bgLayer;
@property(strong,nonatomic)UILabel *persent;

@end

@implementation ProgressCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        
        _bgLayer = [CAShapeLayer layer];
        _bgLayer.frame = self.bounds;
        _bgLayer.fillColor = [UIColor clearColor].CGColor;
        _bgLayer.lineWidth = 2.f;
        _bgLayer.strokeColor = white_color.CGColor;
        _bgLayer.strokeStart = 0.f;
        _bgLayer.strokeEnd = 1.f;
        _bgLayer.path = _path.CGPath;
        [self.layer addSublayer:_bgLayer];
        
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = self.bounds;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.lineWidth = 2.f;
        _shapeLayer.lineCap = kCALineCapRound;
        _shapeLayer.strokeColor = [UIColor redColor].CGColor;
        _shapeLayer.strokeStart = 0.f;
        _shapeLayer.strokeEnd = 0.f;
        
        
        _shapeLayer.path = _path.CGPath;
        [self.layer addSublayer:_shapeLayer];
        
        CGAffineTransform transform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformRotate(transform, -M_PI / 2);
        
        _persent = [[UILabel alloc] init];
//        _persent.center = self.center;
        _persent.textAlignment = NSTextAlignmentCenter;
//        _persent.backgroundColor = [UIColor redColor];
        _persent.text = @"0%";
        _persent.font = [UIFont systemFontOfSize:16.0f];
        [_persent sizeToFit];
        _persent.frame = CGRectMake(0, -_persent.frame.size.height/2, self.frame.size.width, _persent.frame.size.height);
        _persent.layer.anchorPoint = CGPointMake(0, 0.5);
        _persent.transform = CGAffineTransformRotate(transform, M_PI / 2);
        
        [self addSubview:_persent];
        
    }
    return self;
}

@synthesize value = _value;
-(void)setValue:(CGFloat)value{
    _value = value;
    _shapeLayer.strokeEnd = value;
}
-(CGFloat)value{
    return _value;
}

@synthesize lineColr = _lineColr;
-(void)setLineColr:(UIColor *)lineColr{
    _lineColr = lineColr;
    _shapeLayer.strokeColor = lineColr.CGColor;
}
-(UIColor*)lineColr{
    return _lineColr;
}

@synthesize lineWidth = _lineWidth;
-(void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth = lineWidth;
    _shapeLayer.lineWidth = lineWidth;
    _bgLayer.lineWidth = lineWidth;
}
-(CGFloat)lineWidth{
    return _lineWidth;
}

- (void) changePersent:(CGFloat)persent {
    _persent.text = [NSString stringWithFormat:@"%ld%%", (long)persent];
    _shapeLayer.strokeEnd = persent / 100;
}

@end
