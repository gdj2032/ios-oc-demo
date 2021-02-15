//
//  PhotoListModel.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/17.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "PhotoListModel.h"

@implementation PhotoListModel

-(id) initWithTitle:(NSString*)title withList:(NSArray*)list{
    _list = list;
    _title = title;
    return self;
}

-(NSString*)title{
    return _title;
}

-(NSArray*)list{
    return _list;
}
@end
