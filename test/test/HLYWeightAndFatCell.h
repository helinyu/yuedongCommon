//
//  WeightAndFatCell.h
//  test
//
//  Created by felix on 2017/5/31.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLYWeightAndFatModel;

@interface HLYWeightAndFatCell : UITableViewCell

+ (HLYWeightAndFatCell *)reusableCellForTableView:(UITableView *)tableView cellId:(NSString *)cell_id model:(HLYWeightAndFatModel *)model indexPath:(NSIndexPath *)indexPath action:(void(^)(void))action;

@end
