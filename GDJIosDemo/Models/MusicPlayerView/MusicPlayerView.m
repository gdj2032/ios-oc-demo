//
//  MusicPlayerView.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/23.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "MusicPlayerView.h"

@interface MusicPlayerView()<AVAudioPlayerDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIImageView *iView;//背景图片模糊

@property(nonatomic,strong)UIView *volumeView;//声音view
@property(nonatomic,strong)UIButton *volumeBtn;//声音开关
@property(nonatomic,strong)UISlider *volumeSilder;//声音大小
@property(nonatomic,strong)UITapGestureRecognizer *volumeSilderGesture;//声音大小手势


@property(nonatomic,strong)UIView *centerView;//中间的动画或歌词视图
@property(nonatomic,strong)UIImageView *centerImageView; //旋转图片

@property(nonatomic,strong)UIView *progressView;//进度view
@property(nonatomic,strong)UISlider *playSlider;//播放进度条
@property(nonatomic,strong)UILabel *zeroTimeLabel;//播放初始时间
@property(nonatomic,strong)UILabel *playTimeLabel;//播放总时间
@property(nonatomic,strong)UITapGestureRecognizer *playSliderGesture;//播放进度条手势

@property(nonatomic,strong)UIView *bottomBtnView;//底部按钮view
@property(nonatomic,strong)UIButton *playPauseBtn;//播放/暂停按钮
@property(nonatomic,strong)UIButton *stopBtn;//停止
@property(nonatomic,strong)UIButton *prevBtn;//上一首
@property(nonatomic,strong)UIButton *nextBtn;//下一首

@property(nonatomic,strong)AVAudioPlayer *audioPlayer;//音频播放器对象

@property(nonatomic,strong)NSTimer *timer;//监听播放进度

@property(nonatomic,strong)MPVolumeView*mpVolume;//系统音量
@property(nonatomic,strong)UISlider*mpVolumeSlider;//系统音量


@end

@implementation MusicPlayerView

CGFloat volumeViewH = 40;
CGFloat progressViewH = 40;
CGFloat bottomBtnViewH = 100;
NSInteger playTag = 1;
NSInteger pauseTag = 2;


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initMusicPlayerView];
    }
    return self;
}

-(void)setMusicData:(MusicPlayerViewModel *)musicData{
    _musicData = musicData;
    [self initAVPlayWithData:musicData];
}

#pragma mark -- 初始化这个view
-(void)initMusicPlayerView{
    [self bgIView];
    [self initVolumeView];
    [self initCenterView];
    [self initProgressView];
    [self initBottomBtnView];
    [self initMPVolume];
    
    //监听系统音量大小变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemVolumeDidChangeNoti:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
}

#pragma mark -- 监听系统音量大小变化
-(void)systemVolumeDidChangeNoti:(NSNotification* )noti{
    //目前手机音量
    float voiceSize = [[noti.userInfo valueForKey:@"AVSystemController_AudioVolumeNotificationParameter"]floatValue];
    _audioPlayer.volume = voiceSize;
    _volumeSilder.value = voiceSize;
}

#pragma mark -- 初始化系统音量 使之不可见
-(void)initMPVolume{
    _mpVolume = [[MPVolumeView alloc] initWithFrame:CGRectMake(-100, -100, 40, 40)];
//    _mpVolume.showsRouteButton = NO;
//    _mpVolume.showsVolumeSlider = NO;
    [self addSubview:_mpVolume];
}

#pragma mark -- 设置系统音量
- (void)setVolumeLevel:(float)value
{
    _mpVolumeSlider = [self volumeSlider];
    // 需要设置 showsVolumeSlider 为 YES
    _mpVolume.showsVolumeSlider = YES;
    [_mpVolumeSlider setValue:value animated:NO];
    [self.volumeSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self.volumeView sizeToFit];
}

#pragma mark -- 系统音量slider
- (UISlider*)volumeSlider
{
    UISlider* volumeSlider =nil;
    for(UIView*view in _mpVolume.subviews) {
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            volumeSlider = (UISlider*)view;
            break;
        }
    }
    return volumeSlider;
}

#pragma mark -- 初始化背景图片并模糊
-(void)bgIView{
    _iView = [[UIImageView alloc] init];
    _iView.frame = self.bounds;
    _iView.image = [UIImage imageNamed: @"bg1"];
    _iView.contentMode = UIViewContentModeScaleToFill;
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    blurView.frame = _iView.bounds;
    [_iView addSubview:blurView];
    [self addSubview:_iView];
}

