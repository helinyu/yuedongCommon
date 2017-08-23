//
//  ViewController.m
//  TestAudio
//
//  Created by Aka on 2017/8/22.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "YDAudioMgr.h"
#import "YDOneLyricUnit.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *lyrcs;

@property (nonatomic, strong) YDAudioMgr *mgr;

@end

static NSString *const reuseIdentifierId = @"reuse.identifier.id";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mgr = [YDAudioMgr shared];
    [self loadBase];
    [self loadLyrcs];
    
}

- (void)loadBase{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifierId];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"播放音乐" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onPlay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 20, 100, 30);
}

- (void)loadLyrcs {
    [_mgr loadBase];
    _lyrcs = _mgr.lrcs;
}

- (void)onPlay:(UIButton *)sender {
    [_mgr.player play];
}
    
#pragma mark -- tableView datasource
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _lyrcs.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierId forIndexPath:indexPath];
    YDOneLyricUnit *unit= _lyrcs[indexPath.row];
    cell.textLabel.text = unit.lyric;
    return cell;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}


@end
