//
//  TableCellModel.h
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/6/18.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableCellModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *page;

- (instancetype) initWithDict: (NSDictionary *) dict;
+ (instancetype) appWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
