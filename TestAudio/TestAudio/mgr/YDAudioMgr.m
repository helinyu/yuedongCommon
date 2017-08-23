//
//  YDAudioMgr.m
//  Test_Audio
//
//  Created by Aka on 2017/8/22.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YDAudioMgr.h"
#import "YDLyricAnalyzer.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "YDOneLyricUnit.h"
#import <notify.h>

@interface YDAudioMgr ()<UITableViewDataSource,UITableViewDelegate>
{
    id _playerTimeObserver;
    BOOL _isDragging;
    UIImage * _lastImage;//最后一次锁屏之后的歌词海报
}

//用来显示锁屏歌词
@property (nonatomic, strong) UITableView * lockScreenTableView;
//锁屏图片视图,用来绘制带歌词的image
@property (nonatomic, strong) UIImageView * lrcImageView;;


@end

@implementation YDAudioMgr

+ (instancetype)shared {
    static id singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}
    
- (void)loadBase {
    [self _getLrcArray];
}
    
- (AVPlayer *)player {
    if (_player == nil) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"多幸运" ofType:@"mp3"];
        _player = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:path]];
    }
    return _player;
}
    
//获得歌词数组
- (NSArray *)_getLrcArray{
    YDLyricAnalyzer *analyzer = [YDLyricAnalyzer new];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"多幸运" ofType:@"txt"];
    self.lrcs =  [analyzer analyzerLrcBylrcString:[NSString  stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil]];
    NSLog(@"self.lrcs count; %lu",(unsigned long)self.lrcs.count);
    return self.lrcs;
}
    
- (void)createRemoteCommandCenter {
    MPRemoteCommandCenter *cmdCenter = [MPRemoteCommandCenter sharedCommandCenter];
    [cmdCenter.nextTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        NSLog(@"下一首");
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    //在控制台拖动进度条调节进度（仿QQ音乐的效果）
    [cmdCenter.changePlaybackPositionCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        CMTime totlaTime = self.player.currentItem.duration;
        MPChangePlaybackPositionCommandEvent * playbackPositionEvent = (MPChangePlaybackPositionCommandEvent *)event;
        [self.player seekToTime:CMTimeMake(totlaTime.value*playbackPositionEvent.positionTime/CMTimeGetSeconds(totlaTime), totlaTime.timescale) completionHandler:^(BOOL finished) {
        }];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
}

- (void)dealloc {
    [self removeObserver];
}
    //移除观察者
- (void)removeObserver{
    
    [self.player removeTimeObserver:_playerTimeObserver];
    _playerTimeObserver = nil;
    
    MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    [commandCenter.likeCommand removeTarget:self];
    [commandCenter.dislikeCommand removeTarget:self];
    [commandCenter.bookmarkCommand removeTarget:self];
    [commandCenter.nextTrackCommand removeTarget:self];
    [commandCenter.skipForwardCommand removeTarget:self];
    [commandCenter.changePlaybackPositionCommand removeTarget:self];
}
    
//在具体的控制器或其它类中捕获处理远程控制事件,当远程控制事件发生时触发该方法, 该方法属于UIResponder类，iOS 7.1 之前经常用
- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    NSLog(@"%ld",(long)event.type);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"songRemoteControlNotification" object:self userInfo:@{@"eventSubtype":@(event.subtype)}];
}
    
    //播放控制和监测
