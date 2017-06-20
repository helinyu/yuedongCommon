//
//  HLYOnlinePictureCCell.m
//  test
//
//  Created by felix on 2017/6/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "HLYOnlinePictureCCell.h"
#import "HLYBackdropModel.h"
#import "HLYPicStatusView.h"


@interface HLYOnlinePictureCCell ()

@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, strong) UIImageView *backgroundThumbnail;
@property (nonatomic, strong) HLYPicStatusView *picStatusView;

@property (nonatomic, strong) HLYBackdropOnlineModel *model;

@end

static const CGFloat progressPercentH = 2/11.f;
static const CGFloat progressPercentY= 9/11.f;

@implementation HLYOnlinePictureCCell

+ (HLYOnlinePictureCCell *)reuseCollectionVeiw:(UICollectionView *)collectionView withIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath model:(HLYBackdropOnlineModel *)model {
    HLYOnlinePictureCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self comInit];
    }
    return self;
}

- (void)comInit {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.f) {
        self.contentView.frame = self.bounds;
    }
    
    if (!_backgroundThumbnail) {
        _backgroundThumbnail = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_backgroundThumbnail];
    }
    
    if (!_picStatusView) {
        _picStatusView = [[HLYPicStatusView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds)*progressPercentY, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)*progressPercentH)];
        [self.contentView addSubview:_picStatusView];
    }
    
}

- (void)setModel:(HLYBackdropOnlineModel *)model {
    _model = model;

    _backgroundThumbnail.image = [UIImage imageNamed:_model.picUrl];
    [_picStatusView configureStatusWithItem:_model];

}

@end
