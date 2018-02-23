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

static NSString *const kViewCellIdentifier = @"k.view.cell.identifier";
static NSString *const kLayerCellIdentifier = @"k.layer.cell.identifier";

@interface YDTest23ViewController ()<YDHorizontalTableViewDataSource>

@property (nonatomic, strong) YDHorizontalTableView *tableView;

@end

@implementation YDTest23ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[YDHorizontalTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _tableView.dataSource = self;
    [_tableView registerClass:[YDHorizontalBaseViewCell class] forCellReuseIdentifier:kViewCellIdentifier];
    [_tableView reloadData];
    [self.view addSubview:_tableView];
}

#pragma mark -- delegate

- (NSInteger)numberOfRows {
    return 100;
}

- (CGFloat)widthOfRow {
    return 50.f;
}

- (YDHorizontalBaseViewCell *)horizontalTableView:(YDHorizontalTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDHorizontalBaseViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kViewCellIdentifier indexPath:indexPath];
   cell.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1.0];
    cell.indexLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}

@end
