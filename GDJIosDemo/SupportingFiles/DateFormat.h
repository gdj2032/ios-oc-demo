//
//  DateFormat.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/6/17.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateFormat : UIView

/**
 * @brief 获取当前时间
 *
 * @param DateFormat 时间格式. 例: @"yyyy-MM-dd hh:mm:ss SS"
 *
 * @return 返回结果 时间格式.
 */
+ (NSString *)getCurrentTime:(NSString *)DateFormat;

/**
 * @brief 获取当前时间戳
 *
 * @return 返回结果 时间戳字符串.
 */
+ (NSString *)getCurrentTimeStampStr;

/**
 * @brief 时间戳转时间,时间戳为13位是精确到毫秒的
 *
 * @param str 时间 例: @"1395399556862"
 *
 * @return 返回结果 时间字符串.
 */
+ (NSString *)getDateStringWithTimeStr:(NSString *)str;

/**
 * @brief 字符串转时间戳
 *
 * @param str 时间 例: @"2017-4-10 17:15:10"
 *
 * @return 返回结果 时间戳.
 */
+ (NSString *)getTimeStrWithString:(NSString *)str;

#pragma mark -- 传入 秒  得到  xx:xx:xx
+(NSString *)getHHMMSSFromSS:(NSString *)totalTime;

#pragma mark -- 传入 秒  得到  xx:xx
+(NSString *)getMMSSFromSS:(NSString *)totalTime;
@end

NS_ASSUME_NONNULL_END
