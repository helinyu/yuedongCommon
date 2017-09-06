//
//  YDPlayerViewController.m
//  YDProgressView
//
//  Created by Aka on 2017/9/6.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface YDPlayerViewController ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation YDPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"播放音频" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onPlayClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 30);

    UIButton *getTimebtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [getTimebtn setTitle:@"获取时间" forState:UIControlStateNormal];
    [getTimebtn addTarget:self action:@selector(onGetTime) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getTimebtn];
    getTimebtn.frame = CGRectMake(100, 200, 100, 30);

}

- (void)onPlayClick {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"陈奕迅 - 富士山下.mp3" ofType:nil];
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:path]];
    [player play];
    _player = player;
}


- (void)onGetTime  {
   CMTime time =  _player.currentTime;
    NSTimeInterval currentTime = CMTimeGetSeconds(time);
    NSLog(@"current time :%f",currentTime);
    
    CMTime totalTime = _player.currentItem.duration;
    NSTimeInterval currentTimeLength = CMTimeGetSeconds(totalTime);
    NSLog(@"total time :%f",currentTimeLength);

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
