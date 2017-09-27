//
//  YDCircleRootViewController.m
//  SportsBar
//
//  Created by 颜志浩 on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "YDCircleRootViewController.h"
#import "MSUtil.h"
#import "YDOriginCircleMgr.h"
#import "YDAdMgr.h"

#import "SDCycleScrollView.h"
#import "YDCircleSectionHeader.h"
#import "YDCircleGuideView.h"
#import "YDCircleBannerView.h"
#import "YDBaseCollectionView.h"
#import "YDCircleAdCell.h"

#import "YDCircleTopicItem.h"
#import "YDCircleLiveImgCell.h"
#import "YDCircleActivityItem.h"
#import "YDCircleItem.h"
#import "YDCircleChoicenessItem.h"
#import "YDTopicRecommendCell.h"

#import "YDHotTopicModel.h"
#import "YDUserCirclesModel.h"
#import "YDCircleBannerModel.h"
#import "YDCircleBannerInfo.h"
#import "YDActivityModel.h"
#import "YDOriginCircleModel.h"
#import "YDCircleThemeModel.h"
#import "YDUserModel.h"
#import "YDCircleSectionModel.h"
#import "YDTopicRecommendInfo.h"

#import "YDCircleThemeViewController.h"
#import "YDLivingHomeListViewController.h"

#import "YDBadgeMgr.h"
#import "YDBadgeModel.h"
#import "UIView+WZLBadge.h"

static NSString *const kTopicCell = @"kTopicCell";
static NSString *const kRecommendCell = @"kRecommendCell";
static NSString *const kCircleCell = @"kCircleCell";
static NSString *const kLiveCell = @"kLiveCell";
static NSString *const kActivityCell = @"kActivityCell";
static NSString *const kChoicenessCell = @"kChoicenessCell";
static NSString *const kNullCell = @"kNullCell";

static NSString *const kSectionHeader = @"kSectionHeader";
static NSString *const kSectionBanner = @"kSectionBanner";
static NSString *const kSectionFooter = @"kSectionFooter";
static NSString *const kAdCellId = @"yd.circle.ad.cell.id";

static const CGFloat kSectionHeaderH = 32;

typedef NS_ENUM(NSInteger, YDCircleCellSection) {
    YDCircleCellSectionBanner,
    YDCircleCellSectionCircle,
    YDCircleCellSectionLive,
    YDCircleCellSectionActivity,
    YDCircleCellSectionChoiceness,
    YDCircleCellSectionTopic,
};
@interface YDCircleRootViewController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    
}
/**
 *  圈子引导
 */
@property (nonatomic,   weak) YDCircleGuideView *guideView;
// 圈子引导页面YDTopicRecommendInfo

@property (nonatomic,   weak) UIImageView *backgroundImageView;
@property (nonatomic,   weak) YDBaseCollectionView *collectionView;
@property (nonatomic, strong) YDOriginCircleMgr *mgr;
@property (nonatomic, strong) YDUserCirclesModel *circlesModel;

//------ collectionView ----//
@property (nonatomic, strong) YDCircleBannerView *banner; 

@property (nonatomic, assign) BOOL completReqeust;
@property (nonatomic, assign) BOOL pleaseRequest;

@property (nonatomic, assign) BOOL choicenessCellHasDisplayed;
@property (nonatomic, assign) BOOL liveCellHasDisplayed;
@property (nonatomic, assign) BOOL networkError;


/**
 *  当VC disappear 时缓存tableView的contentOffset
 */
@property (nonatomic, assign) CGPoint collectionViewContentOffset;
@end

@implementation YDCircleRootViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
//     设置样式
    self.showMode = YDVCShowModeTabBar;
    self.automaticallyAdjustsScrollViewInsets = NO;//关闭自定义下移20
    self.view.backgroundColor = RGB(245, 245, 245);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSNumber *jumpKind = [[NSUserDefaults standardUserDefaults] objectForKey:@"jump_kind"];
        if (jumpKind != nil) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ChooseIndex" object:@0];
        }
    });
    
