//
//  ViewController.m
//  test
//
//  Created by felix on 2017/5/6.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "ViewController.h"
#import "TestPageViewController.h"
#import "VCPresentTransitionViewController.h"
#import "VCNavPushingViewController.h"
#import "VCCicleAnimationViewController.h"
#import "SecondViewController.h"
#import "CircleExtentionAnimationViewController.h"
#import "OfflineDetailViewController.h"
#import "MeMainViewController.h"
#import "CircleAnimationViewController.h"
#import "MainStoryboardViewController.h"
#import "LYBluetoothViewController.h"
//#import "YDDynamicBarViewController.h"
#import "LYReVealToolViewController.h"
#import "LYTransitionViewController.h"
#import "LYPresentViewController.h"
#import "LYNewViewController.h"
#import "LYThirdAnimationViewController.h"
#import "LyFourthAnimationViewController.h"
#import "HLYCaShapeLayerViewController.h"
#import "HLYTableViewController.h"
#import "HLYTableViewViewController.h"
#import "HLYScrollViewController.h"
#import "HLYCategoryViewController.h"
#import "HLYMineViewcontroller.h"
#import "HLYMIneTAbleViewController.h"
#import "HLYCollectionViewController.h"
#import "HLYTableCollectionViewController.h"
#import "HLYShadownViewController.h"
#import "HLYRedTextTipViewController.h"
#import "HLYAudioViewController.h"
#import "HLYBackDropController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"所有实例列表";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 69, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)-69)];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    MainStoryboardViewController *mainStoryVC = [[UIStoryboard storyboardWithName:@"storyboard" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([MainStoryboardViewController class])];
    
    self.dataSource = @[
                        @[@"背景相册选择",[HLYBackDropController new]],
                        @[@"audio player ",[HLYAudioViewController new]],
                        @[@"显示红色文案",[HLYRedTextTipViewController new]],
                        @[@"设置阴影",[HLYShadownViewController new]],
                        @[@"tabel collection view ",[HLYTableCollectionViewController new]],
                        @[@"collectionl view ",[HLYCollectionViewController new]],
                        @[@"我的主页进行设置",[HLYMIneTAbleViewController new]],
                        @[@"collection view",[HLYMineViewcontroller new]],
                        @[@"category 的内容",[HLYCategoryViewController new]],
                        @[@"HLYScrollViewController 和content offset inset",[HLYScrollViewController new]],
                        @[@"tableView scrollview 上的contentVeiw 和content offset inset",[HLYTableViewViewController new]],
                        @[@"tableView 修改悦动首页上面的数据显示动画",[HLYTableViewController new]],
                        @[@"presenting 转场动画",[VCPresentTransitionViewController new]],
                        @[@"pushing 转场动画",[VCNavPushingViewController new]],
                        @[@"present 转场动画",[LYPresentViewController new]],
                        @[@"cicle animation 转场动画",[SecondViewController new]],
                        @[@"⭕️扩展效果动画",[CircleExtentionAnimationViewController new]],
                        @[@"高德地图获取的列表",[OfflineDetailViewController new]],
                        @[@"我的主页",[MeMainViewController new]],
                        @[@"字体倒计时",[CircleAnimationViewController new]],
                        @[@"storyboard 的测试",mainStoryVC],
                        @[@"蓝牙测试 的测试",[LYBluetoothViewController new]],
//                        @[@"动画测试",[YDDynamicBarViewController new]],
                        @[@"reveal 工具可用于ios7",[LYReVealToolViewController new]],
                        @[@"悦动圈上的转产动画",[LYTransitionViewController new]],
                        @[@"新的方式进行处理动画过程",[LYNewViewController new]],
                        @[@"ios 6以及ios5之前的转场方式",[LYThirdAnimationViewController new]],
                        @[@"ios 7 动画自定义",[LyFourthAnimationViewController new]],
                        @[@"CAShapeLayer 进行画动画",[HLYCaShapeLayerViewController new]]
                        ];
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row][0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:self.dataSource[indexPath.row][1] animated:true];
    
}

@end