- (void)playControl{
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    __weak typeof (self) wSelf = self;
    _playerTimeObserver = [wSelf.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 10) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {

        //监听锁屏状态 lock=1则为锁屏状态
        NSLog(@"time value : %lld, timescale : %d, time flag :%d, second :%lld",time.value,time.timescale,time.flags,time.value/time.timescale);
        uint64_t locked;
        __block int token = 0;
        notify_register_dispatch("com.apple.springboard.lockstate",&token,dispatch_get_main_queue(),^(int t){
            NSLog(@"noitify lock state");
        });
        notify_get_state(token, &locked);

        //监听屏幕点亮状态 screenLight = 1则为变暗关闭状态
        uint64_t screenLight;
        __block int lightToken = 0;
        notify_register_dispatch("com.apple.springboard.hasBlankedScreen",&lightToken,dispatch_get_main_queue(),^(int t){
            NSLog(@"lock the state");
        });
        notify_get_state(lightToken, &screenLight);

        BOOL isShowLyricsPoster = NO;
        if (screenLight == 0 && locked == 1) {
            //点亮且锁屏时
            isShowLyricsPoster = YES;
        }else if(screenLight){
            return;
        }
        
        CGFloat currentTime = CMTimeGetSeconds(time);
        CMTime total = self.player.currentItem.duration;
        CGFloat totalTime = CMTimeGetSeconds(total);
        NSLog(@"currrent Time : %f , totalTime :%f",currentTime,totalTime);
        
        for ( int i = (int)(self.lrcs.count - 1); i >= 0 ;i--) {
            YDOneLyricUnit * lrc = self.lrcs[i];
            if (lrc.time < currentTime) {
                if (isShowLyricsPoster) {
                    [self.lockScreenTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
                }else{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"lyrcScroll" object:@{@"backgroundLight":@(NO),@"row":@(i)}];
                }
                break;
            }
        }
  
        //展示锁屏歌曲信息，上面监听屏幕锁屏和点亮状态的目的是为了提高效率
        [self showLockScreenTotaltime:totalTime andCurrentTime:currentTime isShow:isShowLyricsPoster];
    
    }];
}
    
- (void)showLockScreenTotaltime:(float)totalTime andCurrentTime:(float)currentTime isShow:(BOOL)isShow {
    
    NSMutableDictionary * songDict = [[NSMutableDictionary alloc] init];
    //设置歌曲题目
    [songDict setObject:@"多幸运" forKey:MPMediaItemPropertyTitle];
    //设置歌手名
    [songDict setObject:@"韩安旭" forKey:MPMediaItemPropertyArtist];
    //设置专辑名
    [songDict setObject:@"专辑名" forKey:MPMediaItemPropertyAlbumTitle];
    //设置歌曲时长
    [songDict setObject:[NSNumber numberWithDouble:totalTime]  forKey:MPMediaItemPropertyPlaybackDuration];
    //设置已经播放时长
    [songDict setObject:[NSNumber numberWithDouble:currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];

    UIImage *lrcImage = [UIImage imageNamed:@"backgroundImage5.jpg"];
    if (isShow) {
        
        //制作带歌词的海报
        if (!_lrcImageView) {
            _lrcImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480,800)];
        }
        
        //主要为了把歌词绘制到图片上，已达到更新歌词的目的
        [_lrcImageView addSubview:self.lockScreenTableView];
        _lrcImageView.image = lrcImage;
        _lrcImageView.backgroundColor = [UIColor blackColor];
        
        //获取添加了歌词数据的海报图片
        UIGraphicsBeginImageContextWithOptions(_lrcImageView.frame.size, NO, 0.0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [_lrcImageView.layer renderInContext:context];
        lrcImage = UIGraphicsGetImageFromCurrentImageContext();
        _lastImage = lrcImage;
        UIGraphicsEndImageContext();
        
    }else{
        if (_lastImage) {
            lrcImage = _lastImage;
        }
    }
    
    //设置显示的海报图片
    [songDict setObject:[[MPMediaItemArtwork alloc] initWithImage:lrcImage]
                 forKey:MPMediaItemPropertyArtwork];
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songDict];
    
}

- (UITableView *)lockScreenTableView {
    if (!_lockScreenTableView) {
        _lockScreenTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 800 - 44 * 7 + 20, 480, 44 * 3) style:UITableViewStyleGrouped];
        _lockScreenTableView.dataSource = self;
        _lockScreenTableView.delegate = self;
        _lockScreenTableView.separatorStyle = NO;
        _lockScreenTableView.backgroundColor = [UIColor clearColor];
        [_lockScreenTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _lockScreenTableView;
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _lrcs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    YDOneLyricUnit *unit = _lrcs[indexPath.row];
    cell.textLabel.text = unit.lyric;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.f;
}


@end
