//
//  PhotoListCellModel.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/17.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoListCellModel : NSObject

@property(nonatomic,strong)NSURL *imagePath;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)NSInteger num;
@property(nonatomic,assign)BOOL isSelected;

- (instancetype) appWithImagePath:(NSURL*)imagePath withTitle:(NSString*)title withNum:(NSInteger)num withIsSelected:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
