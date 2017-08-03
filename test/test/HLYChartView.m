//
//  HLYTableView.m
//  test
//
//  Created by felix on 2017/5/31.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYChartView.h"
#import "Masonry.h"

typedef NS_ENUM(NSInteger, HLYChartProgressDirectionTyle) {
    HLYChartProgressDirectionTyleUp = 0,
    HLYChartProgressDirectionTyleDown,
};

@interface HLYChartView()

@property (nonatomic, strong) UIView *leftListStandardView;
@property (nonatomic, strong) UIView *rightListChatView;
@property (nonatomic, strong) UIView *bottomListView;

@property (nonatomic, strong, readwrite) HLYChartViewModel *model;

@end

static const NSInteger bottomListViewH  = 30.0;
static const NSInteger margin = 15.0f;
static const NSInteger leftSideW = 23;

static const CGFloat kBarLineW = 7.0;
static const CGFloat kBarLineBgW = kBarLineW;

NSInteger const viewTagBaseConstant = 10;

@implementation HLYChartView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.model = [HLYChartViewModel new];
    }
    return self;
}

- (void)ms_load {

    [self comInit];
    [self dataFeed];
}

- (void)comInit {
    //left
    self.leftListStandardView = [UIView new];
    [self addSubview:self.leftListStandardView];
    
    self.bottomListView = [UIView new];
    [self addSubview:self.bottomListView];
    
    self.rightListChatView = [UIView new];
    [self addSubview:_rightListChatView];
    
    [self createConstraints];

}

- (void)createConstraints {
    
    [self.leftListStandardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.mas_equalTo(margin);
        make.bottom.equalTo(self).offset(-bottomListViewH);
        make.width.mas_equalTo(leftSideW);
    }];
    
    [self.bottomListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self.leftListStandardView.mas_right);
        make.right.equalTo(self);
        make.height.mas_equalTo(bottomListViewH);
    }];
    
    [self.rightListChatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self.leftListStandardView.mas_right);
        make.bottom.equalTo(self.bottomListView.mas_top);
        make.right.equalTo(self);
    }];
    
//    self.leftListStandardView.backgroundColor = [UIColor redColor];
//    self.bottomListView.backgroundColor = [UIColor purpleColor];
//    self.rightListChatView.backgroundColor = [UIColor grayColor];
}

- (void)dataFeed {

    CGFloat leftSideViewH = self.model.size.height - bottomListViewH;
    CGFloat rightChartViewW = self.model.size.width - margin - leftSideW;
    CGFloat rightChartViewH =leftSideViewH;
    CGFloat bottomListW = rightChartViewW;
    CGFloat leftLabelH = leftSideViewH / self.model.leftSideStandardDatas.count;
    CGFloat bottomLabelW = bottomListW / self.model.bottomLabelNames.count;
    
    CGFloat displayDataNumber = MIN(self.model.downDatas.count, self.model.upDatas.count);
    
    for (NSInteger index = 0; index < self.model.leftSideStandardDatas.count; index++) {
        UILabel *leftLabel = [UILabel new];
        [self.leftListStandardView addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self.leftListStandardView);
            make.top.equalTo(self.leftListStandardView).offset(leftLabelH *index);
            make.height.mas_equalTo(leftLabelH);
        }];
        leftLabel.text = [NSString stringWithFormat:@"%@",self.model.leftSideStandardDatas[index]];
        leftLabel.textAlignment = NSTextAlignmentCenter;
        leftLabel.font = [UIFont systemFontOfSize:10];
        leftLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        
//        水平线
        UIView *horizontalLine = [UIView new];
        [self.rightListChatView addSubview:horizontalLine];
        [horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.left.equalTo(self.rightListChatView);
            make.right.equalTo(self.rightListChatView);
            make.centerY.equalTo(self.rightListChatView.mas_top).offset(index * leftLabelH + leftLabelH/2);
        }];
        horizontalLine.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];

        
    }
    
    for (NSInteger index=0; index < self.model.bottomLabelNames.count; index++) {
        UILabel *bottomLabel = [UILabel new];
        
        [self.bottomListView addSubview:bottomLabel];
        [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.bottomListView);
            make.width.mas_equalTo(bottomLabelW);
            make.left.mas_equalTo(index * bottomLabelW);
        }];
        bottomLabel.text = [NSString stringWithFormat:@"%@",self.model.bottomLabelNames[index]];
        bottomLabel.textAlignment = NSTextAlignmentCenter;
        bottomLabel.font = [UIFont systemFontOfSize:10];
        bottomLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        
