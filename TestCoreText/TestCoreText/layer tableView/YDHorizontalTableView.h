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
@class YDHorizontalLayerCell;

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
- (YDHorizontalLayerCell *)horizontalLayerTableView:(YDHorizontalTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface YDHorizontalTableView : UIScrollView

@property (nonatomic, weak) id <YDHorizontalTableViewDataSource> dataSource;

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
 reuser cell fot the identifeir

 @param identifier unique identifier
 @param indexPath indexpath
 @return value
 */
- (YDHorizontalBaseLayerCell *)dequeueReusableLayerCellWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath;

@end
