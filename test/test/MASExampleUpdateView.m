 //
//  MASExampleUpdateView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 3/11/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleUpdateView.h"
#import "Masonry.h"

@interface MASExampleUpdateView ()

@property (nonatomic, strong) UIButton *growingButton;
@property (nonatomic, assign) CGSize buttonSize;

@end

@implementation MASExampleUpdateView

- (id)init {
    self = [super init];
    if (!self) return nil;

    self.growingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.growingButton setTitle:@"Grow Me!" forState:UIControlStateNormal];
    self.growingButton.layer.borderColor = UIColor.greenColor.CGColor;
    self.growingButton.layer.borderWidth = 3;
    self.growingButton.backgroundColor = [UIColor redColor];

    [self.growingButton addTarget:self action:@selector(didTapGrowButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.growingButton];

    self.buttonSize = CGSizeMake(100, 100);
    self.growingButton.layer.cornerRadius = 50;
    return self;
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints {
    
    [self.growingButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(@(self.buttonSize.width));
    }];
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

- (void)didTapGrowButton:(UIButton *)button {

    self.buttonSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.height);
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];

    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:10 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

@end
