//
//  YDCirclePageViewController.m
//  SportsBar
//
//  Created by 颜志浩 on 17/3/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YDCirclePageViewController.h"
#import "YDMWebViewController.h"
#import "YDDiscoveryFriendViewController.h"
#import "YDQRScanViewController.h"
#import "MSComboBox.h"
#import "MSComboModel.h"
#import "YDOriginCircleMgr.h"
#import "UIBarButtonItem+WZLBadge.h"

#import "XWCatergoryView.h"
#import "XWCatergoryViewCell.h"

#import "NSString+SizeToFit.h"
#import "YDBadgeMgr.h"
#import "YDBadgeModel.h"
#import "UIView+WZLBadge.h"

static const int kTabHeight = 44;
static const int kTabBottomLineBottom = 4;
static const int kTabBottomLineHeight = 1;
static const int kTabSpace = 15;

@interface YDCirclePageViewController () <XWCatergoryViewDelegate>

@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;
@property (nonatomic, strong) MSComboBox *comboBox;
@property (nonatomic, weak) UIView *comboBoxAlignView;

@property (nonatomic, weak) XWCatergoryView *tabView;
@property (nonatomic, strong) NSArray<NSString *> *tabTitles;

@end

@implementation YDCirclePageViewController
#pragma mark -- getter/setter
- (NSArray<NSString *> *)tabTitles {
    if (!_tabTitles) {
        _tabTitles = @[MSLocalizedString(@"圈子", nil), MSLocalizedString(@"动态", nil)];
    }
    return _tabTitles;
}

// 右边上面的多选项目

