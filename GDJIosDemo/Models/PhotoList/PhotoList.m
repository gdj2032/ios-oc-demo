//
//  PhotoList.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/17.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "PhotoList.h"

@implementation PhotoList

static NSMutableArray<PhotoListModel *> *titleUrls;

static NSString *titleUrlsKey = @"titleUrls";

+(instancetype)sharePhotoList{
    static PhotoList *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[PhotoList alloc] init];
    });
    return singleton;
}

-(NSArray<PhotoListModel *> *)getPhotoList {
    titleUrls = [NSMutableArray<PhotoListModel *> array];
//    NSString *path = [self getPathEWithFileName:titleUrlsKey];
//    NSData *data0 = [NSUtils getDataFromFileManagerWithPath:path];
//    NSArray *titleUrls1 = [[NSKeyedUnarchiver unarchivedObjectOfClass:[NSArray class] fromData:data0 error:nil] componentsSeparatedByString:@";"];
//    NSLog(@"titleUrls1:%@", titleUrls1);
//    if (titleUrls1) {
//        return titleUrls1;
//    }
    PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
    if (photoAuthorStatus==PHAuthorizationStatusAuthorized) {
        // 遍历所有的自定义相册
        PHFetchResult<PHAssetCollection *> *collectionResult0 = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        for (PHAssetCollection *collection in collectionResult0) {
            [self imagesWithCollection:collection];
        }
    }
    // 获得相机胶卷的图片
    PHFetchResult<PHAssetCollection *> *collectionResult1 = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult1) {
        //        if ([collection.localizedTitle isEqualToString:@"Favorites"] || [collection.localizedTitle isEqualToString:@"个人收藏"]) continue;
        //        if ([collection.localizedTitle isEqualToString:@"Screenshots"] || [collection.localizedTitle isEqualToString:@"屏幕快照"] || [collection.localizedTitle isEqualToString:@"截屏"]) continue;
        //        if ([collection.localizedTitle isEqualToString:@"Videos"] || [collection.localizedTitle isEqualToString:@"视频"]) continue;
        //        if ([collection.localizedTitle isEqualToString:@"Panoramas"] || [collection.localizedTitle isEqualToString:@"全景照片"]) continue;
        if ([collection.localizedTitle isEqualToString:@"Recently Deleted"] || [collection.localizedTitle isEqualToString:@"最近删除"]) continue;
//        if ([collection.localizedTitle isEqualToString:@"Recently Added"] || [collection.localizedTitle isEqualToString:@"最近添加"]) continue;
        [self imagesWithCollection:collection];
    }
//    NSData *data1 = [[titleUrls componentsJoinedByString:@";"] dataUsingEncoding:NSUTF8StringEncoding];
//    BOOL visible = [NSUtils saveToFileManagerWithPath:path withContent:data1];
//    NSLog(@"visible:%d", visible);
    return titleUrls;
}

-(void)imagesWithCollection:(PHAssetCollection*)collection{
    // 采取同步获取图片（只获得一次图片）
    PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
    imageOptions.synchronous = YES;
    imageOptions.deliveryMode=PHImageRequestOptionsDeliveryModeOpportunistic;
    NSMutableArray *list = [NSMutableArray array];
    PHFetchResult<PHAsset *> *assetResult = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
    NSLog(@"相册名字：%@",collection.localizedTitle);
    for (PHAsset *asset in assetResult) {
        // 过滤非图片
        if (asset.mediaType != PHAssetMediaTypeImage)
        {
            NSLog(@"continue;");
            continue;
        }
        /*****************代码适用于Xcode10和Xcode11（获取手机系统相册图片的路径）ios 13****************************/
        NSArray<PHAssetResource *> *resource=[PHAssetResource assetResourcesForAsset:asset];
        //        NSLog(@"resource=%@",resource);
        PHAssetResource *obj=resource[0];
        if (resource.count > 1){
            //动态图的第一帧 mov文件
            obj=resource[1];
        }
        NSURL *url=[obj valueForKey:@"_privateFileURL"];
        if (!url) continue;
        NSData * data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        if (!img)continue;
        [list addObject:url];
        //        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:imageOptions resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        ////            NSLog(@"info = %@", info);
        //            if ([info objectForKey:@"PHImageFileURLKey"]) {
        //                NSLog(@"PHImageFileURLKey");
        //                NSURL *filepath =[info objectForKey:@"PHImageFileURLKey"];
        //                NSString *path=[filepath path];
        //                NSLog(@"图片路径：%@",path );
        //            }
        //        }];
    }
    if (list.count == 0) return;
    PhotoListModel *listmodel= [[PhotoListModel alloc] initWithTitle:collection.localizedTitle withList:list];
    [titleUrls addObject:listmodel];
}

-(NSString*)getPathEWithFileName:(NSString*)fileName{
    NSArray *patchs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [NSString stringWithFormat:@"%@/%@",[patchs objectAtIndex:0],fileName];
    return path;
}

@end
