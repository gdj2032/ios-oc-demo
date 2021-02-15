//
//  PhotoList.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/17.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "PhotoListModel.h"
#import "NSUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoList : UIView

+(instancetype)sharePhotoList;

-(NSArray<PhotoListModel *> *)getPhotoList;

@end

NS_ASSUME_NONNULL_END
