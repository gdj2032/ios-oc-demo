//
//  RichTextVC.m
//  GDJIosDemo
//
//  Created by 顾冬杰 on 2020/7/21.
//  Copyright © 2020 顾冬杰. All rights reserved.
//

/**
 1.配置NSMutableParagraphStyle
 NSMutableParagraphStyle *MParaStyle = [[NSMutableParagraphStyle alloc] init];
 MParaStyle.alignment =  NSTextAlignmentNatural;  // 文字站位
 MParaStyle.maximumLineHeight = 20;  // 最大高度
 MParaStyle.lineHeightMultiple = 10 ;  //  平均高度
 MParaStyle.minimumLineHeight = 0;  // 最小高度
 MParaStyle.firstLineHeadIndent = 20; // 首行缩进
 MParaStyle.lineSpacing = 0; // 行间距
 MParaStyle.headIndent = 20;  // 左侧整体缩进
 MParaStyle.tailIndent = SCREEN_WIDTH - 20;  //  右侧整体缩进
 MParaStyle.lineBreakMode = NSLineBreakByCharWrapping; // 内容省略方式
 MParaStyle.baseWritingDirection = NSWritingDirectionLeftToRight;  // 书写方式
 MParaStyle.paragraphSpacingBefore = 0;  // 段落之间间距
 MParaStyle.paragraphSpacing = 0; // 段落间距离
 // MParaStyle.hyphenationFactor = 1; // 连字属性
 2.配置attibutes
  NSMutableDictionary *attributes = [NSMutableDictionary new];
  // 添加paragraphStyle
 [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
 // 添加font
 [attributes setObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName];
 3.关联text
 NSAttributedString *text = [[NSAttributedString alloc] initWithString:@"test" attributes:attributes];

 UITextView *textView = [[UITextView alloc] init];
 [textView setAttributedText:text];


 NSFontAttributeName               设置字体大小和字体的类型 默认12 Helvetica(Neue)
 NSForegroundColorAttributeName    设置字体颜色，默认黑色 UIColor对象
 NSBackgroundColorAttributeName    设置字体所在区域的背景颜色，默认为nil，透明色
 NSLigatureAttributeName           设置连体属性，NSNumber对象 默认0 没有连体
 NSKernAttributeName               设置字符间距， NSNumber浮点型属性 正数间距加大，负数间距缩小
 NSStrikethroughStyleAttributeName 设置删除线，NSNumber对象
 NSStrikethroughColorAttributeName 设置删除线颜色，UIColor对象，默认是黑色
 NSUnderlineStyleAttributeName     设置下划线，NSNumber对象 NSUnderlineStyle枚举值
 NSUnderlineColorAttributeName     设置下划线颜色，UIColor对象，默认是黑色
 NSStrokeWidthAttributeName        设置笔画宽度，NSNumber对象 正数中空 负数填充
 NSStrokeColorAttributeName        设置填充部分颜色，不是指字体颜色，UIColor对象
 NSShadowAttributeName             设置阴影属性，取值为NSShadow对象
 NSTextEffectAttributeName         设置文本特殊效果 NSString对象 只有图版印刷效果可用
 NSBaselineOffsetAttributeName     设置基线偏移量，NSNumber float对象 正数向上偏移，负数向下偏移
 NSObliquenessAttributeName        设置字体倾斜度，NSNumber float对象，正数右倾斜，负数左倾斜
 NSExpansionAttributeName          设置文本横向拉伸属性，NSNumber float对象，正数横向拉伸文本，负数压缩
 NSWritingDirectionAttributeName   设置文字书写方向，从左向右或者右向左
 NSVerticalGlyphFormAttributeName  设置文本排版方向，NSNumber对象。0 横向排版，1 竖向排版
 NSLinkAttributeName               设置文本超链接，点击可以打开指定URL地址
 NSAttachmentAttributeName         设置文本附件，取值为NSTextAttachment对象，一般为图文混排
 NSParagraphStyleAttributeName     设置文本段落排版，为NSParagraphStyle对象

 */

