//
//  NSFile.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/29.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFile : NSObject

/**
 * @brief 根据路径获取音频文件时长
 *
 * @param url 文件路径 NSString
 *
 */
+ (NSTimeInterval)audioDurationFromURL:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
