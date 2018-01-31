//
//  YDDisplayView.m
//  TestCoreText
//
//  Created by mac on 29/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDDisplayView.h"
#import "NSString+GHTransformation.h"

@interface YDDisplayView ()

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation YDDisplayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor yellowColor];
    
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
//    [self test0withRect:rect];
//    [self test1WithRect:rect];
    [self test2WithRect:rect];
}

- (void)test2WithRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    CGFloat fontSize = 26.f;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    CGFloat lineSpacing = 8.f;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing },
        { kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpacing },
        { kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpacing }
    };
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    UIColor * textColor = RGB(108, 108, 108);
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dict[(id)kCTBackgroundColorAttributeName] = (id)[UIColor redColor].CGColor;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
//    dict[(id)kct]
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"sjkadfjaklsdjfkalsjfword! ka lsd jfka,dsakfjkas ; adskfjkasjd ." attributes:dict];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
    CTFrameDraw(frame, context);
    
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}

- (void)test1WithRect:(CGRect)rect {
    // 步骤 1
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 步骤 2
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //    这个划线还是倒不了（原点在左下角）
//    CGMutablePathRef path1 = CGPathCreateMutable();
//    CGRect bounds = self.bounds;
//    CGPoint orgin = bounds.origin;
//    CGSize size = bounds.size;

//    current origin & size (you must be bounds) (对应的向下是减法)
//    CGPathMoveToPoint(path1, NULL, 0, 0);
//    //    CGPathAddLineToPoint(path1, &CGAffineTransformIdentity, 100, 100);
//    CGPathAddLineToPoint(path1, NULL, 200, 0);
//    CGPathAddLineToPoint(path1, NULL, 200, 200);
//    CGPathAddLineToPoint(path1, NULL, 0, 200);
//    CGPathCloseSubpath(path1);
//     先把发小确定，然后在进行翻转
    
    // 步骤 3
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, self.bounds);
    
    //    CGMutablePathRef path = CGPathCreateMutableCopy(path);
    //    CFTypeID pathId = CGPathGetTypeID();
    //    CGPathRef copyPath =CGPathCreateCopy(path);
    //    CGPathRef copyPath2 = CGPathCreateCopyByTransformingPath(path, &CGAffineTransformIdentity);
    //    CGPathRef mCopyPath = CGPathCreateMutableCopy(path);
    //    CGPathAddLineToPoint(mCopyPath, &CGAffineTransformIdentity, 300, 400);
    //    CGPathCloseSubpath(mCopyPath); // 关闭收尾的（头部和尾部合并连接在一起）
    
    //    CGColorCreateCopyByMatchingToColorSpace(<#CGColorSpaceRef _Nullable#>, <#CGColorRenderingIntent intent#>, <#CGColorRef  _Nullable color#>, <#CFDictionaryRef  _Nullable options#>)
    //    CGContextSetLineWidth(context, 5.f);
    //    CGContextSetRGBFillColor(context, 55.f/255, 55.f/255, 55.f/255, 1.f);
    //    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 218.f/255.f, 1.f);
    //    CGContextDrawPath(context, kCGPathFillStroke);
    //    CGPathRelease(path1);
    
    //    typedef CF_ENUM(int32_t, CGPathElementType) {
    //        kCGPathElementMoveToPoint,
    //        kCGPathElementAddLineToPoint,
    //        kCGPathElementAddQuadCurveToPoint,
    //        kCGPathElementAddCurveToPoint,
    //        kCGPathElementCloseSubpath
    //    };
    //     步骤 4
    
//     这里的属性，王权可以使用CT对应的类型进行实现对应的字典
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"sjkadfjaklsdjfkalsjfword! ka lsd jfka,dsakfjkas ; adskfjkasjd ." attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:17.f],NSBackgroundColorAttributeName:[UIColor whiteColor]}];
    //
    //    // 如何实现是经过字符换行还是词换行
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
//    ？？？？
//    图片的等等自定义的大小又是怎么算的？？？
    //    字体以及等等有关的内容，最后还是通过nsAttri** 这些属性来设置的（c里面应该有对应的属性）
    
    // 步骤 5
    CTFrameDraw(frame, context);
    
    // 步骤 6
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}

- (void)test0withRect:(CGRect)rect {
//    这个应该还是UI的坐标
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 85, 85);
    CGContextAddLineToPoint(context, 150, 150);
    CGContextAddLineToPoint(context, 250, 50);
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextSetLineWidth(context, 10);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextDrawPath(context, kCGPathStroke);
}

@end
