//
//  ProgressVC.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/21.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#define kDegreesToRadians(x) (M_PI*(x)/180.0)                 //把角度转换成PI的方式

#import "ProgressVC.h"
#import "ProgressCircleView.h"
#import "FanProgressView.h"

@interface ProgressVC ()

@property(nonatomic,strong)UISlider *slider;
@property(nonatomic,strong)UIProgressView *lineView;
@property(nonatomic,strong)ProgressCircleView *progresCircleView;
@property(nonatomic,strong)FanProgressView *fanView;
@property(nonatomic, strong) UIView *myView;
@property(nonatomic, strong) UIView *gradientView;


@property(nonatomic,strong)NSTimer *timer1;
@property(nonatomic,strong)NSTimer *timer2;
@property(nonatomic,strong)NSTimer *timer3;

@end

@implementation ProgressVC{
    int num1;
    int fanNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sliderView];
    [self lineProgressView];
    [self circleView];
    [self sectorProgress];
    [self animationDrawRectPath];
    [self gradientCircleProgressView];
    [self gradient];
//    [self drawSecondBezierPath];
    
//    //设置计时器的优先级
//    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//    [runLoop addTimer:_timer1 forMode:NSRunLoopCommonModes];
}

-(void)sliderView{
    _slider = [[UISlider alloc] init];
    _slider.frame = CGRectMake(20, kNavigationHeight + RESERVE_WIDTH * 2, SCREEN_WIDTH - 40, 5);
    [_slider addTarget:self action:@selector(slideAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
}

-(void)slideAction:(UISlider*)slider{
    float value = slider.value;
    NSLog(@"value = %f",value);
}

-(void)lineProgressView{
    _lineView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    _lineView.frame = CGRectMake(20, kNavigationHeight + RESERVE_WIDTH * 4, SCREEN_WIDTH - 40, 1);
//    _lineView.backgroundColor = orange_color;
    //设置轨道颜色
    _lineView.trackTintColor = blue_color;
    //设置进度颜色
    _lineView.progressTintColor = red_color;
    _lineView.progress = 0;
//    UIImage * image1 = [UIImage imageNamed:@"1p.jpg"];
//    UIImage * image2 = [UIImage imageNamed:@"2p.jpg"];
//    //设置轨道图片
//    progressView.trackImage = image1;
//    //设置进度图片
//    progressView.progressImage = image2;
    [self.view addSubview:_lineView];
    _timer1 = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(timer1Sel) userInfo:nil repeats:YES];
}

-(void)timer1Sel{
    if (self.lineView.progress < 1) {
         self.lineView.progress += 0.01;
    }
    else {
        self.lineView.progress = 0;
    }
}

-(void)circleView{
    CGFloat circleSize = 100;
    _progresCircleView = [[ProgressCircleView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - circleSize)/2, kNavigationHeight + RESERVE_WIDTH * 5, circleSize, circleSize)];
    [_progresCircleView setLineWidth:4.f];
    [_progresCircleView setLineColr:blue_color];
    [self.view addSubview:_progresCircleView];
    num1 = 0;
    _timer2 = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(timer2Sel) userInfo:nil repeats:YES];
}

-(void)timer2Sel{
    if (num1>=101){
        num1 = 0;
    }
    [self.progresCircleView changePersent:num1];
    num1++;
}


#pragma mark - 扇形图
- (void)sectorProgress {
    CGFloat sectorSize = 50;//直径
    CGRect frame = CGRectMake(SCREEN_WIDTH/2 - sectorSize, 200+RESERVE_WIDTH*6, sectorSize, sectorSize);
    _fanView = [[FanProgressView shareFanProgressView] initFanProgressViewWithFrame:frame WithRadius:sectorSize withFillColor:blue_color withStartAngle:FanStartAngleTop];
    [self.view addSubview:_fanView];
    fanNum = 0;
    _timer3 = [NSTimer scheduledTimerWithTimeInterval:0.018 target:self selector:@selector(actionSectorTimer) userInfo:nil repeats:YES];
    [_timer3 fire];
}


- (void)actionSectorTimer {
    fanNum += 1;
    if (fanNum >360){
        fanNum = 0;
    }
    [_fanView changeProgress:fanNum];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_timer1 invalidate];
    _timer1 = nil;
    [_timer2 invalidate];
    _timer2 = nil;
    [_timer3 invalidate];
    _timer3 = nil;
    [_fanView changeProgress:0];
}


