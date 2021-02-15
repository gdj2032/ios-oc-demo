//
//  PhotoListCellModel.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/17.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "PhotoListCellModel.h"

@implementation PhotoListCellModel

- (instancetype)appWithImagePath:(NSURL *)imagePath withTitle:(NSString *)title withNum:(NSInteger)num withIsSelected:(BOOL)isSelected{
    self.imagePath = imagePath;
    self.title = title;
    self.num = num;
    self.isSelected = isSelected;
    return self;
}

@end
