//
//  ViewController.m
//  TestCoreText
//
//  Created by mac on 22/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "CTDisplayView.h"
#import "CoreTextData.h"
#import "CTFrameParser.h"
#import "UIView+frameAdjust.h"

@interface ViewController ()

@property (nonatomic, strong) CTDisplayView *displayView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _displayView = [CTDisplayView new];
    _displayView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:_displayView];
    
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.width = self.displayView.bounds.size.width;
    config.textColor = [UIColor blackColor];
    
    NSString *content =
    @" 对于上面的例子，我们给 CTFrameParser 增加了一个将 NSString 转 "
    " 换为 CoreTextData 的方法。"
    " 但这样的实现方式有很多局限性，因为整个内容虽然可以定制字体 "
    " 大小，颜色，行高等信息，但是却不能支持定制内容中的某一部分。"
    " 例如，如果我们只想让内容的前三个字显示成红色，而其它文字显 "
    " 示成黑色，那么就办不到了。"
    "\n\n"
    " 解决的办法很简单，我们让`CTFrameParser`支持接受 "
    "NSAttributeString 作为参数，然后在 NSAttributeString 中设置好 "
    " 我们想要的信息。";
    NSDictionary *attr = [CTFrameParser attributesWithConfig:config];
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:content
                                           attributes:attr];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor redColor]
                             range:NSMakeRange(0, 7)];
    CoreTextData *data = [CTFrameParser parseAttributedContent:attributedString
                                                        config:config];
    self.displayView.data = data;
    self.displayView.height = data.height;
    self.displayView.backgroundColor = [UIColor yellowColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
