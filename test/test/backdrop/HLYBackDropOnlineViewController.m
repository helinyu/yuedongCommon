//
//  HLYBackDropOnlineViewController.m
//  test
//
//  Created by felix on 2017/6/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYBackDropOnlineViewController.h"
#import "HLYBackDropMgr.h"
#import "HLYOnlinePictureCCell.h"


@interface HLYBackDropOnlineViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) UICollectionView *collectionView;

@end

static NSString *const onlineSourceCellIdentifier = @"online.source.cell.identifier";

static const NSInteger cellHorizontalSpace = 11.f;
static const NSInteger cellVerticalSpace = 11.f;
static const NSInteger numberOfALine = 3.f;

@implementation HLYBackDropOnlineViewController


#pragma mark - property init

#pragma mark - initialize and dealloc

#pragma mark - framework init

/**
 *  create subviews
 */
- (void)msComInit {
    
    [super msComInit];
    // com create without constraints ...
    
    _collectionView = [[UICollectionView alloc] initWithFrame:SCREEN_BOUNDS collectionViewLayout:[UICollectionViewFlowLayout new]];
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [_collectionView registerClass:[HLYOnlinePictureCCell class] forCellWithReuseIdentifier:onlineSourceCellIdentifier];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(onReload)];
    
    [self createViewConstraints];
}

- (void)onReload {
    [self.collectionView reloadData];
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
    [[HLYBackDropMgr shareInstance] initOnlinPictureSoruces];
}

/**
 *  static style
 */
- (void)msStyleInit {
    
    self.title = @"更换背景";
    self.view.backgroundColor = [UIColor grayColor];
    [super msStyleInit];
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
    //    [self net_checkShareReward];
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

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

#pragma mark -- collectionView datasource 

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HLYOnlinePictureCCell *cell = [HLYOnlinePictureCCell reuseCollectionVeiw:collectionView withIdentifier:onlineSourceCellIdentifier indexPath:indexPath model:[HLYBackDropMgr shareInstance].onlinePicSources[indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [HLYBackDropMgr shareInstance].onlinePicSources.count;
}

#pragma mark -UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellLength = (SCREEN_WIDTH - cellHorizontalSpace * (numberOfALine +1))/numberOfALine;
    return CGSizeMake(cellLength, cellLength);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, cellHorizontalSpace, 0, cellHorizontalSpace);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return cellHorizontalSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return cellVerticalSpace;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

@end
