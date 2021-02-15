//
//  CommonView.h
//  DynaConnect
//
//  Created by 顾冬杰 on 2020/6/17.
//  Copyright © 2020 Dynabook. All rights reserved.
//  公共方法

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUtils : UIView

/**
 * @brief 通过路径获取文件大小
 *
 * @param filePath 文件路径
 *
 */
+ (long long)fileSizeAtPath:(NSString*)filePath;

/**
 * @brief 删除沙盒文件
 *
 * @param filePath 文件路径
 *
 */
+ (BOOL)removeDocumentWithFilePath:(NSString*)filePath;

/**
 * @brief 获取手机剩余存储空间
 *
 * @return 存储空间大小 单位: B
 */
+ (float) getPhoneFreeSize;

+ (UIViewController *)viewController:(UIView * _Nonnull)view;

/**
* NSUserDefaults（偏好设置）数据缓存 沙盒中的Libarary/Preferences目录 保存少量数据
*
* @brief 保存数据
* @param key    关键字
* @param value  值
*
*/
+ (void)saveDataToNSUserDefaultsWithKey:(NSString*)key withValue:(NSObject*)value;
/**
* NSUserDefaults（偏好设置）数据缓存 沙盒中的Libarary/Preferences目录 保存少量数据
*
* @brief 读取数据
*
* @param key    关键字
*
* @return NSObject obj
*/
+ (NSObject*)getDataFromNSUserDefaultsWithKey:(NSString*)key;

/**
* NSFileManager—使用NSData缓存
*
* @brief 保存数据
*
* @param path    路径名称
* @param content    内容
*
* @return BOOL
*/
+(BOOL) saveToFileManagerWithPath:(NSString*)path withContent:(NSData*)content;
/**
* NSFileManager—使用NSData缓存
*
* @brief 读取数据
*
* @param path    路径名称
*
* @return NSData
*/
+(NSData*) getDataFromFileManagerWithPath:(NSString*)path;

/**
*
* @brief 压缩图像
*
* @param sourceImage 图片 UIImage
* @param targetWidth 压缩至多少大小
*
* @return UIImage
*/
+ (UIImage*)compressImage:(UIImage*)sourceImage toTargetWidth:(CGFloat)targetWidth;

/*
*  在Document目录下创建文件夹
*
*  @param filename    文件名
*
*/
+ (void)createDirInDocumentWithFileName:(NSString*)filename;

/**
*
* @brief 获取本地视频第一帧
*
* @param path 视频文件路径url
*
* @return UIImage
*/
+ (UIImage*) getLocationVideoPreViewImage:(NSURL *)path;

/**
*
* @brief 对图片本身进行旋转
*
* @param image 图片 UIImage
* @param orientation 旋转角度 UIImageOrientation
*
* @return UIImage
*/
+ (UIImage *)rotateWithImage:(UIImage *)image rotation:(UIImageOrientation)orientation;


@end

NS_ASSUME_NONNULL_END
