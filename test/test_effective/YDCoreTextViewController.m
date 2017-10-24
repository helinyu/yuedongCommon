//
//  YDCoreTextViewController.m
//  test_effective
//
//  Created by Aka on 2017/10/23.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDCoreTextViewController.h"
#import "Masonry.h"
#import "YDVerticalView.h"

@interface YDCoreTextViewController ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *verticalLabel;
@property (nonatomic, strong) YDVerticalView *verticalView;
@property (nonatomic, copy) NSString *originText;

@end

@implementation YDCoreTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];

    _label = [UILabel new];
    [self.view addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64.f);
    }];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.contentMode = UIViewContentModeScaleAspectFill;
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    _label.numberOfLines = 0;
    
//    _verticalLabel = [UILabel new];
//    [self.view addSubview:_verticalLabel];
//    _verticalLabel.backgroundColor = [UIColor greenColor];
//    [_verticalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_label.mas_bottom);
//        make.left.right.equalTo(self.view);
//    }];
//    [_verticalLabel sizeToFit];
//    _verticalLabel.numberOfLines = 0;
//    _verticalLabel.text = @"ajsdfhaj";
    
    
    _originText = @"2016年1月27日 - 转自: fl一、先了解下 什么是光栅化及光栅化的简单过程? 光栅化是将几何数据经过一系列变换后最终转换为像素,从而呈现在显示设备上的过程,如下图: 光栅化的...Toll-Free Bridged类型 - 追梦 - CSDN博客 2014年8月19日 - 某些数据类型能够在Core Foundation和Foundation之间互换使用,可被互换使用的数据类型被称为Toll-Free Bridged类型。这意味着同一数据类型即可以作为C...";
  
    _label.backgroundColor = [UIColor orangeColor];
    
//    [self test0];
    [self testAttributeString];
//    [self testVertical];
    [self testTextLayer];
}

// 这个还是行向，无法改变为竖直的方向
- (void)testTextLayer {
    _verticalView = [YDVerticalView new];
    [self.view addSubview:_verticalView];
    [_verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_label.mas_bottom);
        make.height.mas_equalTo(100.f);
    }];
   CATextLayer *textLayer  = (CATextLayer *)_verticalView.layer;
    NSString *verText = @"asfdkjaskfdj";
    NSMutableAttributedString *mString = [[NSMutableAttributedString alloc] initWithString:verText];
    NSShadow *shadow = [NSShadow new];
    shadow.shadowBlurRadius = 5.f;
    shadow.shadowColor = [UIColor redColor];
    shadow.shadowOffset = CGSizeMake(1, 3);
    [mString addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, 4)];
    [mString addAttribute:NSObliquenessAttributeName value:@1 range:NSMakeRange(0, 4)];
    [mString addAttribute:NSVerticalGlyphFormAttributeName value:@1 range:NSMakeRange(0, 4)];
//    if (@available(iOS 11.0, *)) {
////        textLayer.accessibilityAttributedLabel = mString;
////        textLayer.accessibilityAttributedValue = mString;
////        textLayer.accessibilityAttributedHint = mString;
////        textLayer.foregroundColor = (__bridge CGColorRef)[UIColor purpleColor];
//        textLayer.string = mString;
//    } else {
//        // Fallback on earlier versions
//        textLayer.string = mString;
//    }
    textLayer.string = verText;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
}

- (void)testVertical {
    _verticalView = [YDVerticalView new];
    [self.view addSubview:_verticalView];
    [_verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_label.mas_bottom);
        make.height.mas_equalTo(100.f);
    }];
    NSString *verText = @"asfdkjaskfdj";
    NSMutableAttributedString *mString = [[NSMutableAttributedString alloc] initWithString:verText];
    NSShadow *shadow = [NSShadow new];
    shadow.shadowBlurRadius = 5.f;
    shadow.shadowColor = [UIColor redColor];
    shadow.shadowOffset = CGSizeMake(1, 3);
    [mString addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, 4)];
    [mString addAttribute:NSObliquenessAttributeName value:@1 range:NSMakeRange(0, 4)];
    [mString addAttribute:NSVerticalGlyphFormAttributeName value:@1 range:NSMakeRange(0, 4)];
    NSDictionary *dic = @{
                          NSShadowAttributeName:shadow,
                          NSObliquenessAttributeName:@1,
                          NSVerticalGlyphFormAttributeName:@1,
                          };
    self.verticalView.backgroundColor = [UIColor greenColor];
