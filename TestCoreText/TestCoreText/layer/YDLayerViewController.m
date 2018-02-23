//
//  YDLayerViewController.m
//  TestCoreText
//
//  Created by mac on 14/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDLayerViewController.h"
#import "YDChartLineModel.h"
#import "YDLayerCellView.h"
#import <QuartzCore/QuartzCore.h>

@interface YDLayerViewController ()<YDLayerCellViewDelegate>

@property (nonatomic, strong) NSArray *originDatas;
@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) YDLayerCellView *scrollView;

//@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YDLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self data0];
    [self view0];
    [self updateView];
}

- (void)updateView {
    [_scrollView reloadData];
}

- (void)view0 {
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollView = [YDLayerCellView new];
    _scrollView.frame = CGRectMake(0, 64.f, self.view.bounds.size.width, self.view.bounds.size.height -64.f);
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width *2, 200.f);
    _scrollView.backgroundColor = [UIColor yellowColor];
    [_scrollView registerClass:[YDLayerCell class] forCellReuseIdentifier:NSStringFromClass([YDLayerCell class])];
    _scrollView.layerCellDelegate = self;
    [self.view addSubview:_scrollView];
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

- (CGFloat)widthOfLayerCell {
    return 80.f;
}

- (YDLayerCell *)layerCellView:(YDLayerCellView *)layerCellView indexPath:(NSIndexPath *)indexPath {
    YDLayerCell *cell = [layerCellView  dequeueReusableCellWithIdentifier:NSStringFromClass([YDLayerCell class]) forIndexPath:indexPath];
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

- (NSInteger)numberOfCell {
    return _datas.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// scroll view delegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"gh- scrollViewDidScroll : %f",scrollView.contentOffset.x);
//}

@end
