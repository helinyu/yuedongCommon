//
//  HLYBaseView.m
//  test
//
//  Created by felix on 2017/6/6.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYBaseView.h"
#import "Masonry.h"

@interface HLYBaseView ()

@property (nonatomic, strong, readwrite) UIImageView *topBgImageView;
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) UIView *tvgbView;

@end

static const CGFloat kBgToTopConstraint = 11.0f;

@implementation HLYBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self comInit];
        [self langInit];
        [self styleInit];
    }
    return self;
}

- (void)comInit {
    
    self.topBgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Snip20170606_1.png"]];
    [self addSubview:self.topBgImageView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];

    
    self.tvgbView = [[UIView alloc] initWithFrame:CGRectMake(0, kBgToTopConstraint, SCREEN_WIDTH, SCREEN_HEIGHT * 2 - kBgToTopConstraint)];
    self.tvgbView.backgroundColor = [UIColor yellowColor];
    [self.tableView addSubview:self.tvgbView];
    [self.tableView sendSubviewToBack:self.tvgbView];

}

- (void)langInit {
    
}

- (void)styleInit {
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
}

@end