//    [self.verticalView drawText:verText x:0 y:0];
//    self.verticalView.textInputMode
//    [self drawText:_verticalView x:200 y:200];
    //    [verText drawInRect:self.verticalView.bounds withAttributes:dic];
//    _verticalLabel.attributedText = mString;
}



- (void)test0 {
    _label.text = _originText;
    [_label sizeToFit];
}

- (void)testAttributeString{
//    设置字体属性
    NSMutableAttributedString *mString = [[NSMutableAttributedString alloc] initWithString:_originText];
    [mString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Medium" size:14.f] range:NSMakeRange(6, 2)];
    [mString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18.f] range:NSMakeRange(8, 2)];
    [mString addAttribute:NSFontAttributeName value:[UIFont italicSystemFontOfSize:20.f] range:NSMakeRange(10, 4)];
    
//    段落应该如何去添加‘？？？
//    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraphStyle.lineSpacing = 6.f;
//    paragraphStyle.paragraphSpacing = 10.f;
//    paragraphStyle.alignment = NSTextAlignmentLeft;
//    paragraphStyle.firstLineHeadIndent = 200.f;
//    paragraphStyle.headIndent = 30.f;
//    paragraphStyle.tailIndent = 20.f;
//    paragraphStyle.minimumLineHeight = 20.f;
//    paragraphStyle.maximumLineHeight = 100.f;
//    paragraphStyle.baseWritingDirection = NSWritingDirectionRightToLeft;
//    paragraphStyle.lineHeightMultiple = 2.f;
//    paragraphStyle.paragraphSpacingBefore = 30.f;
//    [mString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, 233)];
//    @property (NS_NONATOMIC_IOSONLY) float hyphenationFactor;
//    @property (null_resettable, copy, NS_NONATOMIC_IOSONLY) NSArray<NSTextTab *> *tabStops NS_AVAILABLE(10_0, 7_0);
//    @property (NS_NONATOMIC_IOSONLY) CGFloat defaultTabInterval NS_AVAILABLE(10_0, 7_0);
//    @property (NS_NONATOMIC_IOSONLY) BOOL allowsDefaultTighteningForTruncation NS_AVAILABLE(10_11, 9_0);
//    - (void)addTabStop:(NSTextTab *)anObject NS_AVAILABLE(10_0, 9_0);
//    - (void)removeTabStop:(NSTextTab *)anObject NS_AVAILABLE(10_0, 9_0);
//    - (void)setParagraphStyle:(NSParagraphStyle *)obj NS_AVAILABLE(10_0, 9_0);
    //    NSRange range = NSMakeRange(0, 2);
//    UIColor *color = [mString attribute:NSForegroundColorAttributeName atIndex:0 effectiveRange:&range];
//    NSLog(@"m string :%@",color);
    
    [mString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    [mString addAttribute:NSBackgroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(2, 2)];
//    [mString addAttribute:NSLigatureAttributeName value:@(2) range:NSMakeRange(15, 4)];
    [mString addAttribute:NSBackgroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(15, 4)];
    [mString addAttribute:NSFontAttributeName value:[UIFont fontWithName: @"futura" size: 17] range:NSMakeRange(15, 4)];
    [mString addAttribute:NSLigatureAttributeName value:@(1) range:NSMakeRange(15, 4)]; // 连体
    
    [mString addAttribute:NSKernAttributeName value:@(2) range:NSMakeRange(20, 4)]; // 字间距
    [mString addAttribute:NSBackgroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(20, 4)];
    
    [mString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleDouble) range:NSMakeRange(25, 4)]; // 删除线
    [mString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleDouble) range:NSMakeRange(30, 4)]; // 下划线

    [mString addAttribute:NSStrokeColorAttributeName value:[UIColor greenColor] range:NSMakeRange(35, 4)]; //
    [mString addAttribute:NSStrokeWidthAttributeName value:@3 range:NSMakeRange(35, 4)]; //设置字的边框以及颜色，两个一起使用
