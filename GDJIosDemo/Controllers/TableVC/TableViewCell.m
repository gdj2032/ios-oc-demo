//
//  TableViewCell.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/6/18.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

#import "TableViewCell.h"
#import "TableCellModel.h"

@implementation TableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    //NSLog(@"ViewCell");
    //cell 唯一标识
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    //先从缓存池中区
    TableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];;
    //缓存池中没有再创建，并添加标识，cell移出缓存池以复用
    if (cell==nil) {
        cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}


//重写init方法构建cell内容
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor whiteColor];
        
        //初始化ui cell
        _skipBtn = [[UILabel alloc] initWithFrame:CGRectMake(14, 8, SCREEN_WIDTH - 28, 24)];
//        _skipBtn.backgroundColor = blue_color;
        [_skipBtn setTextColor:blue_color];
        _skipBtn.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_skipBtn];
    }
    return self;
}

// 重写set方法，传递model
-(void)setModel:(TableCellModel*)model{
    _model=model;
    _skipBtn.text = model.title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setSelected:highlighted animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:NO];
    // Configure the view for the selected state
}


@end
