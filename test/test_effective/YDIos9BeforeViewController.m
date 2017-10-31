//
//  YDIos9BeforeViewController.m
//  test_effective
//
//  Created by Aka on 2017/10/29.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDIos9BeforeViewController.h"
#import "XWCell.h"
#import "XWCellModel.h"
#import "XWDragCellCollectionView.h"

@interface YDIos9BeforeViewController ()<XWDragCellCollectionViewDelegate,XWDragCellCollectionViewDataSource>

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, weak) XWDragCellCollectionView *mainView;
@end

@implementation YDIos9BeforeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    CGFloat width = (self.view.bounds.size.width - 40) / 3.0f;
    layout.itemSize = CGSizeMake(width, width);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumInteritemSpacing = 10;
    XWDragCellCollectionView *mainView = [[XWDragCellCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _mainView = mainView;
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.backgroundColor = [UIColor whiteColor];
    [mainView registerNib:[UINib nibWithNibName:@"XWCell" bundle:nil] forCellWithReuseIdentifier:@"XWCell"];
    [self.view addSubview:mainView];
}

- (NSArray *)data{
    if (!_data) {
        NSMutableArray *temp = @[].mutableCopy;
        NSArray *colors = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor orangeColor], [UIColor greenColor]];
        for (int i = 0; i < 5; i ++) {
            NSMutableArray *tempSection = @[].mutableCopy;
            for (int j = 0; j < arc4random() % 12 + 6; j ++) {
                NSString *str = [NSString stringWithFormat:@"%d--%d", i, j];
                XWCellModel *model = [XWCellModel new];
                model.backGroundColor = colors[i];
                model.title = str;
                [tempSection addObject:model];
            }
            [temp addObject:tempSection.copy];
        }
        _data = temp.copy;
    }
    return _data;
}


#pragma mark - <XWDragCellCollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *sec = _data[section];
    return sec.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XWCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XWCell" forIndexPath:indexPath];
    cell.data = _data[indexPath.section][indexPath.item];
    return cell;
}

- (NSArray *)dataSourceArrayOfCollectionView:(XWDragCellCollectionView *)collectionView{
    return _data;
}

#pragma mark - <XWDragCellCollectionViewDelegate>

- (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray{
    _data = newDataArray;
}

@end
