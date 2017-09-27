//
//  YDCircleThemeViewController.m
//  SportsBar
//
//  Created by 颜志浩 on 16/12/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDCircleThemeViewController.h"
#import "YDBaseTableView.h"
#import "YDOriginCircleMgr.h"
#import "YDCircleSubThemeModel.h"
#import "YDSubThemeCell.h"
#import "YDCircleArticleListViewController.h"
#import "YDCircleTopicViewController.h"

static NSString *const kSubThemeCell = @"kSubThemeCell";
static const CGFloat kCellHeight = 112;
@interface YDCircleThemeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray<YDCircleSubThemeModel *> *subThemeModelInfos;
@property (nonatomic,   weak) YDBaseTableView *tableView;

@end

@implementation YDCircleThemeViewController



#pragma mark - initialize and dealloc

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

#pragma mark - framework init
- (instancetype)initWithThemeId:(NSNumber *)themeId title:(NSString *)title {
    self = [super init];
    if (self) {
        _themeId = themeId;
        self.navTitle = title;
    }
    return self;
}

/**
 *  create subviews
 */
- (void)msComInit {
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.tableView == nil) {
        YDBaseTableView *tableView = [[YDBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:tableView];
        self.tableView = tableView;
    }
    
    [self yd_navBarInitWithStyle:YDNavBarStyleGray];
    [super msComInit];
    [self createViewConstraints];
}

/**
 *  create constraints
 */
- (void)createViewConstraints {
    
    if (self.tableView) {
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(YDTopLayoutH);
            make.left.right.bottom.equalTo(self.view);
        }];
    }
    [super createViewConstraints];
}

/**
 *  notification bind & touch events bind & delegate bind
 */
- (void)msBind {
    [super msBind];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

/**
 *  data init
 */
- (void)msDataInit {
    [super msDataInit];
    [self net_getSubTheme];
}

/**
 *  static style
 */
- (void)msStyleInit {
    [super msStyleInit];
    self.navBar.topItem.title = MSLocalizedString(self.navTitle, nil);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView registerClass:[YDSubThemeCell class] forCellReuseIdentifier:kSubThemeCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, YDTabBarH, 0);
}

/**
 *  language init
 */
- (void)msLangInit {
    [super msLangInit];
    
}

#pragma mark - life cycle

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

#pragma mark - network request
- (void)net_getSubTheme {
    __weak typeof(self) weakSelf = self;
    [[YDOriginCircleMgr sharedMgr] net_getSubThemeWithUserId:[YDAppInstance userId] themeId:self.themeId then:^(NSArray<YDCircleSubThemeModel *> *infos, MSError *error) {
        if (error) {
            [weakSelf yd_popMsg:error.msg ? : @"未知错误"];
            return ;
        }
        weakSelf.subThemeModelInfos = infos;
        [weakSelf.tableView reloadData];
        
    }];
}

#pragma mark - network notification

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.subThemeModelInfos.count ? self.subThemeModelInfos.count : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDSubThemeCell *cell = (YDSubThemeCell *)[tableView dequeueReusableCellWithIdentifier:kSubThemeCell];
    cell.subThemeModel = self.subThemeModelInfos[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 12;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_V0, 12)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *eventStr = [NSString stringWithFormat:@"%@_%@", self.navTitle, @(indexPath.item)];
    [[YDStatisticsMgr sharedMgr] eventCircleTopicItemClickWithTag:eventStr];
    
    YDCircleSubThemeModel *model = self.subThemeModelInfos[indexPath.section];
    if (model.subThemeType.integerValue == 0) {         //话题
        YDCircleTopicViewController *Vc = [[YDCircleTopicViewController alloc] initWithSubThemeId:model.subThemeId navTitle:model.subThemeTitle];
        [self.navigationController pushViewController:Vc animated:YES];
    }
    if (model.subThemeType.integerValue == 2) {         //文章
        YDCircleArticleListViewController *Vc = [[YDCircleArticleListViewController alloc] initWithSubThemeId:model.subThemeId navTitle:model.subThemeTitle];
        [self.navigationController pushViewController:Vc animated:YES];
    }
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

#pragma mark - custom function


#pragma mark - LazyLoad

- (NSArray<YDCircleSubThemeModel *> *)subThemeModelInfos {
    if (_subThemeModelInfos == nil) {
        _subThemeModelInfos = [NSArray array];
    }
    return _subThemeModelInfos;
}

@end
