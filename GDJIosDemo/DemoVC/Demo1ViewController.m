//
//  Demo1ViewController.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/9.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "Demo1ViewController.h"

@interface Demo1ViewController ()

@end

@implementation Demo1ViewController

//移除KVO、观察者
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"isAnimation" context:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor systemPinkColor];
    
    // 设置KVO、观察者
    [self addObserver:self forKeyPath:@"isAnimation" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 对KVO、观察者发送信息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isAnimation" object:@0];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    // 对KVO、观察者发送信息
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isAnimation" object:@1];
}

@end