#import "RichTextVC.h"

@interface RichTextVC ()

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,strong)UILabel *label3;
@property(nonatomic,strong)UILabel *label4;
@property(nonatomic,strong)UILabel *label5;
@property(nonatomic,strong)UILabel *label6;
@property(nonatomic,strong)UILabel *label7;
@property(nonatomic,strong)UILabel *label8;
@property(nonatomic,strong)UILabel *label9;

@end

@implementation RichTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = white_color;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT * 2);
    [self.view addSubview:_scrollView];
    
    //1.NSFontAttributeName
    //说明：该属性用于改变一段文本的字体。如果不指定该属性，则默认为12-point Helvetica(Neue)
    //2.NSForegroundColorAttributeName
    //说明：该属性用于指定一段文本的字体颜色。如果不指定该属性，则默认为黑色
    //3.NSBackgroundColorAttributeName
    //说明:设置文字背景颜色
    NSString *str1 = @"举杯邀明月,对影成三人";
    NSMutableAttributedString *mutAttr1 = [[NSMutableAttributedString alloc] init];
    NSAttributedString *attr11 = [[NSAttributedString alloc] initWithString:[str1 substringWithRange:NSMakeRange(0, 2)] attributes:@{
        NSFontAttributeName:[UIFont fontWithName:@"futura" size:12],
        NSForegroundColorAttributeName:red_color,
        NSBackgroundColorAttributeName:black_color}];
    NSAttributedString *attr12 = [[NSAttributedString alloc] initWithString:[str1 substringWithRange:NSMakeRange(2, 1)] attributes:@{
        NSFontAttributeName:[UIFont fontWithName:@"futura" size:18],
        NSForegroundColorAttributeName:yellow_color,
        NSBackgroundColorAttributeName:purple_color
    }];
    NSAttributedString *attr13 = [[NSAttributedString alloc] initWithString:[str1 substringWithRange:NSMakeRange(3, 2)] attributes:@{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:24],
        NSForegroundColorAttributeName:orange_color,
        NSBackgroundColorAttributeName:blue_color
    }];
    NSAttributedString *attr14 = [[NSAttributedString alloc] initWithString:[str1 substringWithRange:NSMakeRange(5, 1)] attributes:@{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:12],
        NSForegroundColorAttributeName:blue_color,
        NSBackgroundColorAttributeName:orange_color,
    }];
    NSAttributedString *attr15 = [[NSAttributedString alloc] initWithString:[str1 substringWithRange:NSMakeRange(6, 5)] attributes:@{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:12],
        NSForegroundColorAttributeName:[UIColor blackColor],
        NSBackgroundColorAttributeName:[UIColor lightGrayColor]}];
    
    [mutAttr1 appendAttributedString:attr11];
    [mutAttr1 appendAttributedString:attr12];
    [mutAttr1 appendAttributedString:attr13];
    [mutAttr1 appendAttributedString:attr14];
    [mutAttr1 appendAttributedString:attr15];
    
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    _label1.text = str1;
    _label1.attributedText = mutAttr1;
    _label1.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_label1];
    
    //4.NSLigatureAttributeName
    //连体字符是指某些连在一起的字符，它们采用单个的图元符号。0 表示没有连体字符。1 表示使用默认的连体字符。2 表示使用所有连体符号。默认值为 1（注意，iOS 不支持值为 2）
    NSString *str2 = @"flush and fily";
    NSMutableAttributedString *mutAttr2 = [[NSMutableAttributedString alloc] init];
    NSAttributedString *attr21 = [[NSAttributedString alloc] initWithString:[str2 substringWithRange:NSMakeRange(0, str2.length)] attributes:@{
        NSLigatureAttributeName:[NSNumber numberWithInt:1],
        NSFontAttributeName:[UIFont systemFontOfSize:30],
    }];
    
    [mutAttr2 appendAttributedString:attr21];
    
    _label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 40)];
    _label2.text = str2;
    _label2.attributedText = mutAttr2;
    _label2.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_label2];
    //5.NSKernAttributeName
    //字符间距正值间距加宽，负值间距变窄
    NSString *str3 = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableAttributedString *mutAttr3 = [[NSMutableAttributedString alloc] init];
    NSAttributedString *attr31 = [[NSAttributedString alloc] initWithString:[str3 substringWithRange:NSMakeRange(0, 5)] attributes:@{
        NSKernAttributeName:[NSNumber numberWithInt:4],
        NSForegroundColorAttributeName:orange_color,
    }];
    NSAttributedString *attr32 = [[NSAttributedString alloc] initWithString:[str3 substringWithRange:NSMakeRange(5, 10)] attributes:@{
        NSKernAttributeName:[NSNumber numberWithInt:-3],
        NSForegroundColorAttributeName: red_color,
    }];
    [mutAttr3 appendAttributedString:attr31];
    [mutAttr3 appendAttributedString:attr32];
    
    _label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 40)];
    _label3.text = str3;
    _label3.attributedText = mutAttr3;
    _label3.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_label3];
    
