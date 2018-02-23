//
//  YDTest23ViewController.m
//  TestCoreText
//
//  Created by mac on 23/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTest23ViewController.h"

#import "YDHorizontalTableView.h"
#import "YDHorizontalBaseViewCell.h"
#import "YDHorizontalBaseLayerCell.h"
//#import "YDChartLayerCell.h"
#import "YDLayerCell.h"
#import "YDChartLineModel.h"

static NSString *const kViewCellIdentifier = @"k.view.cell.identifier";
static NSString *const kLayerCellIdentifier = @"k.layer.cell.identifier";

@interface YDTest23ViewController ()<YDHorizontalTableViewDataSource>

@property (nonatomic, strong) YDHorizontalTableView *tableView;

@property (nonatomic, strong) NSArray *originDatas;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation YDTest23ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self data0];

    [self test0];
//    [self test1];
}

- (void)test1 {
    _tableView = [[YDHorizontalTableView alloc] initWithFrame:CGRectMake(0, 64.f, self.view.bounds.size.width, self.view.bounds.size.height -64.f)];
    _tableView.cellType = YDHorizontalTableViewCelltypeLayer;
    [_tableView registerClass:[YDLayerCell class] forCellReuseIdentifier:kLayerCellIdentifier];
    _tableView.dataSource = self;
    [_tableView reloadData];
    [self.view addSubview:_tableView];
}

- (void)data0 {
    YDChartLineModel *oi0 = [YDChartLineModel new];
    oi0.dotPoint = 0.2;
    oi0.detaNum = 3;
    YDChartLineModel *oi1 = [YDChartLineModel new];
    oi1.dotPoint = 0.5;
    oi1.detaNum = 4;
    YDChartLineModel *oi2 = [YDChartLineModel new];
    oi2.dotPoint = 0.8;
    oi2.detaNum = 6;
    YDChartLineModel *oi3 = [YDChartLineModel new];
    oi3.dotPoint = 0.1;
    oi3.detaNum = 1;
    YDChartLineModel *oi4 = [YDChartLineModel new];
    oi4.dotPoint = 0.7;
    oi4.detaNum = 5;
    YDChartLineModel *oi5 = [YDChartLineModel new];
    oi5.dotPoint = 0.5;
    oi5.detaNum = 6;
    YDChartLineModel *oi6 = [YDChartLineModel new];
    oi6.dotPoint = 0.3;
    oi6.detaNum = 2;
    _originDatas = @[oi0, oi1, oi2, oi3, oi4, oi5, oi6];
    
    _datas = @[].mutableCopy;
    NSInteger allIndex =0;
    CGFloat detaH = 0.f;
    for (NSInteger index =0; index < _originDatas.count; index++) {
        YDChartLineModel *originItem = _originDatas[index];
        YDChartLineModel *item = [YDChartLineModel new];
        item.hasDot = YES;
        item.index = allIndex;
        item.detaNum = originItem.detaNum;
        item.dotPoint = originItem.dotPoint;
        item.dotText = [NSString stringWithFormat:@"%f",item.dotPoint];
        item.timeText =[NSString stringWithFormat:@"%zd月",allIndex];
        [_datas addObject:item];
        allIndex++;
        NSInteger nextIndex = index +1;
        if (nextIndex >= _originDatas.count) {
            item.beginPoint = item.dotPoint -detaH/2.f;
        }
        else {
            NSInteger num = item.detaNum + 1;
            YDChartLineModel *nextItem = _originDatas[nextIndex];
            if (index !=0) {
                item.beginPoint = item.dotPoint - detaH/2.f;
            }
            CGFloat allDetalH = nextItem.dotPoint - item.dotPoint;
            detaH = allDetalH/num;
            if (index ==0) {
                item.endPoint = item.dotPoint + detaH/2.f;
            }
            else {
                item.endPoint = item.dotPoint + detaH/2.f;
            }
            for (NSInteger innerIndex = 0; innerIndex <item.detaNum; innerIndex++) {
                YDChartLineModel *lastItem = _datas.lastObject; // alway has
                YDChartLineModel *innerItem = [YDChartLineModel new];
                innerItem.hasDot = NO;
                innerItem.index = allIndex;
                innerItem.beginPoint = lastItem.endPoint;
                innerItem.endPoint = innerItem.beginPoint +detaH;
                innerItem.timeText = [NSString stringWithFormat:@"%zd月",allIndex];
                [_datas addObject:innerItem];
                allIndex ++;
            }
        }
    }
}

- (void)test0 {
    _tableView = [[YDHorizontalTableView alloc] initWithFrame:CGRectMake(0, 64.f, self.view.bounds.size.width, self.view.bounds.size.height)];
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [_tableView registerClass:[YDHorizontalBaseViewCell class] forCellReuseIdentifier:kViewCellIdentifier];
    [_tableView reloadData];
    [self.view addSubview:_tableView];
}

#pragma mark -- delegate

- (NSInteger)numberOfRows {
    return _datas.count;
//    return 20;
}

- (CGFloat)widthOfRow {
    return 80.f;
}

- (YDHorizontalBaseViewCell *)horizontalTableView:(YDHorizontalTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDHorizontalBaseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kViewCellIdentifier indexPath:indexPath];
   cell.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1.0];
    cell.indexLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}

- (YDLayerCell *)horizontalLayerTableView:(YDHorizontalTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDLayerCell *cell = (YDLayerCell *)[tableView  dequeueReusableLayerCellWithIdentifier:kLayerCellIdentifier indexPath:indexPath];
    cell.backgroundColor = [UIColor redColor].CGColor;
    YDChartLineModel *item = _datas[indexPath.row];
    if (item.hasDot) {
        if (indexPath.row ==0) {
            [cell configureDotPoint:item.dotPoint oneOfDoubleEndPoint:item.endPoint isStart:YES];
        }
        else if ((_datas.count -1)==indexPath.row){
            [cell configureDotPoint:item.dotPoint oneOfDoubleEndPoint:item.beginPoint isStart:NO];
        }
        else {
            [cell configureDotPoint:item.dotPoint startPoint:item.beginPoint endPoint:item.endPoint];
        }
    }else {
        [cell configureStartPoint:item.beginPoint endPoint:item.endPoint];
    }
    [cell configureWithDate:[NSString stringWithFormat:@"%@",item.timeText] dotPoint:item.dotPoint];
    return cell;
}


@end
