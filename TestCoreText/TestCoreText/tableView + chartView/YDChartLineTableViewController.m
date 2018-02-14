//
//  YDChartLineTableViewController.m
//  TestCoreText
//
//  Created by mac on 13/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDChartLineTableViewController.h"
#import "YDChartlineViewTCell.h"
#import "YDChartLineModel.h"

@interface YDChartLineTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *originDatas;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation YDChartLineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YDChartLineModel *oi0 = [YDChartLineModel new];
    oi0.dotPoint = 0.2;
    oi0.detaNum = 3; // 暂时将index作为增加的个数（中间有多少个数目）
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
            item.beginPoint =item.dotPoint -detaH/2.f;
        }
        else {
            NSInteger num = item.detaNum + 1;
            YDChartLineModel *nextItem = _originDatas[nextIndex];
            detaH = (nextItem.dotPoint - item.dotPoint)/num;
            if (index ==0) {
                item.endPoint = item.dotPoint + detaH/2.f;
            }
            else {
                item.endPoint = item.dotPoint + detaH/2.f;
                item.beginPoint = item.dotPoint - detaH/2.f;
            }
            for (NSInteger innerIndex = 0; innerIndex <num; innerIndex++) {
                YDChartLineModel *lastItem = _datas.lastObject; // alway has
                YDChartLineModel *innerItem = [YDChartLineModel new];
                innerItem.hasDot = NO;
                innerItem.index = allIndex;
                innerItem.beginPoint = lastItem.endPoint;
                innerItem.endPoint = innerItem.beginPoint +detaH;
                innerItem.timeText =[NSString stringWithFormat:@"%zd月",allIndex];
                [_datas addObject:innerItem];
                allIndex ++;
            }
        }
    }
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_tableView registerClass:[YDChartlineViewTCell class] forCellReuseIdentifier:NSStringFromClass([YDChartlineViewTCell class])];
    _tableView.dataSource = self;
    _tableView.delegate  = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDChartlineViewTCell *cell =  [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YDChartlineViewTCell class]) forIndexPath:indexPath];
    YDChartLineModel *item = _datas[indexPath.row];
    cell.timeText = item.timeText;
    if (item.hasDot && (indexPath.row ==0 || indexPath.row ==(_datas.count-1))) {
        cell.dotPoint = item.dotPoint;
        if (indexPath.row == 0) {
            [cell configureDotPoint:item.dotPoint oneOfDoubleEndPoint:item.endPoint isStart:YES];
        }
        else {
            [cell configureDotPoint:item.dotPoint oneOfDoubleEndPoint:item.beginPoint isStart:NO];
        }
    }else {
        [cell configureStartPoint:item.beginPoint endPoint:item.endPoint];
    }
    return cell;
}

@end
