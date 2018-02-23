//
//  YDHorizontalTableView.h
//  TestCoreText
//
//  Created by mac on 23/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDHorizontalTableView;
@class YDHorizontalBaseViewCell;
@class YDHorizontalBaseLayerCell;
@class YDLayerCell;

typedef NS_ENUM(NSInteger, YDHorizontalTableViewCelltype) {
    YDHorizontalTableViewCelltypeView = 0,
    YDHorizontalTableViewCelltypeLayer,
};

@protocol YDHorizontalTableViewDataSource <NSObject>

@optional

- (NSInteger)numberOfRows;
- (CGFloat)widthOfRow;

//for view
- (YDHorizontalBaseViewCell *)horizontalTableView:(YDHorizontalTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

//for layer
- (YDLayerCell *)horizontalLayerTableView:(YDHorizontalTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface YDHorizontalTableView : UIScrollView

@property (nonatomic, weak) id <YDHorizontalTableViewDataSource> dataSource;
@property (nonatomic, assign) YDHorizontalTableViewCelltype cellType;

/**
 refresh the datas
 */
- (void)reloadData;

/**
 先进行注册对象

 @param cellClass cell 类型
 @param identifier 标识符 （用于重用）
 */
- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier;

/**
 reuse cell for the identifier

 @param identifier <#identifier description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
- (YDHorizontalBaseViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath;

/**
 reuser cell fot the identifeir

 @param identifier unique identifier
 @param indexPath indexpath
 @return value
 */
- (YDHorizontalBaseLayerCell *)dequeueReusableLayerCellWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath;

@end