-(void)back{
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav popViewControllerAnimated:NO];
}

#pragma mark -- 初始化音量
-(void)initVolumeView{
    _volumeView = [[UIView alloc] init];
    _volumeView.frame = CGRectMake(0, kNavigationHeight, SCREEN_WIDTH, volumeViewH);
    
    _volumeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _volumeBtn.frame = CGRectMake(RESERVE_WIDTH, 0, volumeViewH, volumeViewH);
    [_volumeBtn setImage:[UIImage imageNamed:@"unmute"] forState:UIControlStateNormal];
    
    _volumeSilder = [[UISlider alloc] init];
    _volumeSilder.frame = CGRectMake(volumeViewH + RESERVE_WIDTH * 2, (volumeViewH - 4) / 2, SCREEN_WIDTH - volumeViewH - RESERVE_WIDTH * 4, 4);
    [_volumeSilder addTarget:self action:@selector(volumeSliderValueChange:) forControlEvents:UIControlEventValueChanged];
    [_volumeSilder addTarget:self action:@selector(volumeSliderTouchDown:) forControlEvents:UIControlEventTouchDown];
    [_volumeSilder addTarget:self action:@selector(volumeSliderTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    [_volumeSilder setThumbImage:[UIImage imageNamed:@"slider_circle"] forState:UIControlStateNormal];
    _volumeSilder.value = 0.3;
    //slider添加点击事件
    _volumeSilderGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionVolumeTap:)];
    _volumeSilderGesture.delegate = self;
    [_volumeSilder addGestureRecognizer:_volumeSilderGesture];
    
    [_volumeView addSubview:_volumeSilder];
    [_volumeView addSubview:_volumeBtn];
    [self addSubview:_volumeView];
}

-(void)actionVolumeTap:(UITapGestureRecognizer*)tap{
    CGPoint touchPoint = [tap locationInView:_volumeSilder];
    CGFloat value = (_volumeSilder.maximumValue - _volumeSilder.minimumValue) * (touchPoint.x / _volumeSilder.frame.size.width );
    [_volumeSilder setValue:value animated:YES];
    [self setVolumeLevel:value];
    _audioPlayer.volume = value;
}

-(void)volumeSliderValueChange:(UISlider*)slider{
    float value = slider.value;
    [self setVolumeLevel:value];
    _audioPlayer.volume = value;
}

-(void)volumeSliderTouchDown:(UISlider *)sender {
    _volumeSilderGesture.enabled = NO;
}

-(void)volumeSliderTouchUp:(UISlider *)sender {
    _volumeSilderGesture.enabled = YES;
}

#pragma mark -- 初始化中间的大图
-(void)initCenterView{
    _centerView = [[UIView alloc] init];
    CGFloat centerViewH = SCREEN_HEIGHT - kNavigationHeight - volumeViewH - progressViewH - bottomBtnViewH - kBottomSafeAreaHeight;
    _centerView.frame = CGRectMake(0, kNavigationHeight + volumeViewH, SCREEN_WIDTH, centerViewH);
    
    CGFloat cImgSize = SCREEN_WIDTH * 0.8;
    CGFloat cImgX = (SCREEN_WIDTH - cImgSize)/2;
    CGFloat cImgY = (centerViewH - cImgSize)/2;
    _centerImageView = [[UIImageView alloc] init];
    _centerImageView.image = [UIImage imageNamed:@"music_circle"];
    _centerImageView.frame = CGRectMake(cImgX, cImgY, cImgSize, cImgSize);
    
    [_centerView addSubview:_centerImageView];
    [self addSubview:_centerView];
}

