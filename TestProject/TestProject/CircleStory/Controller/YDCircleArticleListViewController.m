//
//  YDCircleArticleListViewController.m
//  SportsBar
//
//  Created by 颜志浩 on 16/12/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDCircleArticleListViewController.h"
#import "YDBaseTableView.h"
#import "YDOriginCircleMgr.h"
#import "YDCircleThemeArticleModel.h"
#import "YDCircleSubThemeArticleCell.h"
#import "YDMWebViewController.h"
#import "YDCircleThemeArticleInfos.h"

static NSString *const kSubThemeArticleCell = @"kSubThemeArticleCell";
static const CGFloat kCellHeight = 101.f;
@interface YDCircleArticleListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,   weak) YDBaseTableView *tableView;
@property (nonatomic, strong) NSNumber *subThemeId;
@property (nonatomic,   copy) NSString *navTitle;
@property (nonatomic, strong) NSArray<YDCircleThemeArticleModel *> *articleInfos;

@end

@implementation YDCircleArticleListViewController


#pragma mark - initialize and dealloc

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

#pragma mark - framework init

- (instancetype)initWithSubThemeId:(NSNumber *)subThemeId navTitle:(NSString *)navTitle {
    self = [super init];
    if (self) {
        _subThemeId = subThemeId;
        self.navTitle = navTitle;
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
    
    __weak typeof(self) wSelf = self;
    self.tableView.headerRefreshHandler = ^{
        [wSelf net_getSubThemeArticleWithOffset:@0];
    };
    self.tableView.footerRefreshHandler = ^{
        [wSelf net_getSubThemeArticleWithOffset:self.articleInfos.count ? @(self.articleInfos.count) : @0];
    };
    self.tableView.headerRefreshEnable = YES;
    self.tableView.footerRefreshEnable = YES;

}

/**
 *  data init
 */
- (void)msDataInit {
    [super msDataInit];
    [self net_getSubThemeArticleWithOffset:@0];
}

/**
 *  static style
 */
- (void)msStyleInit {
    [super msStyleInit];
    self.navBar.topItem.title = MSLocalizedString(self.navTitle, nil);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView registerClass:[YDCircleSubThemeArticleCell class] forCellReuseIdentifier:kSubThemeArticleCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
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
- (void)net_getSubThemeArticleWithOffset:(NSNumber *)offset {
    __weak typeof(self) wSelf = self;
    [[YDOriginCircleMgr sharedMgr] net_getSubThemeArticleWithUserId:[YDAppInstance userId] subThemeId:self.subThemeId offset:offset then:^(YDCircleThemeArticleInfos *infos, MSError *error) {
        if (error) {
            [wSelf yd_popMsg:error.msg ? : @"未知错误"];
            return ;
        }
        if (!error) {
            if (offset.integerValue == 0) {
                self.articleInfos = infos.infos;
            } else {
                if (infos.infos.count) {
                    self.articleInfos = [self.articleInfos arrayByAddingObjectsFromArray:infos.infos];
                }
            }
            if ([wSelf.tableView.mj_header isRefreshing]) {
                [wSelf.tableView.mj_header endRefreshing];
            }
            if ([wSelf.tableView.mj_footer isRefreshing]) {
                [wSelf.tableView.mj_footer endRefreshing];
            }
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - network notification

#pragma UITableViewDataSource UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articleInfos.count ? self.articleInfos.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YDCircleSubThemeArticleCell *cell = (YDCircleSubThemeArticleCell *)[tableView dequeueReusableCellWithIdentifier:kSubThemeArticleCell];
    cell.model = self.articleInfos[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DEVICE_HEIGHT_OF(kCellHeight);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YDMWebViewController *VC = [[YDMWebViewController alloc] init];
    YDCircleThemeArticleModel *model = self.articleInfos[indexPath.row];
    VC.url = [NSURL yd_URLWithString:model.action];
    [self.navigationController pushViewController:VC animated:YES];
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - custom function

#pragma mark - LazyLoad

- (NSArray<YDCircleThemeArticleModel *> *)articleInfos {
    if (_articleInfos == nil) {
        _articleInfos = [NSArray array];
    }
    return _articleInfos;
}

@end
