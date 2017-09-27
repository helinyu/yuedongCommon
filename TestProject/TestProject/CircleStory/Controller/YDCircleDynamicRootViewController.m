//
//  YDCircleDynamicRootViewController.m
//  SportsBar
//
//  Created by 颜志浩 on 17/3/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YDCircleDynamicRootViewController.h"
#import "YDCirclePageViewController.h"
#import "YDCircleRootViewController.h"

@interface YDCircleDynamicRootViewController ()<TYPagerControllerDataSource,TYPagerControllerDelegate>

@property (nonatomic, strong) YDCirclePageViewController *pageController;

@end

@implementation YDCircleDynamicRootViewController


#pragma mark - initialize and dealloc

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

#pragma mark - framework init

/**
 *  create subviews
 */
- (void)msComInit {
    [self addpageController];
    [super msComInit];
    [self createViewConstraints];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ntf_changePage:) name:kYDNtfCirclePageSelectTopBtn object:nil];
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

#pragma mark - network request

#pragma mark - ntf
- (void)ntf_changePage:(NSNotification *)notification {
    NSNumber *index = notification.object;
    [self.pageController moveToControllerAtIndex:index.integerValue animated:YES];
}

#pragma mark - custom function

- (void)addpageController {
    if (self.pageController) {
        if (![self.view.subviews containsObject:self.pageController.view]) {
            [self.view addSubview:self.pageController.view];
            [self.pageController reloadData];
        }
    } else {
        YDCirclePageViewController *pageController = [[YDCirclePageViewController alloc] init];
        pageController.dataSource = self;
        pageController.delegate = self;
        pageController.adjustStatusBarHeight = YES;
        pageController.contentTopEdging = 0.f;
        pageController.defaultStartIndex = 0;
        pageController.view.frame = self.view.bounds;
        [self addChildViewController:pageController];
        [self.view addSubview:pageController.view];
        _pageController = pageController;
    }
}

#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController{
    return 2;
}

// viewController at index in pagerController

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index{
    switch (index) {
        case 0: {
            YDCircleRootViewController *VC = [[YDCircleRootViewController alloc] init];
            return VC;
        }
            break;
        case 1: {
            YDDynamicRootViewController *VC = [[YDDynamicRootViewController alloc] init];
            VC.type = YDParentControlTypeCircle;
            return VC;
        }
            break;
        default:
            break;
    }
    return nil;
}


- (void)pagerController:(TYPagerController *)pagerController transitionFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated {
}



@end
