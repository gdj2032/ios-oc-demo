//
//  FanProgressView.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/22.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#define kDegreesToRadians(x) (M_PI*(x)/180.0)                 //把角度转换成PI的方式

#import "FanProgressView.h"

@interface FanProgressView()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property(nonatomic, assign) CGFloat radius;

@end

@implementation FanProgressView

+(instancetype)shareFanProgressView{
    static FanProgressView *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[FanProgressView alloc] init];
    });
    return singleton;
}

-(instancetype)initFanProgressViewWithFrame:(CGRect)frame WithRadius:(CGFloat)radius withFillColor:(UIColor*)fillColor withStartAngle:(FanProgressStartAngle)startAngle{
    self.frame = frame;
    UIBezierPath *bezPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:kDegreesToRadians(270) endAngle:kDegreesToRadians(270) + kDegreesToRadians(180) clockwise:YES];
    [bezPath addLineToPoint:CGPointMake(radius, radius)];// 扇形关键代码
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = CGRectMake(0, 0, radius, radius);
    _shapeLayer.fillColor = fillColor.CGColor;
    _shapeLayer.path  = bezPath.CGPath;
    [self.layer addSublayer:_shapeLayer];
    _radius = radius;
    return self;
}

-(void)changeProgress:(CGFloat)progress{
     UIBezierPath *bezPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_radius, _radius) radius:_radius startAngle:kDegreesToRadians(270) endAngle:kDegreesToRadians(270) + kDegreesToRadians(progress) clockwise:YES];
    [bezPath addLineToPoint:CGPointMake(_radius, _radius)];// 扇形关键代码
    _shapeLayer.path = bezPath.CGPath;
}

@end