//    6.NSStrikethroughStyleAttributeName 和 NSStrikethroughColorAttributeName
//
//    NSStrikethroughStyleAttributeName 设置删除线，取值为 NSNumber 对象（整数），
//    NSStrikethroughColorAttributeName 设置删除线颜色
//    枚举常量 NSUnderlineStyle中的值：
//
//    NSUnderlineStyleNone =0x00, 不设置
//    NSUnderlineStyleSingle =0x01, 设置单细删除线
//    NSUnderlineStyleThick NS_ENUM_AVAILABLE(10_0,7_0) = 0x02, 设置粗单删除线
//    NSUnderlineStyleDouble NS_ENUM_AVAILABLE(10_0,7_0) = 0x09,双细删除线
    NSString *str4 = @"";
    NSMutableAttributedString *mutAttr4 = [[NSMutableAttributedString alloc] init];
    NSAttributedString *attr41 = [[NSAttributedString alloc] initWithString:@"ABC" attributes:@{
        NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),
        NSStrikethroughColorAttributeName:red_color,
    }];
    NSAttributedString *attr42 = [[NSAttributedString alloc] initWithString:@"GHI" attributes:@{
        NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick),
        NSStrikethroughColorAttributeName:blue_color
    }];
    NSAttributedString *attr43 = [[NSAttributedString alloc] initWithString:@"DEF" attributes:@{
        NSStrikethroughStyleAttributeName:@(NSUnderlineStyleDouble),
        NSStrikethroughColorAttributeName:orange_color
    }];
    [mutAttr4 appendAttributedString:attr41];
    [mutAttr4 appendAttributedString:attr42];
    [mutAttr4 appendAttributedString:attr43];
    
    _label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 40)];
    _label4.text = str4;
    _label4.attributedText = mutAttr4;
    _label4.font = [UIFont systemFontOfSize:30];
    _label4.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_label4];
    
//    7.NSUnderlineStyleAttributeName 和
//    NSUnderlineColorAttributeName
//    给文字加下划线和更换下划线颜色，属性和上面的删除线都是一样用的
    NSString *str5 = @"";
    NSMutableAttributedString *mutAttr5 = [[NSMutableAttributedString alloc] init];
    NSAttributedString *attr51 = [[NSAttributedString alloc] initWithString:@"我是谁" attributes:@{
        NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
        NSUnderlineColorAttributeName:purple_color,
    }];
    NSAttributedString *attr52 = [[NSAttributedString alloc] initWithString:@"不知道" attributes:@{
        NSUnderlineStyleAttributeName:@(NSUnderlineStyleThick),
        NSUnderlineColorAttributeName:yellow_color
    }];
    NSAttributedString *attr53 = [[NSAttributedString alloc] initWithString:@"你猜啊" attributes:@{
        NSUnderlineStyleAttributeName:@(NSUnderlineStyleDouble),
        NSUnderlineColorAttributeName:red_color
    }];
    [mutAttr5 appendAttributedString:attr51];
    [mutAttr5 appendAttributedString:attr52];
    [mutAttr5 appendAttributedString:attr53];
    
    _label5 = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 40)];
    _label5.text = str5;
    _label5.attributedText = mutAttr5;
    _label5.font = [UIFont systemFontOfSize:30];
    _label5.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_label5];
    
