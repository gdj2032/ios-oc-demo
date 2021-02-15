//
//  CommenView.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/6/17.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "NSUtils.h"
#import <sys/param.h>
#import <sys/mount.h>
#import <Photos/Photos.h>

@implementation NSUtils

#pragma mark -- 通过路径获取文件大小
+ (long long)fileSizeAtPath:(NSString*)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

#pragma mark -- 删除沙盒文件
+ (BOOL)removeDocumentWithFilePath:(NSString*)filePath{
    BOOL isRemove = false;
    NSFileManager* fileManager=[NSFileManager defaultManager];
    if([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        isRemove = [fileManager removeItemAtPath:filePath error:nil];
    }
    return isRemove;
}

#pragma mark -- 获取手机剩余存储空间 单位 B
+ (float) getPhoneFreeSize {
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0)
    {
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    NSLog(@"freespace = %lld MB", freespace / 1024 / 1024);
    return freespace;
}

+ (UIViewController *)viewController:(UIView * _Nonnull)view {
    UIResponder *next = [view nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    
    return nil;
}

#pragma mark -- NSUserDefaults（偏好设置）数据缓存 沙盒中的Libarary/Preferences目录 保存少量数据
#pragma mark -- 保存数据
+ (void)saveDataToNSUserDefaultsWithKey:(NSString*)key withValue:(NSObject*)value {
    //获取NSUserDefaults对象
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //存数据，不需要设置路劲，NSUserDefaults将数据保存在preferences目录下
    [userDefaults setObject:value forKey:key];
    //立刻保存（同步）数据（如果不写这句话，会在将来某个时间点自动将数据保存在preferences目录下）
    [userDefaults synchronize];
}
#pragma mark -- 读取数据
+ (NSObject*)getDataFromNSUserDefaultsWithKey:(NSString*)key{
    //获取NSUserDefaults对象
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //读取数据
    NSObject *obj = [userDefaults objectForKey:key];
    NSLog(@"obj = %@",obj);
    return obj;
}

#pragma mark -- NSFileManager—使用NSData缓存 保存数据
+(BOOL) saveToFileManagerWithPath:(NSString*)path withContent:(NSData*)content{
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL visible = [fm createFileAtPath:path contents:content attributes:nil];
    return visible;
}
#pragma mark -- NSFileManager—使用NSData缓存 读取数据
+(NSData*) getDataFromFileManagerWithPath:(NSString*)path{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSData *data = [fm contentsAtPath:path];
    return data;
}

#pragma mark -- 缩小图片尺寸
+ (UIImage*)compressImage:(UIImage*)sourceImage toTargetWidth:(CGFloat)targetWidth {
    //获取原图片的大小尺寸
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    //根据目标图片的宽度计算目标图片的高度
    CGFloat targetHeight = (targetWidth / width) * height;
    //开启图片上下文
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    //绘制图片
    [sourceImage drawInRect:CGRectMake(0,0, targetWidth, targetHeight)];
    //从上下文中获取绘制好的图片
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图片上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark -- 使用NSSearchPathForDirectoriesInDomains创建文件目录 在Document目录下创建文件夹
+ (void)createDirInDocumentWithFileName:(NSString*)filename {
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dataFilePath = [docsdir stringByAppendingPathComponent:filename]; // 在Document目录下创建 "archiver" 文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
    if (!(isDir && existed)) {
        // 在Document目录下创建一个archiver目录
        NSLog(@"createDirInDocumentWithFileName 创建文件夹: %@",filename);
        [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}
#pragma mark -- 获取本地视频第一帧
+ (UIImage*) getLocationVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}

#pragma mark -- 对图片本身进行旋转
+ (UIImage *)rotateWithImage:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

@end
