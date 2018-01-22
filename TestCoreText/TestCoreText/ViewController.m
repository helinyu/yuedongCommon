//
//  ViewController.m
//  TestCoreText
//
//  Created by mac on 22/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "CTDisplayView.h"
#import "YDCTModel.h"
#import "YDCTParser.h"
#import "UIView+frameAdjust.h"
#import "YDCTConfig.h"
#import "YDCTLinkModel.h"
#import <CoreText/CoreText.h>
#import "ImageViewController.h"
#import "WebContentViewController.h"
#import "YDCTImageModel.h"

@interface ViewController ()

@property (nonatomic, strong) CTDisplayView *ctView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ctView = [CTDisplayView new];
    self.ctView.frame = CGRectMake(0, 100, self.view.width, 800);
    [self.view addSubview:self.ctView];

    [self setupUserInterface];
    [self setupNotifications];
}

- (void)setupUserInterface {
    YDCTConfig *config = [[YDCTConfig alloc] init];
    config.width = self.ctView.width;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    YDCTModel *data = [YDCTParser parseTemplateFile:path config:config];
    self.ctView.data = data;
    self.ctView.height = data.height;
    self.ctView.backgroundColor = [UIColor yellowColor];
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imagePressed:) name:@"CTDisplayViewImagePressedNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linkPressed:) name:@"CTDisplayViewLinkPressedNotification" object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)imagePressed:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    YDCTImageModel *imageData = userInfo[@"imageData"];
    
    ImageViewController *vc = [[ImageViewController alloc] init];
    vc.image = [UIImage imageNamed:imageData.name];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)linkPressed:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    YDCTLinkModel *linkData = userInfo[@"linkData"];
    
    WebContentViewController *vc = [[WebContentViewController alloc] init];
    vc.urlTitle = linkData.title;
    vc.url = linkData.url;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
