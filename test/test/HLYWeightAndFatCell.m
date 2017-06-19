//
//  WeightAndFatCell.m
//  test
//
//  Created by felix on 2017/5/31.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYWeightAndFatCell.h"
#import "HLYWeightAndFatModel.h"
#import "Masonry.h"
#import "HLYChartView.h"


@interface HLYWeightAndFatCell ()

@property (nonatomic, strong) HLYWeightAndFatModel *model;
@property (nonatomic, copy) void(^moreAction)(void);


@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UILabel *cellTitleLabel;
@property (nonatomic, strong) UILabel *weightColorLabel;
@property (nonatomic, strong) UILabel *weightLabel;
@property (nonatomic, strong) UILabel *fatPercentColorLabel;
@property (nonatomic, strong) UILabel *fatPercentLabel;
@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) HLYChartView *chartView;
@end

@implementation HLYWeightAndFatCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (HLYWeightAndFatCell *)reusableCellForTableView:(UITableView *)tableView cellId:(NSString *)cell_id model:(HLYWeightAndFatModel *)model indexPath:(NSIndexPath *)indexPath action:(void(^)(void))action {
    HLYWeightAndFatCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id forIndexPath:indexPath];
    cell.model = model;
    cell.moreAction = action;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self msComInit];
        [self chartViewDataInit];
    }
    return self;
}

- (void)msComInit {

//    top
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [self.contentView addSubview:_topView];
    
    self.cellTitleLabel = [UILabel new];
    self.cellTitleLabel.text = @"一周体重数据";
    [self.topView addSubview:self.cellTitleLabel];
    self.cellTitleLabel.font = [UIFont systemFontOfSize:14];
    self.cellTitleLabel.textColor = [UIColor colorWithRed:79/255.0 green:73/255.0 blue:87/255.0 alpha:1.0f];
    
    self.weightColorLabel = [UILabel new];
    [self.topView addSubview:self.weightColorLabel];
    
    self.weightLabel = [UILabel new];
    self.weightLabel.text = @"55.4kg";
    [self.weightLabel sizeToFit];
    [self.topView addSubview:self.weightLabel];
    
    self.fatPercentColorLabel = [UILabel new];
    [self.topView addSubview:self.fatPercentColorLabel];
    
    self.fatPercentLabel = [UILabel new];
    self.fatPercentLabel.text = @"21.8%";
    [self.fatPercentLabel sizeToFit];
    [self.topView addSubview:self.fatPercentLabel];
    
    self.moreBtn = [[UIButton alloc] init];
    [self.moreBtn setTitle:@"更多" forState:(UIControlStateNormal & UIControlStateHighlighted)];
    [self.topView addSubview:self.moreBtn];
    self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.moreBtn.titleLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0f];
    
//    bottom chatview
//    self.chartView = [[HLYChartView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH - 15, 154)];
    self.chartView = [HLYChartView new];
    [self.contentView addSubview:self.chartView];
    
    [self createConstraints];
}

- (void)createConstraints {
    
    [self.cellTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(17);
    }];
    
    [self.weightColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(6);
        make.centerY.equalTo(self.cellTitleLabel);
        make.left.equalTo(self.cellTitleLabel.mas_right).offset(14);
    }];
    
    [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cellTitleLabel);
        make.left.equalTo(self.weightColorLabel.mas_right).offset(6);
    }];
    
    [self.fatPercentColorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(6);
        make.left.equalTo(self.weightLabel.mas_right).offset(9);
        make.centerY.equalTo(self.cellTitleLabel);
    }];
    
    [self.fatPercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fatPercentColorLabel.mas_right).offset(6);
        make.centerY.equalTo(self.cellTitleLabel);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.equalTo(self.cellTitleLabel);
    }];
    
    [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.right.and.bottom.equalTo(self);
    }];
}

- (void)chartViewDataInit {
    NSArray *labelNames = @[@"一",@"二",@"三",@"今",@"五",@"六",@"七"];
    NSArray *upDatas = @[@60,@60,@50,@90];
    NSArray *downDatas = @[@10,@20,@5,@15];
    
    [self.chartView.model initChartViewSize:CGSizeMake(SCREEN_WIDTH, 150)];
    [self.chartView.model configureBottomLabelNamess:labelNames upDatas:upDatas downDatas:downDatas];
    [self.chartView ms_load];
    self.chartView.act_tap = ^(NSInteger viewTag) {
        NSLog(@"view  tag: %ld",viewTag);
        NSLog(@"weigth is: %@",upDatas[viewTag-viewTagBaseConstant]);
        NSLog(@"fat is: %@",downDatas[viewTag-viewTagBaseConstant]);
    };
}

@end
