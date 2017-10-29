//
//  YDMoveLayoutViewController.m
//  test_effective
//
//  Created by Aka on 2017/10/29.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDMoveLayoutViewController.h"
#import "YDSingleTitleCCell.h"

@interface YDMoveLayoutViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation YDMoveLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
    [self.view addSubview:_collectionView];
    
    self.array = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4",
                  @"5", @"6", @"7", @"8",
                  @"9", @"10", @"11", @"12",@"13", @"14", @"15", @"16",
                  @"17", @"18", @"19", @"20",  nil];
    [_collectionView registerClass:[YDSingleTitleCCell class] forCellWithReuseIdentifier:NSStringFromClass([YDSingleTitleCCell class])];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor grayColor];
    
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPressMoving:)];
    [self.collectionView addGestureRecognizer:_longPress];
    
}

- (void)onLongPressMoving:(UILongPressGestureRecognizer *)longPress {
    switch (_longPress.state) {
        case UIGestureRecognizerStateBegan: {
            {
                NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
                _selectedIndexPath = selectIndexPath;
                YDSingleTitleCCell *cell = (YDSingleTitleCCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
                [_collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:_longPress.view]];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [_collectionView endInteractiveMovement];
            break;
        }
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YDSingleTitleCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YDSingleTitleCCell class]) forIndexPath:indexPath];
    cell.title = self.array[indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0) {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath NS_AVAILABLE_IOS(9_0) {
    NSLog(@"source :%@ , destination ;%@",sourceIndexPath,destinationIndexPath);
    NSString *item = self.array[sourceIndexPath.row];
    [self.array removeObjectAtIndex:sourceIndexPath.row];
    [self.array insertObject:item atIndex:destinationIndexPath.row];
    [_collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, 50);
}

@end