//    恢复原来的位置
    if (self.collectionView != nil && (self.collectionViewContentOffset.x != 0 || self.collectionViewContentOffset.y != 0)) {
        self.collectionView.contentOffset = self.collectionViewContentOffset;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear: animated];
    self.collectionViewContentOffset = self.collectionView.contentOffset;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 * 控件初始化
 */
- (void)msComInit {
//    背景图片
    if (self.backgroundImageView == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        [self.view addSubview:img];
        self.backgroundImageView = img;
    }
    
//    colleciton view 创建
    if (self.collectionView == nil) {
        UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        YDBaseCollectionView *collectionView = [[YDBaseCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:collectionView];
        self.collectionView = collectionView;
    }
    [super msComInit];
    [self createViewConstraints];
}

/**
 * 数据初始化
 */
- (void)msDataInit {
    [super msDataInit];
    if (self.mgr == nil) {
        self.mgr = [YDOriginCircleMgr sharedMgr];
    }
    self.backgroundImageView.hidden = NO;
    __weak typeof(self) wSelf = self;
    self.collectionView.footerRefreshHandler = ^{
        [wSelf getMoreDataByNetwork];
    };
    
    //使用自定义的下拉动画
    [self.collectionView setHeaderRefreshEnable:YES refreshType:YDScrollViewRefreshTypeGif completeBlock:^{
        [wSelf refreshDataByNetwork];
    }];
    
    self.collectionView.footerRefreshEnable = YES;
    
    self.networkError = NO;
    if (self.mgr.sections.count == 0) {
        [self refreshDataByNetwork];
    } else {
        self.collectionView.backgroundColor = YD_WHITE(1);
        self.backgroundImageView.hidden = YES;
    }
}

/**
 * 事件绑定
 */
- (void)msBind {
    [super msBind];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NetworkStatusChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[YDCircleTopicItem class] forCellWithReuseIdentifier:kTopicCell];
    [self.collectionView registerClass:[YDTopicRecommendCell class] forCellWithReuseIdentifier:kRecommendCell];
    [self.collectionView registerClass:[YDCircleActivityItem class] forCellWithReuseIdentifier:kActivityCell];
    [self.collectionView registerClass:[YDCircleItem class] forCellWithReuseIdentifier:kCircleCell];
    [self.collectionView registerClass:[YDCircleLiveImgCell class] forCellWithReuseIdentifier:kLiveCell];
    [self.collectionView registerClass:[YDCircleChoicenessItem class] forCellWithReuseIdentifier:kChoicenessCell];
    [self.collectionView registerClass:[YDCircleAdCell class] forCellWithReuseIdentifier:kAdCellId];
    [self.collectionView registerClass:[YDCircleBannerView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionBanner];
    [self.collectionView registerClass:[YDCircleSectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionHeader];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kSectionFooter];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kNullCell];
    
}

/**
 * 静态样式初始化
 */
- (void)msStyleInit {
    [super msStyleInit];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.image = [UIImage imageNamed:@"circle_tableview_placehold.jpg"];
    if (self.mgr.sections.count > 0) {
        self.collectionView.backgroundColor = YD_WHITE(1);
        self.collectionView.backgroundView.backgroundColor = YD_WHITE(1);
    } else {
        self.collectionView.backgroundColor = [UIColor clearColor];
        self.collectionView.backgroundView.backgroundColor = [UIColor clearColor];
    }
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(YDTopLayoutH, 0, YDTabBarH - 990, 0);
}

/**
 *  语言初始化
 */
- (void)msLangInit {
    [super msLangInit];
}