- (MSComboBox *)comboBox {
    if (!_comboBox) {
        MSComboBox *combobox = [[MSComboBox alloc] initWithFrame:CGRectZero];
        combobox.comboHeight = 41;
        combobox.comboBoxWidth = 132;
        combobox.superMargin = 8;
        combobox.alignMargin = 15;
        NSMutableArray<MSComboModel *> *datas = @[].mutableCopy;
        MSComboModel *model1 = [[MSComboModel alloc] init];
        model1.iconUrl = @"icon_circle_add_topic";
        model1.name = MSLocalizedString(@"发表话题", nil);
        MSComboModel *model2 = [[MSComboModel alloc] init];
        model2.iconUrl = @"icon_circle_add_dynamic";
        model2.name = MSLocalizedString(@"发布动态", nil);
        MSComboModel *model3 = [[MSComboModel alloc] init];
        model3.iconUrl = @"icon_circle_join_circle";
        model3.name = MSLocalizedString(@"加入圈子", nil);
        MSComboModel *model4 = [[MSComboModel alloc] init];
        model4.iconUrl = @"icon_circle_discovery_friends";
        model4.name = MSLocalizedString(@"发现好友", nil);
        MSComboModel *model5 = [[MSComboModel alloc] init];
        model5.iconUrl = @"icon_circle_scan";
        model5.name = MSLocalizedString(@"扫一扫", nil);
        [datas addObjectsFromArray:@[model1, model2, model3, model4, model5]];
        combobox.datas = datas;
        UIView *view = nil;
        NSMutableArray<UIView *> *views = @[].mutableCopy;
        [views addObject:self.navBar];
        while (views.firstObject && !view) {
            UIView *tv = views.firstObject;
            [views removeObjectAtIndex:0];
            for (UIView *v in tv.subviews) {
                if ([v isKindOfClass:NSClassFromString(@"UINavigationButton")] || [NSStringFromClass([v class]) rangeOfString:@"BarButton"].length > 0) {
                    view = v;
                    break;
                } else {
                    [views addObject:v];
                }
            }
        }
        [views removeAllObjects];

        __weak typeof(self) wSelf = self;
        combobox.selectAction = ^(NSInteger index) {
            switch (index) {
                case 0: {
                    [[YDStatisticsMgr sharedMgr] eventCircleEnterPublishTopic];
                    YDMWebViewController *vc = [[YDMWebViewController alloc] init];
                    [[YDStatisticsMgr sharedMgr] eventTabCircleAction:@"public_topic"];
                    vc.url = [NSURL yd_URLWithString:@"https://sslsharecircle.51yund.com/editDiscussion?from_type=0&from=tab_circle"];
                    [wSelf.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 1: {
                    [[YDStatisticsMgr sharedMgr] eventCircleEnterPublishTopic];
                    YDMWebViewController *vc = [[YDMWebViewController alloc] init];
                    [[YDStatisticsMgr sharedMgr] eventTabCircleAction:@"public_dynamic"];
                    vc.url = [NSURL yd_URLWithString:@"https://sslsharecircle.51yund.com/editDiscussion?add_dynamic=1&from=tab_circle"];
                    [wSelf.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 2: {
                    [[YDStatisticsMgr sharedMgr] eventCircleEnterPublishTopic];
                    YDMWebViewController *vc = [[YDMWebViewController alloc] init];
                    [[YDStatisticsMgr sharedMgr] eventTabCircleAction:@"add_circle"];
                    vc.url = [NSURL yd_URLWithString:@"https://sslsharecircle.51yund.com/circleMain/searchCircle?tab=2"];
                    [wSelf.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 3: {
                    if (![[YDOriginCircleMgr sharedMgr] pref_getHasTouchTopRightDiscoveryFriendBtn]) {
                        [[YDOriginCircleMgr sharedMgr] pref_setHasTouchTopRightDiscoveryFriendBtn];
                        [wSelf.rightBarButtonItem clearBadge];
                    }
                    [[YDStatisticsMgr sharedMgr] eventTabCircleAction:@"find_friend"];
                    YDDiscoveryFriendViewController *vc = [[YDDiscoveryFriendViewController alloc] init];
                    [wSelf.navigationController pushViewController:vc animated:YES];
                    break;
                }
                case 4: {
                    [[YDStatisticsMgr sharedMgr] eventTabCircleAction:@"eqCode"];
                    YDQRScanViewController *vc = [[YDQRScanViewController alloc] init];
                    vc.feature = YDQrCodeFeatureAll;
                    vc.isQQSimulator = YES;
                    vc.hidesBottomBarWhenPushed = YES;
                    [wSelf.navigationController pushViewController:vc animated:YES];
                    break;
                }
                    
                default:
                    break;
            }
            
        };
        
        _comboBox = combobox;
        _comboBoxAlignView = view.subviews[0];
        
    }
    return _comboBox;
}

/**
 *  create subviews
 */
- (void)msComInit {
    
    [super msComInit];
    [self createViewConstraints];
    [self yd_navBarInitWithStyle:YDNavBarStyleGray];
    [self initTab];
}
- (void)msNavBarInit:(YDNavigationBar *)navBar {
    navBar.topItem.leftBarButtonItem = nil;
}
/**
 *  create constraints
 */
- (void)createViewConstraints {
    
    
    [super createViewConstraints];
}

/**
 *  notification bind & touch events bind & delegate bind
 */
- (void)msBind {
    [super msBind];

    // 不显示红点了
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBadges:) name:NTF_BADGE_REFRESH object:nil];
}

/**
 *  data init
 */
- (void)msDataInit {
    [super msDataInit];
    
}

/**
 *  static style
 */
- (void)msStyleInit {
    [super msStyleInit];
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_origin_circle_add_topic"] style:UIBarButtonItemStyleDone target:self action:@selector(publishTopic:)];
//    self.rightBarButtonItem.badgeBgColor = [UIColor blueColor];
    self.navBar.topItem.rightBarButtonItem = self.rightBarButtonItem;
    self.rightBarButtonItem.badgeCenterOffset = CGPointMake(-10, 3);
    if (![[YDOriginCircleMgr sharedMgr] pref_getHasTouchTopRightDiscoveryFriendBtn]) {
        [self.rightBarButtonItem showBadge];
    }
    
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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
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

#pragma mark - custom function
- (void)initTab {
    //    [self.tabView removeFromSuperview];
    self.navBar.topItem.titleView = nil;
    XWCatergoryView *catergoryView = [[XWCatergoryView alloc] initWithFrame:CGRectMake(0, 0, self.tabWidth, kTabHeight)];
    catergoryView.clipsToBounds = YES;
   
    //必须设置titles数据源
    catergoryView.titles = self.tabTitles;

    //代理坚挺点击;
    catergoryView.delegate = self;
    catergoryView.scrollView = self.contentView;
    
    //必须设置关联的scrollview
    catergoryView.itemSpacing = kTabSpace;
    catergoryView.edgeSpacing = 0;
    catergoryView.titleFont = YDF_DEFAULT_R(YDFontSizeNav);
    
    catergoryView.titleColorChangeEable = YES;
    catergoryView.titleColorChangeGradually = NO;
    catergoryView.titleColor = YDC_NAV_TINT;
    catergoryView.titleSelectColor = YDC_G;
    
    catergoryView.scaleEnable = NO;
    catergoryView.scaleRatio = 1.1;
    
    //开启底部线条
    catergoryView.bottomLineEable = YES;
    catergoryView.bottomLineColor = YDC_G;
    catergoryView.bottomLineWidth = kTabBottomLineHeight;
    catergoryView.bottomLineSpacingFromTitleBottom = kTabBottomLineBottom;
    
    catergoryView.backEllipseEable = NO;
    
    //禁用点击item滚动scrollView的动画
    catergoryView.scrollWithAnimaitonWhenClicked = YES;
    catergoryView.backgroundColor = [UIColor clearColor];
    
    catergoryView.defaultIndex = 0;
    self.navBar.topItem.titleView = catergoryView;
    self.tabView = catergoryView;
    [self.tabView xw_realoadData];
    [self.view bringSubviewToFront:self.navBar];
}
- (CGFloat)tabWidth { 
    CGFloat titleWidth = ceil([[self.tabTitles componentsJoinedByString:@""] xw_sizeWithfont:YDF_DEFAULT_R(YDFontSizeNav) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width);
    return titleWidth + kTabSpace * (self.tabTitles.count > 0 ? self.tabTitles.count - 1 : 0);
}
- (void)publishTopic:(id)sender {
    [[YDStatisticsMgr sharedMgr] eventCircleNavAddBtnClick];
    [self.comboBox showInView:self.view alignToView:self.comboBoxAlignView align:YDViewAlignBottom];
}


- (void)catergoryView:(XWCatergoryView *)catergoryView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self moveToControllerAtIndex:indexPath.row animated:YES];
    if (indexPath.row == 0) {
        [[YDStatisticsMgr sharedMgr] eventCircleNavCircleBtnClick];
    } else {
        [[YDStatisticsMgr sharedMgr] eventCircleNavDynamicBtnClick];
    }
}

@end