//        bar bg line
        if (index < displayDataNumber) {
            
            UIView *barLineBg = [UIView new];
            [self.rightListChatView addSubview:barLineBg];
            [barLineBg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(kBarLineBgW);
                make.height.mas_equalTo(rightChartViewH);
                make.centerX.equalTo(bottomLabel);
                make.top.equalTo(self.rightListChatView);
            }];
            barLineBg.backgroundColor = [UIColor clearColor];
            barLineBg.tag = index + viewTagBaseConstant;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(act_Tap:)];
            [barLineBg addGestureRecognizer:tapGesture];
            
            UIView *barLineUpBg = [UIView new];
            [barLineBg addSubview:barLineUpBg];
            [barLineUpBg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.and.top.equalTo(barLineBg);
                make.height.mas_equalTo(rightChartViewH/2);
            }];
            barLineUpBg.backgroundColor = [UIColor clearColor];
            
            UIView *barLineDownBg = [UIView new];
            [barLineBg addSubview:barLineDownBg];
            [barLineDownBg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.and.bottom.equalTo(barLineBg);
                make.height.mas_equalTo(rightChartViewH/2);
            }];
            barLineDownBg.backgroundColor = [UIColor clearColor];

//            向下
            CGFloat barLineDownStartY = 0;
            CGFloat barLineDownStartX = kBarLineW/2;
            CGFloat barLIneDownToX = barLineDownStartX;
            CGFloat barLineDownToY = [self.model.downDatas[index] floatValue]/self.model.downMaxData * rightChartViewH/2 + barLineDownStartY - kBarLineW/2;
            CGPoint downStartPoint = CGPointMake(barLineDownStartX, barLineDownStartY);
            CGPoint downToPoint = CGPointMake(barLIneDownToX, barLineDownToY);
            UIColor *downCurrentColor;
            if (index == self.model.currentIndex) {
                UIColor *downDefaultCurrenColor = [UIColor yellowColor];
                UIColor *currentColor = self.model.downCurrentColor?self.model.downCurrentColor:downDefaultCurrenColor;
                downCurrentColor = currentColor;
            }else{
                UIColor *downDefaultNomalColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.23];
                UIColor *downNomalColor = self.model.downNomalColor?self.model.downNomalColor:downDefaultNomalColor;
                downCurrentColor = downNomalColor;
            }
            [self chartView:self startPoint:downStartPoint toPoint:downToPoint progressLineWidth:kBarLineW progressBgView:barLineDownBg ProgressLineColor:downCurrentColor];
            
//            向上
            CGFloat barLineUpStartX = barLineDownStartX;
            CGFloat barLineUpStartY = rightChartViewH/2;
            CGFloat barLineUpToX = barLineUpStartX;
            CGFloat barLineUpToY = barLineUpStartY - ([self.model.upDatas[index] floatValue]/self.model.upMaxData * rightChartViewH/2 - kBarLineW/2);
            CGPoint upStartPoint = CGPointMake(barLineUpStartX, barLineUpStartY);
            CGPoint upToPoint = CGPointMake(barLineUpToX, barLineUpToY);
            UIColor *upCurrentColor;
            if (index == self.model.currentIndex) {
                UIColor *upDefaultCurrenColor = [UIColor greenColor];
                UIColor *downCurrentColor = self.model.upCurrentColor?self.model.upCurrentColor:upDefaultCurrenColor;
                upCurrentColor = downCurrentColor;
            }else{
                UIColor *upDefaultColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.6];
                UIColor *currentColor = self.model.upNomalColor?self.model.upNomalColor:upDefaultColor;
                upCurrentColor = currentColor;
            }
            [self chartView:self startPoint:upStartPoint toPoint:upToPoint progressLineWidth:kBarLineW progressBgView:barLineUpBg ProgressLineColor:upCurrentColor];
        }
        
    }
}

