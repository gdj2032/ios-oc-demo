//
//  CarouselVC.m
//  GDJIosDemo 轮播图
//
//  Created by 顾冬杰 on 2020/7/3.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "CarouselVC.h"
#import "CarouselView.h"

@interface CarouselVC ()<CarouselViewDelegate>

@end

@implementation CarouselVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = white_color;
    
    CarouselView *cview = [[CarouselView alloc]initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 200)];
    cview.images = @[@"img1",@"img2",@"img3",@"img4"];
    cview.location = PageControlRight;
    cview.selectedColor = [UIColor redColor];
    cview.disSelectedColor = [UIColor grayColor];
    cview.changeTime = 3.0f;
    cview.cvDelegate = self;
    [self.view addSubview:cview];
    
    //back
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 100, 50)];
//    [button setTitle:@"返回" forState:UIControlStateNormal];
//    [button setTitleColor:black_color forState:UIControlStateNormal];
//    [self.view addSubview:button];
//    [button addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
}

-(void)imageClick:(UIImageView *)imageView{
    //10开始
    NSLog(@"imageView tag is %ld",(long)imageView.tag);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
