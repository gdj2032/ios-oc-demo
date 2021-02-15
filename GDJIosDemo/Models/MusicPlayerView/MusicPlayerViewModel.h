//
//  MusicPlayerViewModel.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/23.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicPlayerViewModel : NSObject

@property(nonatomic,strong)NSString*ids;//歌曲id
@property(nonatomic,strong)NSString*title;//歌名
@property(nonatomic,strong)NSString*songer;//歌手
@property(nonatomic,strong)NSString*details;//歌曲详情
@property(nonatomic,strong)NSString*path;//歌曲路径
@property(nonatomic,strong)NSString*type;//文件类型
@property(nonatomic,strong)NSString*lyrics;//歌词

-(instancetype)initWithIds:(NSString*)ids title:(NSString*)title songer:(NSString*)songer details:(NSString*)details path:(NSString*)path lyrics:(NSString*)lyrics type:(NSString*)type;

@end

NS_ASSUME_NONNULL_END
