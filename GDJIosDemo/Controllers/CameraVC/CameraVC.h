//
//  CameraVC.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/13.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "NSUtils.h"
#import "CheckImageVC.h"
#import "PhotoList.h"
#import "PhotoListModel.h"
#import "PhotoListView.h"
#import "AppDelegate.h"
#import "NSUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface CameraVC : UIViewController<PhotoListViewDelegate>

@property(nonatomic, assign)NSArray<PhotoListModel *> *models;

@end

NS_ASSUME_NONNULL_END