- (void)createViewConstraints {
    if (self.collectionView) {
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    
    if (self.backgroundImageView) {
        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(YDTopLayoutH);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
    
    [super createViewConstraints];
}

#pragma mark - Custom Method
- (void)cus_handleLiveDic:(NSDictionary *)liveDic {
    [[YDJumpTool sharedTool] jumpToOpenParam:liveDic fromVC:nil];
}

- (void)cancelGuide {
    [self.guideView removeFromSuperview];
    self.guideView = nil;
}

- (void)jumpToCircleChallenge {
    [self cancelGuide];
    //跳转推荐
    [self handleURLWithURL:self.circlesModel.circleRunGuideUrl];
}

#pragma mark - Network Request
- (void)endMJRefresh {
    if ([self.collectionView.mj_header isRefreshing]) {
        [self.collectionView.mj_header endRefreshing];
    }
    if ([self.collectionView.mj_footer isRefreshing]) {
        [self.collectionView.mj_footer endRefreshing];
    }
}

- (void)reloadCollection {
    self.backgroundImageView.hidden = YES;
    [self.collectionView reloadData];
    self.collectionView.backgroundColor = YD_WHITE(1);
}

- (void)refreshDataByNetwork {
//    [self getBannerInfoWithLoc:@2];
    [self getUserCircleWithCount:@4]; // 这里只是获取4个圈子
    [self net_getLivePhotoWithUserId:[YDAppInstance userId]];  // 获取直播的内容
//    [self net_getHotTheme];  // 获取精选的内容
    [self getHotActivityWithCount:@2]; //热门活动  圈子活动
    [self getCircleHotArticleWithOffset:@0]; //初始化获取文章列表
    [self getAd];
}

// 获取更多的热门文章列表
//这个是获取更多的文章（）
- (void)getMoreDataByNetwork {
    YDCircleSectionModel *sectionModel = [self.mgr.sectionDic objectForKey:@(YDCircleCardModelTypeTopic).stringValue];
    [self getCircleHotArticleWithOffset:@(sectionModel.cards.count)];
}
/**
 *  获取banner信息,
 */
//- (void)getBannerInfoWithLoc:(NSNumber *)loc {
//    __weak typeof(self) wSelf = self;
//    [[YDOriginCircleMgr sharedMgr] getBannerInfoWithUserId:[YDAppInstance userId] loc:loc then:^(YDCircleBannerInfo *model, MSError *error) {
//        [wSelf endMJRefresh];
//        if (error) {
//            wSelf.networkError = YES;
//            [wSelf yd_popMsg:error.msg ? : @"未知错误"];
//            return ;
//        }
//        wSelf.networkError = NO;
//        [wSelf reloadCollection];
//    }];
//}
/**
 *  获取热门话题
 */
#warning -- 获取热门文章 1h
- (void)getCircleHotArticleWithOffset:(NSNumber *)offset {
    __weak typeof(self) wSelf = self;
    [[YDOriginCircleMgr sharedMgr] getCircleHotArticleWithUserId:[YDAppInstance userId] offset:offset version:[YDAppInstance appVersion] isShow:@(1) then:^(id response, MSError *error) {
        [wSelf endMJRefresh];
        
        if (error) {
            wSelf.networkError = YES;
            [wSelf yd_popMsg:error.msg ? : @"未知错误"];
            return ;
        }
        wSelf.networkError = NO;
        [wSelf reloadCollection];
    }];
}
/**
 *  获取我的圈子
 */
#pragma mark -- 圈子逻辑 1h （vc 页面获取） [圈子引导和圈子一起获取的]
- (void)getUserCircleWithCount:(NSNumber *)count {
    self.completReqeust = NO;
    __weak typeof(self) wSelf = self;
    [[YDOriginCircleMgr sharedMgr] getUserCircleWithUserId:[YDAppInstance userId] count:count then:^(id response, MSError *error) {
        [wSelf endMJRefresh];
        if (error) {
            wSelf.networkError = YES;
            [wSelf yd_popMsg:error.msg ? : @"未知错误"];
            return ;
        }
        wSelf.networkError = NO;
        YDUserCirclesModel *model = [MSJsonKit jsonObjToObj:response asClass:[YDUserCirclesModel class]];
        wSelf.circlesModel = model;
//         圈子
        if (model.circleRunGuide.length) {
            //圈子引导 view
            if (wSelf.guideView == nil) {
                YDCircleGuideView *guideView = [[YDCircleGuideView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH_V0, SCREEN_HEIGHT_V0)];
                guideView.backgroundColor = RGBA(0, 0, 0, 0.6);
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:wSelf action:@selector(cancelGuide)];
                [guideView addGestureRecognizer:tap];
                UIWindow * window = [[UIApplication sharedApplication] keyWindow];
                [window addSubview:guideView];
                wSelf.guideView = guideView;
                [wSelf.guideView.button addTarget:wSelf action:@selector(jumpToCircleChallenge) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }];
}
/**
 *  获取精选
 */
#warning --（这个去掉）
//- (void)net_getHotTheme {
//    __weak typeof(self) wSelf = self;
//    [[YDOriginCircleMgr sharedMgr] net_getHotThemeWithUserId:[YDAppInstance userId] then:^(NSArray<YDCircleThemeModel *> *infos, MSError *error) {
//        [wSelf endMJRefresh];
//        if (error) {
//            self.networkError = YES;
//            [wSelf yd_popMsg:error.msg ? : @"未知错误"];
//            return ;
//        }
//        self.networkError = NO;
//        [wSelf reloadCollection];
//    }];
//}

/**
 *  获取热门活动
 */
#warning  -- 热门活动 1h
- (void)getHotActivityWithCount:(NSNumber *)count {
    __weak typeof(self) wSelf = self;
    [[YDOriginCircleMgr sharedMgr] getHotActivityWithUserId:[YDAppInstance userId] count:count then:^(id response, MSError *error) {
        [wSelf endMJRefresh];
        if (error) {
            self.networkError = YES;
            [wSelf yd_popMsg:error.msg ? : @"未知错误"];
            return ;
        }
        self.networkError = NO;
        [wSelf reloadCollection];
    }];
}

/**
 获取直播图片
 */
#warning -- 1h
- (void)net_getLivePhotoWithUserId:(NSNumber *)userId {
    __weak typeof(self) wSelf = self;
    [[YDOriginCircleMgr sharedMgr] net_getCircleLiveTopWithUserId:[YDAppInstance userId] then:^(NSMutableArray<NSString *> *imagesArr, MSError *error) {
        [wSelf endMJRefresh];
        if (error) {
            wSelf.networkError = YES;
            [wSelf yd_popMsg:error.msg ? : @"未知错误"];
            return ;
        }
        wSelf.networkError = NO;
        [wSelf reloadCollection];
    }];
}

/**
 获取广告
 */
// 1h
- (void)getAd {
    if ([YDMembershipMgr isMemberShip]) {
        return;
    }
    __weak typeof(self) wSelf = self;
    [[YDOriginCircleMgr sharedMgr] net_getAd:^(MSError *error) {
        if (!error) {
            [wSelf reloadCollection];
        }
    }];
}


/**
 话题点赞
 */
#warning  -- 话题点赞 3h
- (void)net_operateTopicWithCell:(YDCircleTopicItem *)topicCell likeFlag:(YDTopicLikeFlag)likeFlag {
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
}

#pragma mark - network notification

- (void)NetworkStatusChanged:(NSNotification *)notification {
    NSDictionary * userInfo = notification.userInfo;
    AFNetworkReachabilityStatus status = ((NSNumber *)userInfo[AFNetworkingReachabilityNotificationStatusItem]).integerValue;
    if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
        if (self.networkError) {
            [self refreshDataByNetwork];
        }
    }
}

#pragma mark - UICollectionViewFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.mgr.sections.count || indexPath.item >= self.mgr.sections[indexPath.section].cards.count) {
        return CGSizeZero;
    }
    YDCircleSectionModel *sectionModel = self.mgr.sections[indexPath.section];
    YDCircleCardModel *card = sectionModel.cards[indexPath.item];
    return card.itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section >= self.mgr.sections.count) {
        return UIEdgeInsetsZero;
    }
    YDCircleSectionModel *sectionModel = self.mgr.sections[section];
    switch (sectionModel.sectionType) {
        case YDCircleCardModelTypeActivity:
            return UIEdgeInsetsMake(12, 12, 14, 12);
            break;
        case YDCircleCardModelTypeLive:
            return UIEdgeInsetsMake(10, 12, 12, 12);
        default:
            break;
    }
    
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section >= self.mgr.sections.count) {
        return CGFLOAT_MIN;
    }
    YDCircleSectionModel *sectionModel = self.mgr.sections[section];
    if (sectionModel.sectionType == YDCircleCardModelTypeTopic) {
        return CGFLOAT_MIN;
    } else {
        return 12.f;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section >= self.mgr.sections.count) {
        return CGFLOAT_MIN;
    }
    YDCircleSectionModel *sectionModel = self.mgr.sections[section];
    if (sectionModel.sectionType == YDCircleCardModelTypeLive) {
        return 8.f;
    } else if (sectionModel.sectionType == YDCircleCardModelTypeActivity) {
        return 12.f;
    }
    return CGFLOAT_MIN;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section >= self.mgr.sections.count) {
        return CGSizeZero;
    }
    YDCircleSectionModel *sectionModel = self.mgr.sections[section];
    if (sectionModel.sectionType == YDCircleCardModelTypeBanner) {
        YDCircleCardModel *cardModel = sectionModel.cards.firstObject;
        return CGSizeMake(SCREEN_WIDTH_V0, SCREEN_WIDTH_V0 / cardModel.bannerInfo.whRatio);
    } else {
        return CGSizeMake(SCREEN_WIDTH_V0, kSectionHeaderH);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section >= self.mgr.sections.count) {
        return CGSizeZero;
    }
    YDCircleSectionModel *sectionModel = self.mgr.sections[section];
    if (sectionModel.sectionType == YDCircleCardModelTypeBanner) {
        return CGSizeZero;
    } else if (section == self.mgr.sections.count - 1) {
        return CGSizeMake(SCREEN_WIDTH_V0, 1000);
    } else {
        return CGSizeMake(SCREEN_WIDTH_V0, 12.f);
    }
}
#pragma mark - UICollectionViewDataSource UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.mgr.sections.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section >= self.mgr.sections.count) {
        return 0;
    }
    YDCircleSectionModel *sectionModel = self.mgr.sections[section];
    if (sectionModel.sectionType == YDCircleCardModelTypeBanner) {
        return 0;
    } else {
        return sectionModel.cards.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.mgr.sections.count || indexPath.item >= self.mgr.sections[indexPath.section].cards.count) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:kNullCell forIndexPath:indexPath];
    }
    YDCircleSectionModel *sectionModel = self.mgr.sections[indexPath.section];
    YDCircleCardModel *card = sectionModel.cards[indexPath.item];
    __weak typeof(self) weakSelf = self;
    switch (card.type) {
//             圈子 （我的圈子应该是有的）
        case YDCircleCardModelTypeCircle:
        {
            YDCircleItem *circleItem = [collectionView dequeueReusableCellWithReuseIdentifier:kCircleCell forIndexPath:indexPath];
            [circleItem setCircle:card.circleModel];
            // 红点显示逻辑
            YDOriginCircleModel *circleModel = card.circleModel;
            NSString *key = [NSString stringWithFormat:@"app_icon.tab_group.group.my_circle_%@", circleModel.circleId];
            YDBadgeModel *badgeModel = [[YDBadgeMgr shared] selectBadgeModelWithKey:key];
            if (badgeModel.type == YDBadgeTypeAttention) {
                circleItem.contentView.badgeBgColor = YD_RGBA(255, 88, 81, 0.8);
                circleItem.contentView.badgeCenterOffset = CGPointMake(-16, 16);
                [circleItem.contentView showBadge];
            } else {
                [circleItem.contentView clearBadge];
            }
            circleItem.action = ^ {
                // 处理红点点击逻辑
                NSString *key = [NSString stringWithFormat:@"app_icon.tab_group.group.my_circle_%@", card.circleModel.circleId];
                [[YDOriginCircleMgr sharedMgr] cache_setTimestamp:@(card.circleModel.timestamp) forKey:key];
                [[YDBadgeMgr shared] updateBadgeToNullForModelKey:key];
                
                NSString *eventStr = [NSString stringWithFormat:@"view_circle_item_%@",@(indexPath.item)];
                if (indexPath.item == 3) {
                    [[YDStatisticsMgr sharedMgr] eventTabCircleAction:@"add_circle_click"];
                }
                [[YDStatisticsMgr sharedMgr] eventTabCircleAction:eventStr];
                [weakSelf handleURLWithURL:card.circleModel.action];
            };
            return circleItem;
        }
            break;
//            直播的类型
        case YDCircleCardModelTypeLive:
        {
            YDCircleLiveImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLiveCell forIndexPath:indexPath];
            [cell setImageWith:card.liveImageString];
            return cell;
        }
            break;
