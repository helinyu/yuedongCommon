//
//  ViewController.m
//  TestPlayer
//
//  Created by Aka on 2017/8/22.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+YDClass.h"
#import <MediaPlayer/MediaPlayer.h>
#import "YDClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *methods = MethodsOfClass([MPNowPlayingInfoCenter class]);
    for (NSInteger index = 0; index < methods.count; index++) {
        YDClass *method = methods[index];
        NSLog(@"method: %@ , name:%@ , sel:%d",method,method.name,method.sel);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
