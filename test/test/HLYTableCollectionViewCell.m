
//
//  HLYTableCollectionViewCell.m
//  test
//
//  Created by felix on 2017/6/7.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYTableCollectionViewCell.h"
#import "HLYInnerCollectionCell.h"

@interface HLYTableCollectionViewCell ()

@end

@implementation HLYTableCollectionViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"selfo");
        if (_tableCollectionView == nil) {
            UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
            flowLayout.minimumLineSpacing = 0;
            flowLayout.minimumInteritemSpacing = 0;
            flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
            _tableCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds)) collectionViewLayout:flowLayout];
            [self addSubview:_tableCollectionView];
            _tableCollectionView.backgroundColor = [UIColor greenColor];
       }
    }
    return self;
}




@end
