//
//  YDTestlayerViewController.m
//  TestCoreText
//
//  Created by mac on 12/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTestlayerViewController.h"
#import "JBChartView.h"
#import "JBLineChartView.h"

@interface YDTestlayerViewController ()<UITableViewDataSource,UITableViewDelegate,JBLineChartViewDataSource,JBLineChartViewDelegate>

@property (nonatomic, strong) CALayer *sonLayer;

@property (nonatomic, strong) NSMutableArray *dataSources;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) JBChartView *chartView;

@property (nonatomic, strong) NSArray *chartData;

@property (nonatomic, strong) JBLineChartView *lineChartView;

@end

 @implementation YDTestlayerViewController

- (void)dealloc
{
//    JBLineChartView *lineChartView = ...; // i.e. _lineChartView
    _lineChartView.delegate = nil;
    _lineChartView.dataSource = nil;
    _lineChartView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self test2];
}


- (void)test2 {
    JBLineChartView *lineChartView = [JBLineChartView new];
    lineChartView.dataSource = self;
    lineChartView.delegate = self;
    [self.view addSubview:lineChartView];
    _lineChartView = lineChartView;
    _lineChartView.frame = CGRectMake(0, 100, self.view.bounds.size.width, 100);
    _lineChartView.backgroundColor = [UIColor yellowColor];
    [_lineChartView reloadData];
}

#pragma mark line chart view

- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView
{
    return 2; // number of lines in chart
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex
{
    return 2; // number of values for a line
}
- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex
{
    return 2.f;
}


- (void)test1 {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _dataSources = @[].mutableCopy;
}

- (void)test0 {
    //    self.view.backgroundColor = [UIColor whiteColor];
    //
        _sonLayer = [CALayer new];
        [self.view.layer addSublayer:_sonLayer];
        _sonLayer.backgroundColor = [UIColor yellowColor].CGColor;
        _sonLayer.frame = CGRectMake(0, 100, 100, 100);
    //    _sonLayer.contents = @"123";
        _sonLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"Snip20180212_2.png"].CGImage);
//         layer 实现绘画
//    _sonLayer.contentsCenter =
    
    //    //create a text layer
    //    CATextLayer *textLayer = [CATextLayer layer];
    //    textLayer.frame = self.view.bounds;
    //    [self.view.layer addSublayer:textLayer];
    //
    //    //set text attributes
    //    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    //    textLayer.alignmentMode = kCAAlignmentJustified;
    //    textLayer.wrapped = YES;
    //    textLayer.backgroundColor = [UIColor yellowColor].CGColor;
    //
    //    //choose a font
    //    UIFont *font = [UIFont systemFontOfSize:15];
    //
    //    //set layer font
    //    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    //    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    //    textLayer.font = fontRef;
    //    textLayer.fontSize = font.pointSize;
    //    CGFontRelease(fontRef);
    //
    //    //choose some text
    //    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \ elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \ leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \ fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \ lobortis";
    //
    //    //set layer text
    //    textLayer.string = text;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