- (void)chartView:(HLYChartView *)chatView startPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint progressLineWidth:(CGFloat)progressLineWidth progressBgView:(UIView *)barLineBgView ProgressLineColor:(UIColor*)progressColor {

    CAShapeLayer *progressLine = [CAShapeLayer new];
    [barLineBgView.layer addSublayer:progressLine];
    barLineBgView.layer.masksToBounds = YES;
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:startPoint];
    [linePath addLineToPoint:endPoint];
    progressLine.path = linePath.CGPath;
    progressLine.lineWidth = progressLineWidth;
    progressLine.strokeColor = progressColor.CGColor;
    progressLine.lineCap = kCALineCapRound;
    [progressLine removeAllAnimations];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue = @0;
    pathAnimation.toValue = @1;
    pathAnimation.autoreverses = NO;
    pathAnimation.repeatCount = 1;
    [progressLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

#pragma mark -- action event 
- (void)act_Tap:(UIGestureRecognizer *) recognizer {
    !_act_tap?:_act_tap(recognizer.view.tag);
}


@end

@interface HLYChartViewModel()

@property (nonatomic, strong, readwrite) NSArray<NSString *> *bottomLabelNames;
@property (nonatomic, strong, readwrite) NSArray<NSNumber *> *leftSideStandardDatas; // 侧栏的标准数
@property (nonatomic, strong, readwrite) NSArray<NSNumber *> *upDatas; // 体重量
@property (nonatomic, strong, readwrite) NSArray<NSNumber *> *downDatas; // 脂肪的量

@property (nonatomic, assign, readwrite) CGFloat upMaxData;
@property (nonatomic, assign, readwrite) CGFloat downMaxData;

@property (nonatomic, assign, readwrite) CGSize size;

@property (nonatomic, strong, readwrite) UIColor *upCurrentColor;
@property (nonatomic, strong, readwrite) UIColor *downCurrentColor;
@property (nonatomic, strong, readwrite) UIColor *upNomalColor;
@property (nonatomic, strong, readwrite) UIColor *downNomalColor;
@property (nonatomic, assign, readwrite) NSInteger currentIndex;
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;

@end

static const NSInteger leftSideMaxNumber = 5;

@implementation HLYChartViewModel

- (void)initChartViewSize:(CGSize)size {
    self.size = size;
}

- (void)configureBottomLabelNamess:(NSArray<NSString *> *)labelNames upDatas:(NSArray<NSNumber *> *)upDatas downDatas:(NSArray<NSNumber *> *)downDatas{
    self.bottomLabelNames = labelNames;
    self.upDatas = upDatas;
    self.downDatas = downDatas;
    
    [self filterLabelNamesTranslateToUserfulDatas];
}

- (void)filterLabelNamesTranslateToUserfulDatas {
    self.currentIndex = self.upDatas.count - 1;
    
    for (NSNumber *number in self.downDatas) {
        CGFloat f = [number floatValue];
        if (f > _downMaxData) {
            _downMaxData = f;
        }
    }
    
    for (NSNumber *number in self.upDatas) {
        CGFloat f = [number floatValue];
        if (f > _upMaxData) {
            _upMaxData = f;
        }
    }

}

- (NSArray<NSNumber *> *)leftSideStandardDatas {
    if (!_leftSideStandardDatas) {
        NSInteger secondItem = self.upMaxData/leftSideMaxNumber * 2 + 1;
        NSInteger firstItem = secondItem * 2;
        NSInteger thirdItem = 0;
        NSInteger fourthItem = self.downMaxData/leftSideMaxNumber * 2 + 1;
        NSInteger fitthItem = fourthItem * 2;
        _leftSideStandardDatas = @[
                                   [NSNumber numberWithInteger:firstItem],
                                   [NSNumber numberWithInteger:secondItem],
                                   [NSNumber numberWithInteger:thirdItem],
                                   [NSNumber numberWithInteger:fourthItem],
                                   [NSNumber numberWithInteger:fitthItem]
                                   ];
    }
    return _leftSideStandardDatas;
}


@end