#pragma mark -- 初始化时间进度条和时间显示
-(void)initProgressView{
    _progressView = [[UIView alloc] init];
    _progressView.frame = CGRectMake(0, SCREEN_HEIGHT - bottomBtnViewH - progressViewH - kBottomSafeAreaHeight, SCREEN_WIDTH, progressViewH);
    
    CGFloat timeLabelW = 60;
    
    _zeroTimeLabel = [[UILabel alloc] init];
    _zeroTimeLabel.text = @"00:00";
    _zeroTimeLabel.textColor = white_color;
    _zeroTimeLabel.font = [UIFont systemFontOfSize:12];
    _zeroTimeLabel.textAlignment = NSTextAlignmentCenter;
    _zeroTimeLabel.frame = CGRectMake(RESERVE_WIDTH, 0, timeLabelW, progressViewH);
    
    _playTimeLabel = [[UILabel alloc] init];
    _playTimeLabel.text = @"00:00";
    _playTimeLabel.textColor = white_color;
    _playTimeLabel.font = [UIFont systemFontOfSize:12];
    _playTimeLabel.textAlignment = NSTextAlignmentCenter;
    _playTimeLabel.frame = CGRectMake(SCREEN_WIDTH - RESERVE_WIDTH - timeLabelW, 0, timeLabelW, progressViewH);
    
    _playSlider = [[UISlider alloc] init];
    _playSlider.frame = CGRectMake(RESERVE_WIDTH + timeLabelW, progressViewH / 2 - 2, SCREEN_WIDTH - (RESERVE_WIDTH + timeLabelW) * 2, 4);
    _playSlider.value = 0;
    [_playSlider addTarget:self action:@selector(playSliderValueChange:) forControlEvents:UIControlEventValueChanged];
    [_playSlider addTarget:self action:@selector(playSliderTouchDown:) forControlEvents:UIControlEventTouchDown];
    [_playSlider addTarget:self action:@selector(playSliderTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    [_playSlider setThumbImage:[UIImage imageNamed:@"slider_circle"] forState:UIControlStateNormal];
    //slider添加点击事件
    _playSliderGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionPlayTap:)];
    _playSliderGesture.delegate = self;
    [_playSlider addGestureRecognizer:_playSliderGesture];
    
    [_progressView addSubview:_zeroTimeLabel];
    [_progressView addSubview:_playTimeLabel];
    [_progressView addSubview:_playSlider];
    [self addSubview:_progressView];
}

#pragma mark -- slider点击事件
-(void)actionPlayTap:(UITapGestureRecognizer*)tap{
    CGPoint touchPoint = [tap locationInView:_playSlider];
    CGFloat value = (_playSlider.maximumValue - _playSlider.minimumValue) * (touchPoint.x / _playSlider.frame.size.width );
    [_playSlider setValue:value animated:YES];
    NSTimeInterval ctime = _audioPlayer.duration * value;
    [_audioPlayer setCurrentTime: ctime];
    _zeroTimeLabel.text = [DateFormat getMMSSFromSS:[NSString stringWithFormat:@"%f",ctime]];
}

-(void)playSliderValueChange:(UISlider*)slider{
    float value = slider.value;
    NSTimeInterval ctime = _audioPlayer.duration * value;
    [_audioPlayer setCurrentTime: ctime];
    _zeroTimeLabel.text = [DateFormat getMMSSFromSS:[NSString stringWithFormat:@"%f",ctime]];
}

-(void)playSliderTouchDown:(UISlider *)sender {
    _playSliderGesture.enabled = NO;
    [_audioPlayer pause];
}

-(void)playSliderTouchUp:(UISlider *)sender {
    _playSliderGesture.enabled = YES;
    [_audioPlayer play];
}

#pragma mark -- 初始化底部按钮
-(void)initBottomBtnView{
    _bottomBtnView = [[UIView alloc] init];
    _bottomBtnView.frame = CGRectMake(0, SCREEN_HEIGHT - bottomBtnViewH - kBottomSafeAreaHeight, SCREEN_WIDTH, bottomBtnViewH);
    
    CGFloat btnSize1 = bottomBtnViewH * 0.6;
    CGFloat btnSize2 = bottomBtnViewH * 0.3;
    
    CGFloat btnSize1Y = (bottomBtnViewH - btnSize1)/2;
    CGFloat btnSize2Y = (bottomBtnViewH - btnSize2)/2;
    
    _playPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playPauseBtn.frame = CGRectMake((SCREEN_WIDTH - btnSize1) / 2, btnSize1Y, btnSize1, btnSize1);
    _playPauseBtn.layer.borderWidth = 1;
    _playPauseBtn.layer.borderColor = white_color.CGColor;
    _playPauseBtn.layer.cornerRadius = btnSize1/2;
    [_playPauseBtn setImage:[UIImage imageNamed:@"play_white"] forState:UIControlStateNormal];
    _playPauseBtn.tag = pauseTag;
    [_playPauseBtn addTarget:self action:@selector(playPauseAct:) forControlEvents:UIControlEventTouchUpInside];
    
    _prevBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _prevBtn.frame = CGRectMake(RESERVE_WIDTH*3, btnSize2Y, btnSize2, btnSize2);
    [_prevBtn setImage:[UIImage imageNamed:@"prev_white"] forState:UIControlStateNormal];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(SCREEN_WIDTH - RESERVE_WIDTH*3 - btnSize2, btnSize2Y, btnSize2, btnSize2);
    [_nextBtn setImage:[UIImage imageNamed:@"next_white"] forState:UIControlStateNormal];
    
    [_bottomBtnView addSubview:_prevBtn];
    [_bottomBtnView addSubview:_nextBtn];
    [_bottomBtnView addSubview:_playPauseBtn];
    [self addSubview:_bottomBtnView];
}

