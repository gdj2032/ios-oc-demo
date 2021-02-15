//
//  PhotoListCell.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/17.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "PhotoListCell.h"

@interface PhotoListCell()

@end

@implementation PhotoListCell

-(instancetype)initCellWithModel:(PhotoListCellModel *)model withFrame:(CGRect)frame{
    self=[super init];
    if (self) {
        self.frame = frame;
        self.backgroundColor = black_color;
        self.tag = frame.origin.y / frame.size.height;
        
        UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 60, 60)];
        NSData *imageData = [NSData dataWithContentsOfURL:model.imagePath];
        UIImage *leftImg = [UIImage imageWithData:imageData];
//        if (leftImg.size.width > 60 * 2) {
//            leftImg = [NSUtils compressImage:leftImg toTargetWidth:120];
//        }
        leftImage.image = leftImg;
        leftImage.contentMode = UIViewContentModeScaleToFill;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = [NSString stringWithFormat:@"%@ (%ld)",model.title,(long)model.num];
        titleLabel.font = [UIFont systemFontOfSize:20];
        [titleLabel sizeToFit];
        titleLabel.textColor = white_color;
        titleLabel.frame = CGRectMake(80, 10, titleLabel.frame.size.width, 40);

        UIImageView *selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 54, 10, 40, 40)];
        selectImageView.image = [UIImage imageNamed:@"yes"];
        selectImageView.tag = (frame.origin.y / frame.size.height) + 1;
        
        if (model.isSelected) {
            selectImageView.hidden = NO;
        } else {
            selectImageView.hidden = YES;
        }
        
        UIView *line = [[UIView alloc] initWithFrame: CGRectMake(0, 59, SCREEN_WIDTH, 1)];
        line.backgroundColor = line_color;
        
        [self addSubview:leftImage];
        [self addSubview:titleLabel];
        [self addSubview:line];
        [self addSubview:selectImageView];
        
        [self addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)cellClick:(UIButton*)btn{
    int tag = (int)btn.tag;
    NSLog(@"cellClick tag = %d",tag);
    [self.photoListCellDelegate cellClick:btn];
}

@end
