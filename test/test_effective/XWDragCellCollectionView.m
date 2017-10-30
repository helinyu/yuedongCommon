//
//  XWDragCellCollectionView.m
//  PanCollectionView
//
//  Created by YouLoft_MacMini on 16/1/4.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWDragCellCollectionView.h"
#import <AudioToolbox/AudioToolbox.h>

#define angelToRandian(x)  ((x)/180.0*M_PI)

@interface XWDragCellCollectionView ()

@property (nonatomic, strong) NSIndexPath *originalIndexPath;
@property (nonatomic, weak) UICollectionViewCell *orignalCell;
@property (nonatomic, assign) CGPoint orignalCenter;

@property (nonatomic, strong) NSIndexPath *moveIndexPath;
@property (nonatomic, weak) UIView *tempMoveCell;
@property (nonatomic, weak) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, assign) CGPoint lastPoint;

@end

@implementation XWDragCellCollectionView

@dynamic delegate;
@dynamic dataSource;

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self xwp_addGesture];
    }
    return self;
}

#pragma mark - longPressGesture methods

/**
 *  添加一个自定义的滑动手势
 */
- (void)xwp_addGesture{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(xwp_longPressed:)];
    _longPressGesture = longPress;
    [self addGestureRecognizer:longPress];
}

/**
 *  监听手势的改变
 */
- (void)xwp_longPressed:(UILongPressGestureRecognizer *)longPressGesture{
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
        [self xwp_gestureBegan:longPressGesture];
    }
    if (longPressGesture.state == UIGestureRecognizerStateChanged) {
        [self xwp_gestureChange:longPressGesture];
    }
    if (longPressGesture.state == UIGestureRecognizerStateCancelled ||
        longPressGesture.state == UIGestureRecognizerStateEnded){
        [self xwp_gestureEndOrCancle:longPressGesture];
    }
}

/**
 *  手势开始
 */
- (void)xwp_gestureBegan:(UILongPressGestureRecognizer *)longPressGesture{
    //获取手指所在的cell
    _originalIndexPath = [self indexPathForItemAtPoint:[longPressGesture locationOfTouch:0 inView:longPressGesture.view]];
    UICollectionViewCell *cell = [self cellForItemAtIndexPath:_originalIndexPath];
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
    [self addSubview:_tempMoveCell];

    _lastPoint = [longPressGesture locationOfTouch:0 inView:longPressGesture.view];
}
/**
 *  手势拖动
 */
- (void)xwp_gestureChange:(UILongPressGestureRecognizer *)longPressGesture {
    CGFloat tranX = [longPressGesture locationOfTouch:0 inView:longPressGesture.view].x - _lastPoint.x;
    CGFloat tranY = [longPressGesture locationOfTouch:0 inView:longPressGesture.view].y - _lastPoint.y;
    _tempMoveCell.center = CGPointApplyAffineTransform(_tempMoveCell.center, CGAffineTransformMakeTranslation(tranX, tranY));
    _lastPoint = [longPressGesture locationOfTouch:0 inView:longPressGesture.view];
    [self xwp_moveCell];
}

/**
 *  手势取消或者结束
 */
- (void)xwp_gestureEndOrCancle:(UILongPressGestureRecognizer *)longPressGesture{
    UICollectionViewCell *cell = [self cellForItemAtIndexPath:_originalIndexPath];
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.25 animations:^{
        _tempMoveCell.center = _orignalCenter;
    } completion:^(BOOL finished) {
        [_tempMoveCell removeFromSuperview];
        cell.hidden = NO;
        _orignalCell.hidden = NO;
        self.userInteractionEnabled = YES;
        _originalIndexPath = nil;
    }];
}

#pragma mark - private methods

- (void)xwp_moveCell{
    for (UICollectionViewCell *cell in [self visibleCells]) {
        if ([self indexPathForCell:cell] == _originalIndexPath) {
            continue;
        }
        //计算中心距
        CGFloat spacingX = fabs(_tempMoveCell.center.x - cell.center.x);
        CGFloat spacingY = fabs(_tempMoveCell.center.y - cell.center.y);
        if (spacingX <= _tempMoveCell.bounds.size.width / 2.0f && spacingY <= _tempMoveCell.bounds.size.height / 2.0f) {
            _moveIndexPath = [self indexPathForCell:cell];
            _orignalCell = cell;
            _orignalCenter = cell.center;
            //更新数据源
            [self xwp_updateDataSource];
            //移动
            NSLog(@"%@", [self cellForItemAtIndexPath:_originalIndexPath]);
            [CATransaction begin];
            [self moveItemAtIndexPath:_originalIndexPath toIndexPath:_moveIndexPath];
            [CATransaction setCompletionBlock:^{
                NSLog(@"动画完成 xwD");
            }];
            [CATransaction commit];

            if ([self.delegate respondsToSelector:@selector(dragCellCollectionView:moveCellFromIndexPath:toIndexPath:)]) {
                [self.delegate dragCellCollectionView:self moveCellFromIndexPath:_originalIndexPath toIndexPath:_moveIndexPath];
            }
            _originalIndexPath = _moveIndexPath;
            break;
        }
    }
}

/**
 *  更新数据源
 */
- (void)xwp_updateDataSource{
    NSMutableArray *temp = @[].mutableCopy;
    
    //获取数据源
    if ([self.dataSource respondsToSelector:@selector(dataSourceArrayOfCollectionView:)]) {
        [temp addObjectsFromArray:[self.dataSource dataSourceArrayOfCollectionView:self]];
    }
    BOOL dataTypeCheck = ([self numberOfSections] != 1 || ([self numberOfSections] == 1 && [temp[0] isKindOfClass:[NSArray class]]));
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
    
    //将重排好的数据传递给外部
    if ([self.delegate respondsToSelector:@selector(dragCellCollectionView:newDataArrayAfterMove:)]) {
        [self.delegate dragCellCollectionView:self newDataArrayAfterMove:temp.copy];
    }
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return [super hitTest:point withEvent:event];
}

@end