//             活动的页面，（这个改版还是要有的）
        case YDCircleCardModelTypeActivity:
        {
            YDCircleActivityItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kActivityCell forIndexPath:indexPath];
            [cell setModel:card.activity];
            cell.action = ^ {
                if (indexPath.item == 0) {
                    [[YDStatisticsMgr sharedMgr] eventTabCircleAction:@"hot_activity_left_top"];
                } else if (indexPath.item == 1) {
                    [[YDStatisticsMgr sharedMgr] eventTabCircleAction:@"hot_activity_right_top"];
                }
                [[YDStatisticsMgr sharedMgr] eventCircleEnterActivityTag:sectionModel.cards[indexPath.item].activity.title];
                [weakSelf handleURLWithURL:card.activity.action];
            };
            return cell;
        }
            break;
//精选内容  去掉
        case YDCircleCardModelTypeChoiceness:
        {
            YDCircleChoicenessItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kChoicenessCell forIndexPath:indexPath];
            [cell setThemeInfo:card.themeModel];
            cell.action = ^ {
                [[YDStatisticsMgr sharedMgr] eventTabCircleAction:[NSString stringWithFormat:@"greatest_article_%@",@(indexPath.item)]];
                [[YDStatisticsMgr sharedMgr] eventCircleEnterChoicenessTag:card.themeModel.themeTitle];
                YDCircleThemeViewController *Vc = [[YDCircleThemeViewController alloc] initWithThemeId:card.themeModel.themeId title:card.themeModel.themeTitle];
                [self.navigationController pushViewController:Vc animated:YES];
            };
            return cell;
        }
            break;
