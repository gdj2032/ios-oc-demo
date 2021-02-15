//
//  AppDelegate.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/6/17.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoListModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,strong)UIWindow *window;

@property(nonatomic,strong)NSArray<PhotoListModel *> *models;//照片库数组

@property (nonatomic, assign) NSInteger Rotate;//记录横竖屏

@end

