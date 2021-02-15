//
//  PhotoListModel.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/17.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoListModel : NSObject

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSArray<NSURL*> *list;

-(id) initWithTitle:(NSString*)title withList:(NSArray*)list;

-(NSString*)title;
-(NSArray*)list;

@end

NS_ASSUME_NONNULL_END
