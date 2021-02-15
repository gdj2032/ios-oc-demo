//
//  MusicPlayerViewModel.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/23.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "MusicPlayerViewModel.h"

@implementation MusicPlayerViewModel

-(instancetype)initWithIds:(NSString *)ids title:(NSString *)title songer:(NSString *)songer details:(NSString *)details path:(NSString *)path lyrics:(NSString *)lyrics  type:(NSString*)type{
    _ids = ids;
    _title = title;
    _songer = songer;
    _details = details;
    _path = path;
    _lyrics = lyrics;
    _type = type;
    return self;
}

@end
