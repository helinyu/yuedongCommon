//
//  YDTitleCollecitonView.m
//  TestCircleAk03
//
//  Created by Aka on 2017/11/21.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDTitleCollecitonView.h"
#import "YDAvatarCCell.h"
#import "Masonry.h"

static const NSInteger kAvatarMaxNum = 6;

@interface YDTitleCollecitonView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UICollectionView *imgCollectionView;

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, strong) NSArray *imgs;

@end

@implementation YDTitleCollecitonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (void)baseInit {
    
    {
        _titleLabel = [UILabel new];
        [self addSubview:_titleLabel];
        
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _imgCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self addSubview:_imgCollectionView];
        [_imgCollectionView registerClass:[YDAvatarCCell class] forCellWithReuseIdentifier:NSStringFromClass([YDAvatarCCell class])];
        _imgCollectionView.dataSource = self;
        _imgCollectionView.delegate = self;
    }
    
    {
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(14.f);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(47.f);
        }];
        
        [_imgCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleLabel.mas_right);
            make.top.bottom.equalTo(self);
            make.right.equalTo(self).offset(-30.f);
        }];
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imgs.count <= kAvatarMaxNum? _imgs.count : kAvatarMaxNum;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YDAvatarCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YDAvatarCCell class]) forIndexPath:indexPath];
    
    return cell;
}

- (void)configureWithTitle:(NSString *)title imgs:(NSArray<NSString *> *)imgs {
    _titleText = title;
    _titleLabel.text = _titleText;

    [_imgCollectionView reloadData];
}

@end