#pragma mark - 矩形线条闭合动画
- (void)animationDrawRectPath {
    UIBezierPath *bezPath = [UIBezierPath bezierPathWithRect:CGRectMake(20, 300+RESERVE_WIDTH*7, SCREEN_WIDTH - 40, 100)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 10;
    layer.path = bezPath.CGPath;
    layer.strokeColor = [UIColor greenColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:layer];
 
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 4;
    animation.fromValue = @0;
    animation.toValue = @1;
    [layer addAnimation:animation forKey:nil];
}

CGFloat myViewSize = 100;
- (UIView *)myView {
    if (!_myView) {
        _myView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - myViewSize) / 2, 400+RESERVE_WIDTH*8, myViewSize, myViewSize)];
        _myView.backgroundColor = white_color;
    }
    return _myView;
}
#pragma mark - 圆环进度(带渐变的)
- (void)gradientCircleProgressView {
    /*
     步骤
     1、新建UIBezierPath对象bezierPath
     2、新建CAShapeLayer对象caShapeLayer
     3、将bezierPath的CGPath赋值给caShapeLayer的path，即caShapeLayer.path = bezierPath.CGPath
     4、把caShapeLayer添加到某个显示该图形的layer中
     5、设置渐变(可选)
     6、设置CABasicAnimation 动画属性为strokeEnd
     */
    [self.view addSubview:self.myView];
    
    UIBezierPath *backPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(myViewSize/2, myViewSize/2) radius:myViewSize/2-10 startAngle:kDegreesToRadians(270) endAngle:kDegreesToRadians(270) + kDegreesToRadians(360) clockwise:YES];
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(myViewSize/2, myViewSize/2) radius:myViewSize/2-10 startAngle:kDegreesToRadians(270) endAngle:kDegreesToRadians(270) + kDegreesToRadians(360) clockwise:YES];
    
    
    CAShapeLayer *backShapeLayer = [CAShapeLayer layer];
    backShapeLayer.path = backPath.CGPath;
    backShapeLayer.lineWidth = 10;
    backShapeLayer.strokeColor = [UIColor grayColor].CGColor;
    backShapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.myView.layer addSublayer:backShapeLayer];
    
    
    
    CAShapeLayer *proShapeLayer = [CAShapeLayer layer];
    proShapeLayer.lineWidth = 10;
    proShapeLayer.strokeColor = [UIColor redColor].CGColor;
    proShapeLayer.fillColor = [UIColor clearColor].CGColor;
    proShapeLayer.path = progressPath.CGPath;
    [self.myView.layer addSublayer:proShapeLayer];
    
    
    // 设置渐变色
    CAGradientLayer *graLayer = [CAGradientLayer layer];
    graLayer.frame = self.myView.bounds;
    graLayer.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor greenColor].CGColor, (id)[UIColor blueColor].CGColor, (id)[UIColor yellowColor].CGColor,
                        (id)[UIColor purpleColor].CGColor];
    graLayer.locations = @[@0.1, @0.5, @1, @1, @1];//一个可选的NSNumber数组，决定每个渐变颜色的终止位置，这些值必须是递增的，数组的
    graLayer.startPoint = CGPointMake(0, 0);
    graLayer.endPoint   = CGPointMake(1, 1);
    [self.myView.layer addSublayer:graLayer];
    [graLayer setMask:proShapeLayer];
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 3;
    [proShapeLayer addAnimation:animation forKey:nil];
    
}

#pragma mark - 渐变
- (void)gradient {
    _gradientView = [[UIView alloc] initWithFrame:CGRectMake(20, 500+RESERVE_WIDTH*9, SCREEN_WIDTH-40, 100)];
    [self.view addSubview:_gradientView];
    
    CAGradientLayer *graLayer = [CAGradientLayer layer];
    graLayer.frame = _gradientView.bounds;
    graLayer.colors = @[(id)[UIColor redColor].CGColor,
                        (id)[UIColor greenColor].CGColor,
                        (id)[UIColor blueColor].CGColor,
                        (id)[UIColor yellowColor].CGColor,
                        (id)[UIColor purpleColor].CGColor];
    graLayer.startPoint = CGPointMake(0, 0);
    graLayer.endPoint = CGPointMake(0, 1);
    [_gradientView.layer addSublayer:graLayer];
}

#pragma mark - 画二次贝塞尔曲线
/*
 //画二元曲线，一般和moveToPoint配合使用
 - (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint
 参数：
 endPoint:曲线的终点
 controlPoint:画曲线的控制点
 */
- (void)drawSecondBezierPath {
    UIBezierPath *bezPath = [UIBezierPath bezierPath];
    [bezPath moveToPoint:CGPointMake(0, 280)];
    
    //[bezPath addQuadCurveToPoint:CGPointMake(300, 280) controlPoint:CGPointMake(150, 450)];
    [bezPath addCurveToPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2) controlPoint1:CGPointMake(120, 600) controlPoint2:CGPointMake(320, 70)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezPath.CGPath;
    layer.strokeColor = [UIColor greenColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth  = 10;
    
    [self.view.layer addSublayer:layer];
   
    // 为曲线添加轨迹动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue   = @1;
    animation.duration = 4;
    [layer addAnimation:animation forKey:nil];
}

@end
