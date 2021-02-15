//
//  Single.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/20.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "Single.h"

@implementation Single

static Single *_instanceObj=nil;

+(instancetype)getInstance{
    //只会执行一次
    //该方法是线程安全的
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (!_instanceObj) {
            _instanceObj=[[self alloc]init];
        }
    });
    return _instanceObj;
}

//当第一次使用单例时，回调用init方法
-(id)init{
    self=[super init];
    if (self) {
        
    }
    return self;
}

//重写方法，防止他人直接通过分配内存初始化的方式生成新的对象
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (!_instanceObj) {
            _instanceObj=[super allocWithZone:zone];
        }
    });
    return _instanceObj;
}

-(id)copy{
    return self;
}

-(id)mutableCopy{
    return self;
}

@end
