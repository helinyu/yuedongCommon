//
//  YDIOS9BeforeCustomViewController.m
//  test_effective
//
//  Created by Aka on 2017/10/30.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDIOS9BeforeCustomViewController.h"
#import "XWCell.h"
#import "XWCellModel.h"

@interface YDIOS9BeforeCustomViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGR;

@property (nonatomic, strong) NSIndexPath *originalIndexPath;
@property (nonatomic, weak) UICollectionViewCell *orignalCell;
@property (nonatomic, assign) CGPoint orignalCenter;

@property (nonatomic, strong) NSIndexPath *moveIndexPath;
@property (nonatomic, weak) UIView *tempMoveCell;
@property (nonatomic, assign) CGPoint lastPoint;

@end

@implementation YDIOS9BeforeCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];

    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.view addSubview:_collectionView];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XWCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([XWCell class])];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPressClick:)];
    _longPressGR = longPressGR;
    [_collectionView addGestureRecognizer:longPressGR];
    
    _collectionView.backgroundColor = [UIColor grayColor];
}

- (NSArray *)data{
    if (!_data) {
        NSArray *colors = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor orangeColor], [UIColor greenColor]];
        NSMutableArray *tempSection = @[].mutableCopy;
        for (int i = 0; i < 5; i ++) {
                NSString *str = [NSString stringWithFormat:@"%d--%d", i, i];
                XWCellModel *model = [XWCellModel new];
                model.backGroundColor = colors[i];
                model.title = str;
                [tempSection addObject:model];
        }
        _data = tempSection.copy;
    }
    return _data;
}

#pragma mark --

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XWCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XWCell" forIndexPath:indexPath];
    cell.data = self.data[indexPath.item];
    return cell;
}

#pragma mark -- onLongPressClick

- (void)onLongPressClick:(UILongPressGestureRecognizer *)recognizer {
    NSLog(@"has long press ");
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self beginInteractiveMovementWithRecognizer:recognizer];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self updateInteractiveMovementWithRecognizer:recognizer];
        }
            break;
        default:
        {
            [self endOrCancelInteractiveMovementWithRecognizer:recognizer];
        }
            break;
    }
}

- (void)beginInteractiveMovementWithRecognizer:(UILongPressGestureRecognizer *)longPressGesture{
    //获取手指所在的cell
    _originalIndexPath = [self.collectionView indexPathForItemAtPoint:[longPressGesture locationOfTouch:0 inView:longPressGesture.view]];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:_originalIndexPath];
    UIImage *snap;
    UIGraphicsBeginImageContextWithOptions(cell.bounds.size, 1.0f, 0);
    [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
    snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIView *tempMoveCell = [UIView new];
    tempMoveCell.layer.contents = (__bridge id)snap.CGImage;
    cell.hidden = YES;
    //记录cell，不能通过_originalIndexPath,在重用之后原indexpath所对应的cell可能不会是这个cell了
    _orignalCell = cell;
    //记录ceter，同理不能通过_originalIndexPath来获取cell
    _orignalCenter = cell.center;
    _tempMoveCell = tempMoveCell;
    _tempMoveCell.frame = cell.frame;
    [self.collectionView addSubview:_tempMoveCell];
    
    _lastPoint = [longPressGesture locationOfTouch:0 inView:longPressGesture.view];
}

- (void)updateInteractiveMovementWithRecognizer:(UILongPressGestureRecognizer *)longPressGesture {
    CGFloat tranX = [longPressGesture locationOfTouch:0 inView:longPressGesture.view].x - _lastPoint.x;
    CGFloat tranY = [longPressGesture locationOfTouch:0 inView:longPressGesture.view].y - _lastPoint.y;
    _tempMoveCell.center = CGPointApplyAffineTransform(_tempMoveCell.center, CGAffineTransformMakeTranslation(tranX, tranY));
    _lastPoint = [longPressGesture locationOfTouch:0 inView:longPressGesture.view];
    [self _moveCell];
}

- (void)endOrCancelInteractiveMovementWithRecognizer:(UILongPressGestureRecognizer *)longPressGesture{
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:_originalIndexPath];
    self.collectionView.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        _tempMoveCell.center = _orignalCenter;
    } completion:^(BOOL finished) {
        [_tempMoveCell removeFromSuperview];
        cell.hidden = NO;
        _orignalCell.hidden = NO;
        self.collectionView.userInteractionEnabled = YES;
        _originalIndexPath = nil;
    }];
}

- (void)_moveCell{
    for (UICollectionViewCell *cell in [self.collectionView visibleCells]) {
        if ([self.collectionView indexPathForCell:cell] == _originalIndexPath) {
            continue;
        }
        //计算中心距
        CGFloat spacingX = fabs(_tempMoveCell.center.x - cell.center.x);
        CGFloat spacingY = fabs(_tempMoveCell.center.y - cell.center.y);
        if (spacingX <= _tempMoveCell.bounds.size.width / 2.0f && spacingY <= _tempMoveCell.bounds.size.height / 2.0f) {
            _moveIndexPath = [self.collectionView indexPathForCell:cell];
            _orignalCell = cell;
            _orignalCenter = cell.center;
            //更新数据源
            [self updateDataSource];
            //移动
            NSLog(@"%@", [self.collectionView cellForItemAtIndexPath:_originalIndexPath]);
            [CATransaction begin];
            [self.collectionView moveItemAtIndexPath:_originalIndexPath toIndexPath:_moveIndexPath];
            [CATransaction setCompletionBlock:^{
                NSLog(@"动画完成 xwD");
            }];
            [CATransaction commit];
            _originalIndexPath = _moveIndexPath;
            break;
        }
    }
}

- (void)updateDataSource{
    NSMutableArray *temp = @[].mutableCopy;
        [temp addObjectsFromArray:self.data];
    BOOL dataTypeCheck = ([self.collectionView numberOfSections] != 1 || ([self.collectionView numberOfSections] == 1 && [temp[0] isKindOfClass:[NSArray class]]));
    if (dataTypeCheck) {
        for (int i = 0; i < temp.count; i ++) {
            [temp replaceObjectAtIndex:i withObject:[temp[i] mutableCopy]];
        }
    }
    if (_moveIndexPath.section == _originalIndexPath.section) {
        NSMutableArray *orignalSection = dataTypeCheck ? temp[_originalIndexPath.section] : temp;
        if (_moveIndexPath.item > _originalIndexPath.item) {
            for (NSUInteger i = _originalIndexPath.item; i < _moveIndexPath.item ; i ++) {
                [orignalSection exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
            }
        }else{
            for (NSUInteger i = _originalIndexPath.item; i > _moveIndexPath.item ; i --) {
                [orignalSection exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
            }
        }
    }else{
        NSMutableArray *orignalSection = temp[_originalIndexPath.section];
        NSMutableArray *currentSection = temp[_moveIndexPath.section];
        [currentSection insertObject:orignalSection[_originalIndexPath.item] atIndex:_moveIndexPath.item];
        [orignalSection removeObject:orignalSection[_originalIndexPath.item]];
    }
}


@end