//            话题的内容 （应该就是jinx9ian内偶内容的哪里的内容）
        case YDCircleCardModelTypeTopic:
        {
            YDCircleTopicItem *kCell = [collectionView dequeueReusableCellWithReuseIdentifier:kTopicCell forIndexPath:indexPath];
            __weak typeof(kCell) topicCell = kCell;
            kCell.model = card.topicModel;
            kCell.userFollowAction = ^(NSNumber *userId, NSNumber *followUserId){
                [[YDStatisticsMgr sharedMgr] eventCircleFollowAction];
                [[YDOriginCircleMgr sharedMgr] net_userFollowWithUserId:userId followUserId:followUserId then:^(id response, MSError *error) {
                    if (!error) {
                        topicCell.followBtn.hidden = YES;
                        topicCell.model.user.followStatus = @1;
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
                [weakSelf net_operateTopicWithCell:topicCell likeFlag:likeFlag];
            };
            kCell.userDiscussAction = ^{
                [[YDStatisticsMgr sharedMgr] eventCircleEnterTopicDetail];
                YDHotTopicModel *model = card.topicModel;
                if (model.param.length) {
                    NSDictionary *liveDic = [MSUtil queryDicFromUrl:[NSURL URLWithString:model.param]];
                    [self cus_handleLiveDic:liveDic];
                } else {
                    NSString *url = card.topicModel.action;
                    if ([url containsString:@"?"]) {
                        url = [url stringByAppendingString:@"&ydfrom=tab_circle_comment_button"];
                    } else {
                        url = [url stringByAppendingString:@"?ydfrom=tab_circle_comment_button"];
                    }
                    [self handleURLWithURL:url];
                }
                [collectionView cellForItemAtIndexPath:indexPath].selected = NO;
            };
            return kCell;
        }
//             广告
        case YDCircleCardModelTypeAd: {
            YDCircleAdCell *cell = [YDCircleAdCell reusableCellForCollectionView:collectionView cellId:kAdCellId indexPath:indexPath model:card.ad];
            return cell;
        }
            break;
//            推荐用户
        case YDCircleCardModelTypeRecommend:
        {
            YDTopicRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kRecommendCell forIndexPath:indexPath];
            cell.recommendInfos = card.recommendInfos;
            cell.action = ^ {
              [weakSelf handleURLWithURL:card.recomAction];
            };
        
            cell.actionToUserInfoVc = ^(NSInteger userId) {
                YDMeUserInfoViewController *Vc = [[YDMeUserInfoViewController alloc] initWithUserId:userId];
                [weakSelf.navigationController pushViewController:Vc animated:YES];
            };
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.mgr.sections.count) {
        return [[UICollectionReusableView alloc] initWithFrame:CGRectZero];
    }
    YDCircleSectionModel *sectionModel = self.mgr.sections[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (sectionModel.sectionType == YDCircleCardModelTypeBanner) {
            YDCircleBannerView *banner = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionBanner forIndexPath:indexPath];
            banner.scrollView.autoScroll = YES;
            banner.scrollView.autoScrollTimeInterval = 5;
            banner.scrollView.imageURLStringsGroup = self.mgr.imagesNameGroup;
            banner.scrollView.delegate = self;
            return banner;
        } else {
            YDCircleSectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionHeader forIndexPath:indexPath];
            header.typeLabel.text = sectionModel.title;
            __weak typeof(self) weakSelf = self;
            switch (sectionModel.sectionType) {
                case YDCircleCardModelTypeCircle:
                {
                    header.checkMoreBtn.hidden = NO;
                    header.checkIcon.hidden = NO;
                    header.action = ^{
                        [[YDStatisticsMgr sharedMgr] eventCircleEnterMyCircleList];
                        [[YDStatisticsMgr sharedMgr] eventTabCircleAction:@"all_article"];
                        [weakSelf handleURLWithURL:sectionModel.action];
                    };
                }
                    break;
                case YDCircleCardModelTypeLive:
                {
                    header.checkMoreBtn.hidden = NO;
                    header.checkIcon.hidden = NO;
                    header.action = ^ {
                        [[YDStatisticsMgr sharedMgr] eventTabCircleAction:@"live"];
                        YDLivingHomeListViewController *vc = [[YDLivingHomeListViewController alloc] init];
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                    };
                }
                    break;
                case YDCircleCardModelTypeActivity:
                {
                    header.checkMoreBtn.hidden = NO;
                    header.checkIcon.hidden = NO;
                    header.action = ^{
                        [[YDStatisticsMgr sharedMgr] eventCircleEnterCircleActivityList];
                        [[YDStatisticsMgr sharedMgr] eventTabCircleAction:@"all_hot_activity"];
                        [weakSelf handleURLWithURL:sectionModel.action];
                    };
                }
                    break;
                case YDCircleCardModelTypeChoiceness:
                {
                    header.checkMoreBtn.hidden = YES;
                    header.checkIcon.hidden = YES;
                }
                    break;
                case YDCircleCardModelTypeTopic:
                {
                    header.checkMoreBtn.hidden = NO;
                    header.checkIcon.hidden = NO;
                    header.action = ^{
                        [[YDStatisticsMgr sharedMgr] eventCircleEnterHotTopicList];
                        [weakSelf handleURLWithURL:sectionModel.action];
                    };
                }
                    break;
                default:
                    break;
            }
            return header;
        }
    }
    UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kSectionFooter forIndexPath:indexPath];
    footer.backgroundColor = YDC_BG;
    return footer;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.mgr.sections.count || indexPath.item >= self.mgr.sections[indexPath.section].cards.count) {
        return;
    }
    YDCircleSectionModel *sectionModel = self.mgr.sections[indexPath.section];
    YDCircleCardModel *card = sectionModel.cards[indexPath.item];
    switch (card.type) {
        case YDCircleCardModelTypeLive:
        {
            [[YDStatisticsMgr sharedMgr] eventTabCircleAction:@"live"];
            YDLivingHomeListViewController *vc = [[YDLivingHomeListViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            [collectionView cellForItemAtIndexPath:indexPath].selected = NO;
        }
            break;
        case YDCircleCardModelTypeTopic:
        {
            [[YDStatisticsMgr sharedMgr] eventCircleEnterTopicDetail];
            YDHotTopicModel *model = card.topicModel;
            if (model.param.length) {
                NSDictionary *liveDic = [MSUtil queryDicFromUrl:[NSURL URLWithString:model.param]];
                [self cus_handleLiveDic:liveDic];
            } else {
                [self handleURLWithURL:card.topicModel.action];
            }
            [collectionView cellForItemAtIndexPath:indexPath].selected = NO;
        }
            break;
        case YDCircleCardModelTypeAd:
        {
            __weak typeof(self) wSelf = self;
            [[YDAdMgr sharedMgr] yd_handleAdClick:card.ad fromVc:wSelf];
            [collectionView cellForItemAtIndexPath:indexPath].selected = NO;
        }
            break;
 
        default:
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.mgr.sections.count || indexPath.item >= self.mgr.sections[indexPath.section].cards.count) {
        return;
    }
    YDCircleSectionModel *sectionModel = self.mgr.sections[indexPath.section];
    YDCircleCardModel *card = sectionModel.cards[indexPath.item];
    switch (card.type) {
        case YDCircleCardModelTypeAd:
        {
//            [[YDAdMgr sharedMgr] yd_handleAdShow:card.ad];
        }
            break;
        default:
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.mgr.sections.count || indexPath.item >= self.mgr.sections[indexPath.section].cards.count) {
        return;
    }
    YDCircleSectionModel *sectionModel = self.mgr.sections[indexPath.section];
    YDCircleCardModel *card = sectionModel.cards[indexPath.item];
    switch (card.type) {
        case YDCircleCardModelTypeAd:
        {
//            [[YDAdMgr sharedMgr] yd_handleAdShow:card.ad];
        }
            break;
            
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat curOffsetY = scrollView.contentOffset.y + YDTopLayoutH;
    for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
        if ([cell isKindOfClass:[YDCircleAdCell class]]) {
            YDCircleAdCell *adCell = (YDCircleAdCell *)cell;
            if (adCell.model.adImg &&
                adCell.frame.origin.y + adCell.model.circleCellHeight <= curOffsetY + SCREEN_HEIGHT_V0 - YDTopLayoutH - YDTabBarH &&
                curOffsetY <= adCell.frame.origin.y + adCell.model.circleCellHeight) {
                [[YDAdMgr sharedMgr] yd_handleAdShow:adCell.model];
                break;
            }
        }
    }
}

#pragma mark - SDCycleScrollViewDelegate

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if ([self.mgr.sectionDic.allKeys containsObject:@(YDCircleCardModelTypeBanner).stringValue]) {
        YDCircleSectionModel *sectionModel = [self.mgr.sectionDic objectForKey:@(YDCircleCardModelTypeBanner).stringValue];
        YDCircleCardModel *cardModel = sectionModel.cards.firstObject;
        [[YDStatisticsMgr sharedMgr] eventTabCircleAction:@"banner"];
        if (cardModel.bannerInfo.banners[index].param.length) {
            NSDictionary *dic = [MSUtil queryDicFromUrl:[NSURL URLWithString:cardModel.bannerInfo.banners[index].param]];
            [[YDJumpTool sharedTool] jumpToOpenParam:dic fromVC:nil];
        } else {
            [self handleURLWithURL:cardModel.bannerInfo.banners[index].action];
        }
    }
}

@end