//    8.NSStrokeWidthAttributeName 和NSStrokeColorAttributeName
//    设置文字描边颜色，需要和NSStrokeWidthAttributeName设置描边宽度，这样就能使文字空心.
//    NSStrokeWidthAttributeName 这个属性所对应的值是一个 NSNumber 对象(小数)。该值改变笔画宽度（相对于字体 size 的百分比），负值填充效果，正值中空效果，默认为 0，即不改变。正数只改变描边宽度。负数同时改变文字的描边和填充宽度。例如，对于常见的空心字，这个值通常为3.0。同时设置了空心的两个属性，并且 NSStrokeWidthAttributeName 属性设置为整数，文字前景色就无效果了
    NSString *str6 = @"";
    NSMutableAttributedString *mutAttr6 = [[NSMutableAttributedString alloc] init];
    NSAttributedString *attr61 = [[NSAttributedString alloc] initWithString:@"ABCDEFG" attributes:@{
        NSStrokeWidthAttributeName:@(5),
        NSStrokeColorAttributeName:blue_color,
    }];
    NSAttributedString *attr62 = [[NSAttributedString alloc] initWithString:@"GOOGLE" attributes:@{
        NSStrokeWidthAttributeName:@(-5),
        NSStrokeColorAttributeName:green_color,
        NSFontAttributeName:[UIFont boldSystemFontOfSize:30],
        NSForegroundColorAttributeName:red_color
    }];
    [mutAttr6 appendAttributedString:attr61];
    [mutAttr6 appendAttributedString:attr62];
    
    _label6 = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 40)];
    _label6.text = str6;
    _label6.attributedText = mutAttr6;
    _label6.font = [UIFont systemFontOfSize:30];
    _label6.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_label6];
//    9.NSShadowAttributeName
//    设置文字阴影，取值为NSShadow对象
    _label7 = [[UILabel alloc] initWithFrame:CGRectMake(0, 240, SCREEN_WIDTH, 40)];
    _label7.text = str6;
    _label7.attributedText = mutAttr6;
    _label7.font = [UIFont systemFontOfSize:30];
    _label7.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_label7];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 5.0f; // 模糊度
    shadow.shadowColor = blue_color;
    shadow.shadowOffset = CGSizeMake(1, 5);
    NSAttributedString *attr71 = [[NSAttributedString alloc] initWithString:@"ah爱干净的akjd1782" attributes:@{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:30],
        NSForegroundColorAttributeName:red_color,
        NSShadowAttributeName:shadow
    }];
    _label7.attributedText = attr71;
    
//    10.NSTextEffectAttributeNam
//    NSTextEffectAttributeName //设置文本特殊效果，取值为NSString类型，目前只有一个可用效果 NSTextEffectLetterpressStyle（凸版印刷效果）
    // 文本印刷，我也不知道是什么鬼
    // 设置阴影
    _label8 = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, SCREEN_WIDTH, 40)];
    _label8.text = str6;
    _label8.attributedText = mutAttr6;
    _label8.font = [UIFont systemFontOfSize:30];
    _label8.textAlignment = NSTextAlignmentCenter;
    [_scrollView addSubview:_label8];
    NSAttributedString *attr81 = [[NSAttributedString alloc] initWithString:@"ah爱干净的akjd1782" attributes:@{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:30],
        NSForegroundColorAttributeName:red_color,
        NSShadowAttributeName:shadow,
        NSTextEffectAttributeName:NSTextEffectLetterpressStyle
    }];
    _label8.attributedText = attr81;
    
//    11.NSBaselineOffsetAttributeName
//    文字基线偏移,要设置需要的文字偏移，正数上移，负数下移
    
}


@end