//    [mString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(35, 4)]; //
//     和forecolor 关系,默认是nil，和forecolor一样

    NSShadow *shadow = [NSShadow new];
    shadow.shadowBlurRadius = 5.f;
    shadow.shadowColor = [UIColor redColor];
    shadow.shadowOffset = CGSizeMake(1, 3);
    [mString addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(40, 4)];
    [mString addAttribute:NSObliquenessAttributeName value:@1 range:NSMakeRange(40, 4)];
    [mString addAttribute:NSVerticalGlyphFormAttributeName value:@1 range:NSMakeRange(40, 4)];
    
    [mString addAttribute:NSTextEffectAttributeName value:NSTextEffectLetterpressStyle range:NSMakeRange(45, 4)];
    [mString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(45, 3)];
//     打印文件的时候需要有凸出来的效果
    
    /* 下面实现在百度两个汉字之间插入一个照片 */
    NSString *stiAtt = @"百度";
    NSTextAttachment *attach = [[NSTextAttachment alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:stiAtt options:NSDataBase64DecodingIgnoreUnknownCharacters] ofType:@""];
    [mString addAttribute:NSAttachmentAttributeName value:attach range:NSMakeRange(50, 4)];
    [mString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(50, 4)];
//    ??? 这里为什么加不进去？

    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/"];
    [mString addAttribute:NSLinkAttributeName value:url range:NSMakeRange(55, 10)];
    [mString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(55, 4)];

    [mString addAttribute:NSBaselineOffsetAttributeName value:@15.f range:NSMakeRange(60, 4)];
//    设置距离下划线
    [mString addAttribute:NSUnderlineColorAttributeName value:[UIColor greenColor] range:NSMakeRange(65, 4)];
    [mString addAttribute:NSStrikethroughColorAttributeName value:[UIColor cyanColor] range:NSMakeRange(65, 4)];
    [mString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleDouble) range:NSMakeRange(65, 4)];
    [mString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleDouble) range:NSMakeRange(65, 4)];
/*
    typedef NS_ENUM(NSInteger, NSUnderlineStyle) {
        NSUnderlineStyleNone                                    = 0x00,
        NSUnderlineStyleSingle                                  = 0x01,
        NSUnderlineStyleThick NS_ENUM_AVAILABLE(10_0, 7_0)      = 0x02,
        NSUnderlineStyleDouble NS_ENUM_AVAILABLE(10_0, 7_0)     = 0x09,
        NSUnderlinePatternSolid NS_ENUM_AVAILABLE(10_0, 7_0)      = 0x0000,
        NSUnderlinePatternDot NS_ENUM_AVAILABLE(10_0, 7_0)        = 0x0100,
        NSUnderlinePatternDash NS_ENUM_AVAILABLE(10_0, 7_0)       = 0x0200,
        NSUnderlinePatternDashDot NS_ENUM_AVAILABLE(10_0, 7_0)    = 0x0300,
        NSUnderlinePatternDashDotDot NS_ENUM_AVAILABLE(10_0, 7_0) = 0x0400,
        
        NSUnderlineByWord NS_ENUM_AVAILABLE(10_0, 7_0)            = 0x8000
    } NS_ENUM_AVAILABLE(10_0, 6_0);
 
    typedef NS_ENUM(NSInteger, NSWritingDirectionFormatType) {
    NSWritingDirectionEmbedding     = (0 << 1),
    NSWritingDirectionOverride      = (1 << 1)
    } NS_ENUM_AVAILABLE(10_11, 9_0);

    // NSTextEffectAttributeName values
    typedef NSString * NSTextEffectStyle NS_STRING_ENUM;
    UIKIT_EXTERN NSTextEffectStyle const NSTextEffectLetterpressStyle NS_AVAILABLE(10_10, 7_0);
    // 下面还有一些对应的NSAttributeString的分类

 */
    _label.attributedText = mString;
    NSLog(@"length :%lu",(unsigned long)mString.length);
    
}

@end
