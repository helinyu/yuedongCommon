//
//  HLYMineViewcontroller.m
//  test
//
//  Created by felix on 2017/6/6.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYMineViewcontroller.h"
#import "HLYCollectionViewCell.h"

@interface HLYMineViewcontroller ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HLYMineViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HLYCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([HLYCollectionViewCell class])];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
