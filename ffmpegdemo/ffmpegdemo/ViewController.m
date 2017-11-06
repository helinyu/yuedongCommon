//
//  ViewController.m
//  ffmpegdemo
//
//  Created by neil on 2017/2/5.
//  Copyright © 2017年 weixin. All rights reserved.
//

#import "ViewController.h"
#import "VideoOperate.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) VideoOperate *operate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDecodeVideoClick:(id)sender {
    [self.operate decodeWithImageBlock:^(UIImage *image) {
//        dispatch_sync(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
//        });
    }];
}
- (IBAction)onPlayVideoClick:(id)sender {
    [self.operate playVideo];
}

- (VideoOperate *)operate {
    if (!_operate) {
        VideoOperate *operate = [VideoOperate new];
        _operate = operate;
    }
    return _operate;
}

@end
