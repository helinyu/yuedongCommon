//
//  ViewController.m
//  YDProgressView
//
//  Created by Aka on 2017/9/1.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "YDBase1ViewController.h"
#import "YDBaseSliderController.h"
#import "YDSliderViewController.h"
#import "XHFloatWindow.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, retain) NSArray *dataSources;

@end

static NSString *const reuseCellIdentifier = @"reuse.cell.identifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self baseInit];
    
    
    [self testHover];
}

- (void)testHover {
    [XHFloatWindow xh_addWindowOnTarget:self onClick:^{
        NSLog(@"Floating button clicked!!!");
    }];
}

- (void)baseInit {
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseCellIdentifier];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _dataSources = @[@"基础属性设置,progress",@"slider 的设置",@"重写slider"];
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = _dataSources[indexPath.row];
    return cell;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            NSLog(@"test");
            [self.navigationController pushViewController:[YDBase1ViewController new] animated:YES];
        }
            break;
        case 1:
            [self.navigationController pushViewController:[YDBaseSliderController new] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[YDSliderViewController new] animated:YES];
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
