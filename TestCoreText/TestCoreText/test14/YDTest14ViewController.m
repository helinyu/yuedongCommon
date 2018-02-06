//
//  YDTest14ViewController.m
//  TestCoreText
//
//  Created by mac on 5/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTest14ViewController.h"
#import <YYLabel.h>
#import "Masonry.h"
#import <DTCoreText.h>
#import <NSString+YYAdd.h>

@interface YDTest14ViewController ()

@property (nonatomic, strong) UILabel *originLabel;
@property (nonatomic, strong) YYLabel *fixLabel;
@property (nonatomic, strong) DTAttributedLabel *dtLabel;

@end

@implementation YDTest14ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self testYY];
}

- (void)testYY {
    _fixLabel = [YYLabel new];
    NSAttributedString *attrStrig = [[NSAttributedString alloc] initWithString:@"fix label奥斯卡两地分居埃里克森积分卡洛斯；附近的卡萨；浪费静安寺；立法法；都是垃圾啊；l" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]}];
    _fixLabel.attributedText = attrStrig;
    _fixLabel.backgroundColor = [UIColor purpleColor];
    _fixLabel.numberOfLines = 0;
    [self.view addSubview:_fixLabel];
    [_fixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(200.f);
        make.width.mas_equalTo(100.f);
    }];
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(100.f, CGFLOAT_MAX) text:_fixLabel.attributedText];
    CGFloat height = ceilf(layout.textBoundingSize.height);
    [_fixLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}

- (void)testCompare {
    
    {
        _originLabel = [UILabel new];
        [self.view addSubview:_originLabel];
        [_originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.view).offset(100.f);
            make.width.mas_equalTo(100.f);
            //            make.width.height.mas_equalTo(100.f).priorityLow();
        }];
        //        _originLabel.frame = CGRectMake(100.f, 100.f, 100.f, 100.f);
        _originLabel.text = @"origin label 同一个；jf看撒娇地方拉克丝；fjsalkfjaksf";
        _originLabel.backgroundColor = [UIColor yellowColor];
        _originLabel.font = [UIFont systemFontOfSize:17.f];
        _originLabel.numberOfLines = 0;
        CGFloat originH = [_originLabel.text sizeForFont:_originLabel.font size:CGSizeMake(100.f, CGFLOAT_MAX) mode:NSLineBreakByWordWrapping].height;
        NSLog(@"origin h :%f",originH);
        
        //       fit + masonry (并没没有改变)： frame + fit 实际大小
        //        [_originLabel sizeToFit];
        //         natural 和left还是有点差别（因为ruby有可能是右向左）
    }
    
    {
        _fixLabel = [YYLabel new];
        //        _fixLabel.frame = CGRectMake(200.f, 200.f, 100.f, 100.f);
        //        _fixLabel.text = @"fix label";
        NSAttributedString *attrStrig = [[NSAttributedString alloc] initWithString:@"fix label奥斯卡两地分居埃里克森积分卡洛斯；附近的卡萨；浪费静安寺；立法法；都是垃圾啊；l" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.f]}];
        _fixLabel.attributedText = attrStrig;
        _fixLabel.backgroundColor = [UIColor purpleColor];
        //        _fixLabel.font = [UIFont systemFontOfSize:17.f];
        _fixLabel.numberOfLines = 0;
        [self.view addSubview:_fixLabel];
        [_fixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.view).offset(200.f);
            make.width.mas_equalTo(100.f);
            //            make.width.height.mas_equalTo(100.f).priorityLow();;
        }];
        //        _fixLabel.text =@"fix label奥斯卡两地分居埃里克森积分卡洛斯；附近的卡萨；浪费静安寺；立法法；都是垃圾啊；l"
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(100.f, CGFLOAT_MAX) text:_fixLabel.attributedText];
        CGFloat height = ceilf(layout.textBoundingSize.height);
        // 这个是一位每次渲染完成了之后都是整数？ 什么时候不是一个整数？？？
        NSLog(@"fix label hegiht :%f",height);
        [_fixLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
        //         fit + masonry (并没没有改变) ; fit + frame （变换【实际大小】）
        //        [_fixLabel sizeToFit];
        //        priorityLow() 约束中高度设置这个，就会发生了变化【会自动约束大小】
        //        priority(MASLayoutPriorityFittingSizeLevel)
    }
    
    {
        _dtLabel = [DTAttributedLabel new];
        [self.view addSubview:_dtLabel];
        [_dtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.view).offset(300.f);
            make.width.height.mas_equalTo(100.f).priority(MASLayoutPriorityFittingSizeLevel);
        }]; // 没有对约束进行兼容
        //        _dtLabel.frame = CGRectMake(0, 300, 100, 100);
        _dtLabel.text = @"dt label";
        _dtLabel.backgroundColor = [UIColor orangeColor];
        [_dtLabel sizeToFit];
        
        //        fix +masonry (没有变化) ； fit + frame [也会有变换]
        //         size to fit [应该是重新计算高度了]【优先级的问题】
        //        priority(MASLayoutPriorityFittingSizeLevel) 并没有变换【差别，应该是没有进行出来】
        //         应该是实现的方式有些差别
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
