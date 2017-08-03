//
//  HLYBackDropController.m
//  test
//
//  Created by felix on 2017/6/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYBackDropController.h"
#import "HLYBackDropMgr.h"
#import "HLYBackDropOnlineViewController.h"

@interface HLYBackDropController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *const backDropCellIndentifier = @"backDropCellIndentifier";

static const NSInteger tabBarH = 64.f;

@implementation HLYBackDropController


#pragma mark - property init

#pragma mark - initialize and dealloc

#pragma mark - framework init

/**
 *  create subviews
 */
- (void)msComInit {
    
    [super msComInit];
    // com create without constraints ...
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tabBarH, SCREEN_WIDTH, SCREEN_HEIGHT - tabBarH) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:backDropCellIndentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self createViewConstraints];
}

/**
 *  create constraints
 */
- (void)createViewConstraints {
    [super createViewConstraints];
    
    //.... create constraints for compoment which has created
}

/**
 *  notification bind & touch events bind & delegate bind
 */
- (void)msBind {
    [super msBind];
}

/**
 *  data init
 */
- (void)msDataInit {
    [super msDataInit];
    
    [[HLYBackDropMgr shareInstance] initPictureSourcesCategories];
}

/**
 *  static style
 */
- (void)msStyleInit {
    [super msStyleInit];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"更换背景";
}

/**
 *  language init
 */
- (void)msLangInit {
    [super msLangInit];
}

#pragma mark - life cycle not need to change nomal

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - override

#pragma mark - custom function

#pragma mark - event action

#pragma mark - network request

#pragma mark - network notification

#pragma mark - delegate

#pragma mark -- tableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [HLYBackDropMgr shareInstance].pictureSourcesCategories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rowContents = [HLYBackDropMgr shareInstance].pictureSourcesCategories[section];
    return rowContents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:backDropCellIndentifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *rowCotnents = [HLYBackDropMgr shareInstance].pictureSourcesCategories[indexPath.section];
    cell.textLabel.text = rowCotnents[indexPath.row];
    UIView *selectedBg = [[UIView alloc] initWithFrame:cell.bounds];
    selectedBg.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = selectedBg;
    return cell;
}

#pragma mark --table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView reloadData];

    switch (indexPath.row + indexPath.section *10) {
        case HLYSourceTypeOnline:
        {
            HLYBackDropOnlineViewController *vc = [HLYBackDropOnlineViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case HLYSourceTypeAlbum:
        {
            
        }
            break;
        case HLYSourceTypeCamera:
        {
            
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 14.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

@end