#pragma mark -- 点击播放/暂停
-(void)playPauseAct:(UIButton*)btn{
    NSInteger tag = (int)btn.tag;
    if (tag == playTag){
        [self clearTimer];
    } else if (tag == pauseTag){
        [self openTimer];
    }
}

#pragma mark -- 初始化播放器
-(void)initAVPlayWithData:(MusicPlayerViewModel*)data{
    NSURL *url = [NSURL fileURLWithPath:data.path];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_audioPlayer prepareToPlay];
    //循环次数 -1无线循环 正数几次循环几次
    _audioPlayer.numberOfLoops = -1;
    _audioPlayer.volume = 1;
    _playTimeLabel.text = [DateFormat getMMSSFromSS:[NSString stringWithFormat:@"%f",_audioPlayer.duration]];
    [self openTimer];
}
#pragma mark -- 开启定时器
-(void)openTimer{
    _playPauseBtn.tag = playTag;
    [_playPauseBtn setImage:[UIImage imageNamed:@"pause_white"] forState:UIControlStateNormal];
    [_audioPlayer play];
    [self startAnimating];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAct) userInfo:nil repeats:YES];
}
#pragma mark -- 清除定时器
-(void)clearTimer{
    _playPauseBtn.tag = pauseTag;
    [_playPauseBtn setImage:[UIImage imageNamed:@"play_white"] forState:UIControlStateNormal];
    [_audioPlayer pause];
    [self stopAnimating];
    [_timer invalidate];
    _timer = nil;
}
#pragma mark -- 定时器执行内容
-(void)timerAct{
    _playSlider.value = _audioPlayer.currentTime / _audioPlayer.duration;
    _zeroTimeLabel.text = [DateFormat getMMSSFromSS:[NSString stringWithFormat:@"%f",_audioPlayer.currentTime]];
}

#pragma mark -- 停止播放和清除定时器
-(void)stop{
    [self clearTimer];
    [_audioPlayer stop];
}

#pragma mark -- 销毁通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -- UIIimageView的自旋转动画,可暂停
-(void)startAnimating
{
    //先判断是否已设置动画，如果已设置则执行动画
    if([_centerImageView.layer animationForKey:@"rotatianAnimKey"]){
        //如果动画正在执行则返回，避免重复执行动画
        if (_centerImageView.layer.speed == 1) {
            //speed == 1表示动画正在执行
            return;
        }
        //让动画执行
        _centerImageView.layer.speed = 1;
        
        //取消上次设置的时间
        _centerImageView.layer.beginTime = 0;
        //获取上次动画停留的时刻
        CFTimeInterval pauseTime = _centerImageView.layer.timeOffset;
            
        //取消上次记录的停留时刻
        _centerImageView.layer.timeOffset = 0;
        
        //计算暂停的时间，设置相对于父坐标系的开始时间
        _centerImageView.layer.beginTime = [_centerImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
        
    }else{//没有设置动画
        
        //添加动画
        [self addAnimation];
    }
}
-(void)addAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//rotation.z
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.toValue = [NSNumber numberWithFloat: M_PI *2];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 40;//执行一周40秒
    animation.autoreverses = NO;
    animation.cumulative = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = FLT_MAX; //如果这里想设置成一直自旋转，可以设置为FLT_MAX，
    [_centerImageView.layer addAnimation:animation forKey:@"rotatianAnimKey"];
    //添加动画之后，再让动画执行，否则可能出现动画不执行的情况
    [self startAnimating];
}
-(void)stopAnimating
{
    //如果动画已经暂停，则返回，避免重复，时间会记录错误，造成动画继续后不能连续。
    if (_centerImageView.layer.speed == 0) {
        return;
    }
    //将当前动画执行到的时间保存到layer的timeOffet中
   //一定要先获取时间再暂停动画
    CFTimeInterval pausedTime = [_centerImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    //将动画暂停
    _centerImageView.layer.speed = 0;
    //记录动画暂停时间
    _centerImageView.layer.timeOffset = pausedTime;
}

@end
