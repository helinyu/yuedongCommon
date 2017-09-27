//
//  YDCircleTopicViewController.m
//  SportsBar
//
//  Created by 颜志浩 on 16/12/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDCircleTopicViewController.h"
#import "YDBaseTableView.h"
#import "YDOriginCircleMgr.h"
#import "YDHotTopicModel.h"
#import "YDCircleTopicCell.h"
#import "YDMWebViewController.h"

static NSString *const kCircleTopicCell = @"kCircleTopicCell";
@interface YDCircleTopicViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,   weak) YDBaseTableView *tableView;
@property (nonatomic, strong) NSArray<YDHotTopicModel *> *topicsArray;

/**
 *  当VC disappear 时缓存tableView的contentOffset
 */
@property (nonatomic, assign) CGPoint tableViewContentOffset;
@end

@implementation YDCircleTopicViewController

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

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
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
        [wSelf net_getSubThemeTopicWithOffset:@0];
    };
    self.tableView.footerRefreshHandler = ^{
        [wSelf net_getSubThemeTopicWithOffset:@(self.topicsArray.count)];
    };
    self.tableView.headerRefreshEnable = YES;
    self.tableView.footerRefreshEnable = YES;
}

/**
 *  data init
 */
- (void)msDataInit {
    [super msDataInit];
    if (self.topicsArray.count == 0) {
    [self net_getSubThemeTopicWithOffset:@0];
    }
}

/**
 *  static style
 */
- (void)msStyleInit {
    [super msStyleInit];
    self.navBar.topItem.title = MSLocalizedString(self.navTitle, nil);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView registerClass:[YDCircleTopicCell class] forCellReuseIdentifier:kCircleTopicCell];
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
    if (self.tableView != nil && (self.tableViewContentOffset.x != 0 || self.tableViewContentOffset.y != 0)) {
        self.tableView.contentOffset = self.tableViewContentOffset;
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tableViewContentOffset = self.tableView.contentOffset;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - network request
- (void)net_getSubThemeTopicWithOffset:(NSNumber *)offset {
    __weak typeof(self) wSelf = self;
    [[YDOriginCircleMgr sharedMgr] net_getSubThemeTopicWithUserId:[YDAppInstance userId] subThemeId:self.subThemeId offset:offset then:^(NSArray<YDHotTopicModel *> *articles, MSError *error) {
        if (error) {
            [wSelf yd_popMsg:error.msg ? : @"未知错误"];
            return ;
        }
        if (!error) {
            if (!offset.integerValue) {
                wSelf.topicsArray = articles;
            } else {
                if (articles.count) {
                    wSelf.topicsArray = [wSelf.topicsArray arrayByAddingObjectsFromArray:articles];
                }
            }

        }
        if ([wSelf.tableView.mj_header isRefreshing]) {
            [wSelf.tableView.mj_header endRefreshing];
        }
        if ([wSelf.tableView.mj_footer isRefreshing]) {
            [wSelf.tableView.mj_footer endRefreshing];
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - network notification

#pragma UITableViewDataSource UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicsArray.count ? self.topicsArray.count : 0;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    BOOL hasDisplayed;
    YDHotTopicModel *model = self.topicsArray[indexPat.row];
    if (!model.hasDisplayed) {
        hasDisplayed = NO;
        model.hasDisplayed = YES;
    } else {
        hasDisplayed = YES;
    }
    if (!hasDisplayed) {
        cell.alpha = 0;
        [UIView animateWithDuration:0.375 animations:^{
            cell.alpha = 1;
        }];
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        YDCircleTopicCell *kCell =(YDCircleTopicCell *)[tableView dequeueReusableCellWithIdentifier:kCircleTopicCell];
        kCell.model = self.topicsArray[indexPath.row];
        __weak typeof(kCell) topicCell = kCell;
        kCell.userFollowAction = ^(NSNumber *userId, NSNumber *followUserId){
            [[YDStatisticsMgr sharedMgr] eventCircleFollowAction];
            [[YDOriginCircleMgr sharedMgr] net_userFollowWithUserId:userId followUserId:followUserId then:^(id response, MSError *error) {
                if (!error) {
                    topicCell.followBtn.hidden = YES;
                }
            }];
        };
        kCell.userLikeAction = ^(){
            [[YDStatisticsMgr sharedMgr] eventCircleLikeOperation];
            YDTopicLikeFlag likeFlag;
            if (topicCell.model.likeFlag.integerValue == 0) {
                likeFlag = YDTopicLikeFlagLike;
            } else {
                likeFlag = YDTopicLikeFlagCancleLike;
            }
            [[YDOriginCircleMgr sharedMgr] net_operateTopicWithUserId:[YDAppInstance userId] topicId:@(topicCell.model.topicId) likeFlag:likeFlag then:^(id response, MSError *error) {
                if (!error) {
                    if (topicCell.model.likeFlag.integerValue == 0) {
                        topicCell.model.likeFlag = @1;            //点赞成功
                        topicCell.model.likeCnt += 1;
                        [topicCell.likeButton setImage:[UIImage imageNamed:@"icon_origin_circle_like"] forState:UIControlStateNormal];
                        NSString *likeCountString = [NSString stringWithFormat:@"%ld",topicCell.model.likeCnt];
                        topicCell.likeCountLabel.text = likeCountString;
                        //添加动画
                        topicCell.likeAnimationLabel.alpha = 1.0;
                        CGRect frame = topicCell.likeAnimationLabel.frame;
                        [UIView animateWithDuration:0.5 animations:^{
                            topicCell.likeAnimationLabel.frame = CGRectMake(frame.origin.x + 10, frame.origin.y - 10, frame.size.width, frame.size.height);
                            topicCell.likeAnimationLabel.alpha = 0;
                        } completion:^(BOOL finished) {
                            topicCell.likeAnimationLabel.frame = frame;
                        }];
                        
                    } else {
                        topicCell.model.likeFlag = @0;            //取消赞成功
                        if (topicCell.model.likeCnt != 0) {
                            topicCell.model.likeCnt -= 1;
                        }
                        [topicCell.likeButton setImage:[UIImage imageNamed:@"icon_origin_circle_not_like"] forState:UIControlStateNormal];
                        NSString *likeCountString = [NSString stringWithFormat:@"%ld",topicCell.model.likeCnt];
                        topicCell.likeCountLabel.text = likeCountString;
                    }
                }
            }];
        };
        kCell.selectionStyle = UITableViewCellSelectionStyleGray;
    return kCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.topicsArray[indexPath.row].height;
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
    YDHotTopicModel *model = self.topicsArray[indexPath.row];
    VC.url = [NSURL yd_URLWithString:model.action];
    [self.navigationController pushViewController:VC animated:YES];
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - custom function

#pragma mark - LazyLoad
- (NSArray<YDHotTopicModel *> *)topicsArray {
    if (_topicsArray == nil) {
        _topicsArray = [NSArray array];
    }
    return _topicsArray;
}
@end
