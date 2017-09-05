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
#import "YDAudioNodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *lyrcs;

@property (nonatomic, strong) YDAudioMgr *mgr;

@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) AVAudioPlayer *player0;
@property (nonatomic, strong) AVAudioPlayer *player1;

@property (nonatomic, strong) AVAudioSession *audioSession;

@end

static NSString *const reuseIdentifierId = @"reuse.identifier.id";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self loadBase];
    [self createComponentForTestWeb];
    [self onSetAudioPlayControl];
    [self registerReceivingEvents];
    [self createRemoteCommandCenter];
    
//    [self createActviceComponent];
}

- (void)createActviceComponent  {
    
    UIButton *guimiBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [guimiBtn setTitle:@"鬼迷心窍" forState:UIControlStateNormal];
    [guimiBtn addTarget:self action:@selector(onPlayGuimi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:guimiBtn];
    guimiBtn.frame = CGRectMake(10, 180, 100, 40);
    
    UIButton *activeNoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [activeNoBtn setTitle:@"active NO" forState:UIControlStateNormal];
    [activeNoBtn addTarget:self action:@selector(onActiveNO) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:activeNoBtn];
    activeNoBtn.frame = CGRectMake(10, 40, 100, 30);
    
    UIButton *activeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [activeBtn setTitle:@"active " forState:UIControlStateNormal];
    [activeBtn addTarget:self action:@selector(onActiveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:activeBtn];
    activeBtn.frame = CGRectMake(40, 80, 100, 30);

}

- (void)onActiveNO {
    AudioSessionSetActiveWithFlags(FALSE, kAudioSessionSetActiveFlag_NotifyOthersOnDeactivation);
    NSError *error;
    BOOL result = [[AVAudioSession sharedInstance] setActive:NO error:&error];
    NSLog(@"result : %d",result);
    NSLog(@"error : %@", error);
}

- (void)onActiveClick {
//    AudioSessionSetActive(TRUE);
    NSError *error;
    BOOL result = [[AVAudioSession sharedInstance] setActive:NO error:&error];
    NSLog(@"result : %d",result);
    NSLog(@"error : %@", error);
    
}

- (void)createComponentForTestWeb {
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [btn setTitle:@"播放" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(onAudioNodePlay:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    btn.frame = CGRectMake(10, 10, 100, 40);
    
    UIButton *settingBackGroundBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [settingBackGroundBtn setTitle:@"play back" forState:UIControlStateNormal];
    [settingBackGroundBtn addTarget:self action:@selector(setAackGroundPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBackGroundBtn];
    settingBackGroundBtn.frame = CGRectMake(10, 30, 100, 20);
    
    UIButton *AmbientBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [AmbientBtn setTitle:@"Ambient" forState:UIControlStateNormal];
    [AmbientBtn addTarget:self action:@selector(onAmbient) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:AmbientBtn];
    AmbientBtn.frame = CGRectMake(10, 60, 100, 20);
    
    UIButton *SoloAmbientBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [SoloAmbientBtn setTitle:@"SoloAmbientBtn" forState:UIControlStateNormal];
    [SoloAmbientBtn addTarget:self action:@selector(onSoloAmbient) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SoloAmbientBtn];
    SoloAmbientBtn.frame = CGRectMake(10, 90, 100, 40);

    UIButton *PlayAndRecordBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [PlayAndRecordBtn setTitle:@"PlayAndRecord" forState:UIControlStateNormal];
    [PlayAndRecordBtn addTarget:self action:@selector(onPlayAndRecord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:PlayAndRecordBtn];
    PlayAndRecordBtn.frame = CGRectMake(10, 120, 100, 40);

    UIButton *aipingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [aipingBtn setTitle:@"爱拼才会赢" forState:UIControlStateNormal];
    [aipingBtn addTarget:self action:@selector(onPlayAiPing) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aipingBtn];
    aipingBtn.frame = CGRectMake(10, 150, 100, 40);

    UIButton *guimiBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [guimiBtn setTitle:@"鬼迷心窍" forState:UIControlStateNormal];
    [guimiBtn addTarget:self action:@selector(onPlayGuimi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:guimiBtn];
    guimiBtn.frame = CGRectMake(10, 180, 100, 40);
    
    UIButton *fengjixuBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [fengjixuBtn setTitle:@"风继续吹" forState:UIControlStateNormal];
    [fengjixuBtn addTarget:self action:@selector(onPlayFengjixu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fengjixuBtn];
    fengjixuBtn.frame = CGRectMake(10, 210, 100, 40);
    
    UIButton *stopaipingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [stopaipingBtn setTitle:@"停止爱拼才会赢" forState:UIControlStateNormal];
    [stopaipingBtn addTarget:self action:@selector(onPlayAiPingstop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopaipingBtn];
    stopaipingBtn.frame = CGRectMake(10, 260, 100, 40);
  
    UIButton *stopguimixinqiaoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [stopguimixinqiaoBtn setTitle:@"停止鬼迷心窍" forState:UIControlStateNormal];
    [stopguimixinqiaoBtn addTarget:self action:@selector(onPlayguimiStop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopguimixinqiaoBtn];
    stopguimixinqiaoBtn.frame = CGRectMake(10, 310, 100, 40);
    
    UIButton *stopFengjixuchuiBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [stopFengjixuchuiBtn setTitle:@"停止风继续吹" forState:UIControlStateNormal];
    [stopFengjixuchuiBtn addTarget:self action:@selector(onPlayfengjixuStop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopFengjixuchuiBtn];
    stopFengjixuchuiBtn.frame = CGRectMake(10, 360, 100, 40);

    UIButton *activeNoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [activeNoBtn setTitle:@"active NO" forState:UIControlStateNormal];
    [activeNoBtn addTarget:self action:@selector(onActiveNo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:activeNoBtn];
    activeNoBtn.frame = CGRectMake(10, 390, 100, 40);
    
    UIButton *activeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [activeBtn setTitle:@"active YES" forState:UIControlStateNormal];
    [activeBtn addTarget:self action:@selector(onActiveYes) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:activeBtn];
    activeBtn.frame = CGRectMake(10, 420, 100, 40);
    
    UIButton *reactiveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [reactiveBtn setTitle:@"reactive" forState:UIControlStateNormal];
    [reactiveBtn addTarget:self action:@selector(setReactiveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reactiveBtn];
    reactiveBtn.frame = CGRectMake(10, 560, 100, 40);

    UIButton *getProperty = [UIButton buttonWithType:UIButtonTypeSystem];
    [getProperty setTitle:@"getProperty" forState:UIControlStateNormal];
    [getProperty addTarget:self action:@selector(getPropertyClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getProperty];
    getProperty.frame = CGRectMake(10, 610, 100, 40);
    
    UIButton *kAudioSessionProperty_PreferredHardwareSampleRatebtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [kAudioSessionProperty_PreferredHardwareSampleRatebtn setTitle:@"sample rate btn" forState:UIControlStateNormal];
    [kAudioSessionProperty_PreferredHardwareSampleRatebtn addTarget:self action:@selector(onPreferredHardwareSampleRate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kAudioSessionProperty_PreferredHardwareSampleRatebtn];
    kAudioSessionProperty_PreferredHardwareSampleRatebtn.frame = CGRectMake(120, 50, 200, 40);
    
    UIButton *kAudioSessionProperty_PreferredHardwareIOBufferDurationBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [kAudioSessionProperty_PreferredHardwareIOBufferDurationBtn setTitle:@"IOBufferDurationBtn" forState:UIControlStateNormal];
    [kAudioSessionProperty_PreferredHardwareIOBufferDurationBtn addTarget:self action:@selector(onPreferredHardwareIOBufferDuration) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kAudioSessionProperty_PreferredHardwareIOBufferDurationBtn];
    kAudioSessionProperty_PreferredHardwareIOBufferDurationBtn.frame = CGRectMake(120, 100, 200, 40);
    
    UIButton *kAudioSessionProperty_AudioRouteChangeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [kAudioSessionProperty_AudioRouteChangeBtn setTitle:@"Audio Route Change" forState:UIControlStateNormal];
    [kAudioSessionProperty_AudioRouteChangeBtn addTarget:self action:@selector(onAudioRouteChange) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kAudioSessionProperty_AudioRouteChangeBtn];
    kAudioSessionProperty_AudioRouteChangeBtn.frame = CGRectMake(120, 160, 200, 40);
    
    UIButton *kAudioSessionProperty_ServerDiedBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [kAudioSessionProperty_ServerDiedBtn setTitle:@"Server Died" forState:UIControlStateNormal];
    [kAudioSessionProperty_ServerDiedBtn addTarget:self action:@selector(onServerDied) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kAudioSessionProperty_ServerDiedBtn];
    kAudioSessionProperty_ServerDiedBtn.frame = CGRectMake(120, 210, 200, 40);
    
    UIButton *kAudioSessionProperty_OtherMixableAudioShouldDuckBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [kAudioSessionProperty_OtherMixableAudioShouldDuckBtn setTitle:@"Other Mixable Audio ShouldDuck" forState:UIControlStateNormal];
    [kAudioSessionProperty_OtherMixableAudioShouldDuckBtn addTarget:self action:@selector(onOtherMixableAudioShouldDuck) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kAudioSessionProperty_OtherMixableAudioShouldDuckBtn];
    kAudioSessionProperty_OtherMixableAudioShouldDuckBtn.frame = CGRectMake(120, 260, 200, 40);
    
    UIButton *kAudioSessionProperty_OverrideCategoryMixWithOthersBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [kAudioSessionProperty_OverrideCategoryMixWithOthersBtn setTitle:@"Override Category Mix With Other" forState:UIControlStateNormal];
    [kAudioSessionProperty_OverrideCategoryMixWithOthersBtn addTarget:self action:@selector(onOverrideCategoryMixWithOthers) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kAudioSessionProperty_OverrideCategoryMixWithOthersBtn];
    kAudioSessionProperty_OverrideCategoryMixWithOthersBtn.frame = CGRectMake(120, 310, 200, 40);
    
    UIButton *onOverrideCategoryMixWithOthersNOBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [onOverrideCategoryMixWithOthersNOBtn setTitle:@"Override Category Mix No" forState:UIControlStateNormal];
    [onOverrideCategoryMixWithOthersNOBtn addTarget:self action:@selector(onOverrideCategoryMixWithOthersNO) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:onOverrideCategoryMixWithOthersNOBtn];
    onOverrideCategoryMixWithOthersNOBtn.frame = CGRectMake(10, 450, 200, 40);
 
    UIButton *infoCenterBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [infoCenterBtn setTitle:@"info center" forState:UIControlStateNormal];
    [infoCenterBtn addTarget:self action:@selector(onInfoCenter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoCenterBtn];
    infoCenterBtn.frame = CGRectMake(10, 480, 100, 40);

    UIButton *setSesssionNil = [UIButton buttonWithType:UIButtonTypeSystem];
    [setSesssionNil setTitle:@"session nil" forState:UIControlStateNormal];
    [setSesssionNil addTarget:self action:@selector(onSessionNil) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setSesssionNil];
    setSesssionNil.frame = CGRectMake(10, 510, 100, 40);
    
     UIButton *sessionRescoveryBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [sessionRescoveryBtn setTitle:@"session nil" forState:UIControlStateNormal];
    [sessionRescoveryBtn addTarget:self action:@selector(reconverSesssion) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sessionRescoveryBtn];
    sessionRescoveryBtn.frame = CGRectMake(10, 540, 100, 40);
    
    UIButton *kAudioSessionProperty_OverrideCategoryDefaultToSpeakerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [kAudioSessionProperty_OverrideCategoryDefaultToSpeakerBtn setTitle:@"Override Category Default To Speaker" forState:UIControlStateNormal];
    [kAudioSessionProperty_OverrideCategoryDefaultToSpeakerBtn addTarget:self action:@selector(onOverrideCategoryDefaultToSpeaker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kAudioSessionProperty_OverrideCategoryDefaultToSpeakerBtn];
    kAudioSessionProperty_OverrideCategoryDefaultToSpeakerBtn.frame = CGRectMake(120, 360, 200, 40);
    
    UIButton *kAudioSessionProperty_OverrideCategoryEnableBluetoothInputBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [kAudioSessionProperty_OverrideCategoryEnableBluetoothInputBtn setTitle:@"Override Category Enable Bluetooth" forState:UIControlStateNormal];
    [kAudioSessionProperty_OverrideCategoryEnableBluetoothInputBtn addTarget:self action:@selector(onOverrideCategoryEnableBluetoothInput) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kAudioSessionProperty_OverrideCategoryEnableBluetoothInputBtn];
    kAudioSessionProperty_OverrideCategoryEnableBluetoothInputBtn.frame = CGRectMake(120, 410, 200, 40);
    
    UIButton *kAudioSessionProperty_ModeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [kAudioSessionProperty_ModeBtn setTitle:@"mode btn " forState:UIControlStateNormal];
    [kAudioSessionProperty_ModeBtn addTarget:self action:@selector(onMode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kAudioSessionProperty_ModeBtn];
    kAudioSessionProperty_ModeBtn.frame = CGRectMake(120, 460, 200, 40);
    
    UIButton *kAudioSessionProperty_InputSourceBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [kAudioSessionProperty_InputSourceBtn setTitle:@"InputSource" forState:UIControlStateNormal];
    [kAudioSessionProperty_InputSourceBtn addTarget:self action:@selector(onInputSource) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kAudioSessionProperty_InputSourceBtn];
    kAudioSessionProperty_InputSourceBtn.frame = CGRectMake(120, 500, 200, 40);
    
    UIButton *kAudioSessionProperty_OutputDestinationBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [kAudioSessionProperty_OutputDestinationBtn setTitle:@"Output Destination" forState:UIControlStateNormal];
    [kAudioSessionProperty_OutputDestinationBtn addTarget:self action:@selector(onOutputDestination) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kAudioSessionProperty_OutputDestinationBtn];
    kAudioSessionProperty_OutputDestinationBtn.frame = CGRectMake(120, 540, 200, 40);

    UIButton *kAudioSessionProperty_InputGainScalarBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [kAudioSessionProperty_InputGainScalarBtn setTitle:@"Input Gain Scalar" forState:UIControlStateNormal];
    [kAudioSessionProperty_InputGainScalarBtn addTarget:self action:@selector(onInputGainScalar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kAudioSessionProperty_InputGainScalarBtn];
    kAudioSessionProperty_InputGainScalarBtn.frame = CGRectMake(120, 580, 200, 40);
    
    UIButton *kAudioSessionProperty_AudioCategoryBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [kAudioSessionProperty_AudioCategoryBtn setTitle:@"Audio Category" forState:UIControlStateNormal];
    [kAudioSessionProperty_AudioCategoryBtn addTarget:self action:@selector(onAudioCategory) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:kAudioSessionProperty_AudioCategoryBtn];
    kAudioSessionProperty_AudioCategoryBtn.frame = CGRectMake(120, 620, 200, 40);

}

- (void)onActiveYes {
    AudioSessionSetActive(TRUE);
    NSError *error;
    BOOL result =[[AVAudioSession sharedInstance] setActive:YES error:&error];
    NSLog(@"active yes result : %d, error : %@",result, error);
}

- (void)onActiveNo {
    AudioSessionSetActiveWithFlags(FALSE, kAudioSessionSetActiveFlag_NotifyOthersOnDeactivation);
    NSError *error;
    BOOL result =[[AVAudioSession sharedInstance] setActive:NO error:&error];
    NSLog(@"active yes result : %d ,error ; %@",result, error);
}

- (void)getPropertyClick {
    UInt32 sampleRate;
    UInt32 sampelRateSize = sizeof(sampleRate);
    AudioSessionGetProperty(kAudioSessionProperty_PreferredHardwareSampleRate, &sampelRateSize, &sampleRate);
    if (sampleRate) {
        NSLog(@"sampel ;%u",(unsigned int)sampleRate);
    }
    
    UInt32 HardwareIOBufferDuration;
    UInt32 HardwareIOBufferDurationSize = sizeof(HardwareIOBufferDuration);
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &HardwareIOBufferDurationSize, &HardwareIOBufferDuration);
        NSLog(@"HardwareIOBufferDuration ;%u",(unsigned int)HardwareIOBufferDuration);
    
    UInt32 AudioCategory;
    UInt32 AudioCategorySize = sizeof(AudioCategory);
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &AudioCategorySize, &AudioCategory);
    NSLog(@"AudioCategory ;%u",(unsigned int)AudioCategory);

    UInt32 AudioRouteChange;
    UInt32 AudioRouteChangeSize = sizeof(AudioRouteChange);
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &AudioRouteChangeSize, &AudioRouteChange);
    NSLog(@"AudioRouteChange ;%u",(unsigned int)AudioRouteChange);
    
    UInt32 hardWareRate;
    UInt32 headWareRareSize = sizeof(hardWareRate);
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &headWareRareSize, &hardWareRate);
    NSLog(@"hardWareRate ;%u",(unsigned int)sampleRate);
    
    UInt32 InputNumberChannels;
    UInt32 InputNumberChannelsSize = sizeof(InputNumberChannels);
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &InputNumberChannelsSize, &InputNumberChannels);
    NSLog(@"InputNumberChannels ;%u",(unsigned int)InputNumberChannels);
  
    UInt32 OutputNumberChannels;
    UInt32 OutputNumberChannelsSize = sizeof(OutputNumberChannels);
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &OutputNumberChannelsSize, &OutputNumberChannels);
    NSLog(@"OutputNumberChannels ;%u",(unsigned int)OutputNumberChannels);
    
    UInt32 OutputVolume;
    UInt32 OutputVolumeSize = sizeof(OutputVolume);
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &OutputVolumeSize, &OutputVolume);
    NSLog(@"OutputVolume ;%u",(unsigned int)OutputVolume);
    
    UInt32 InputLatency ;
    UInt32 InputLatencySize = sizeof(InputLatency );
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &InputLatencySize, &InputLatency );
    NSLog(@"InputLatency ;%u",(unsigned int)InputLatency );

    UInt32 OutputLatency ;
    UInt32 OutputLatencySize = sizeof(OutputLatency );
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &OutputLatencySize, &OutputLatency );
    NSLog(@"OutputLatency ;%u",(unsigned int)InputLatency );

    UInt32 IOBufferDuration ;
    UInt32 IOBufferDurationSize = sizeof(IOBufferDuration);
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &IOBufferDurationSize, &IOBufferDuration);
    NSLog(@"OutputLatency ;%u",(unsigned int)IOBufferDuration );

    UInt32 AudioIsPlaying  ;
    UInt32 AudioIsPlayingSize = sizeof(AudioIsPlaying );
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &AudioIsPlayingSize, &AudioIsPlaying );
    NSLog(@"AudioIsPlaying  ;%u",(unsigned int)AudioIsPlaying);

    UInt32 OverrideAudioRoute   ;
    UInt32 OverrideAudioRouteSize  = sizeof(OverrideAudioRoute  );
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &OverrideAudioRouteSize, &OverrideAudioRoute  );
    NSLog(@"OverrideAudioRoute   ;%u",(unsigned int)OverrideAudioRoute );

    UInt32 AudioInputAvailable;
    UInt32 AudioInputAvailableSize  = sizeof(AudioInputAvailable  );
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &AudioInputAvailableSize, &AudioInputAvailable);
    NSLog(@"AudioInputAvailable   ;%u",(unsigned int)AudioInputAvailable );
    
    UInt32 ServerDied;
    UInt32 ServerDiedSize  = sizeof(ServerDied);
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &ServerDiedSize, &ServerDied);
    NSLog(@"ServerDied   ;%u",(unsigned int)ServerDied );

    UInt32 OtherMixableAudioShouldDuck;
    UInt32 OtherMixableAudioShouldDuckSize  = sizeof(OtherMixableAudioShouldDuck);
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &OtherMixableAudioShouldDuckSize, &OtherMixableAudioShouldDuck);
    NSLog(@"ServerDied   ;%u",(unsigned int)OtherMixableAudioShouldDuck );

    UInt32 OverrideCategoryMixWithOthers;
    UInt32 OverrideCategoryMixWithOthersSize  = sizeof(OverrideCategoryMixWithOthers);
    AudioSessionGetProperty(kAudioSessionProperty_OverrideCategoryMixWithOthers, &OverrideCategoryMixWithOthersSize, &OverrideCategoryMixWithOthers);
    NSLog(@"OverrideCategoryMixWithOthers;%u",(unsigned int)OverrideCategoryMixWithOthers );

    UInt32 OverrideCategoryDefaultToSpeaker;
    UInt32 OverrideCategoryDefaultToSpeakerSize  = sizeof(OverrideCategoryDefaultToSpeaker);
    AudioSessionGetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, &OverrideCategoryDefaultToSpeakerSize, &OverrideCategoryDefaultToSpeaker);
    NSLog(@"OverrideCategoryDefaultToSpeaker;%u",(unsigned int)OverrideCategoryDefaultToSpeaker );

    UInt32 OverrideCategoryEnableBluetoothInput;
    UInt32 OverrideCategoryEnableBluetoothInputSize  = sizeof(OverrideCategoryEnableBluetoothInput);
    AudioSessionGetProperty(kAudioSessionProperty_OverrideCategoryEnableBluetoothInput, &OverrideCategoryEnableBluetoothInputSize, &OverrideCategoryEnableBluetoothInput);
    NSLog(@"OverrideCategoryEnableBluetoothInput;%u",(unsigned int)OverrideCategoryEnableBluetoothInput );
    
    UInt32 InterruptionType;
    UInt32 InterruptionTypeSize  = sizeof(InterruptionType);
    AudioSessionGetProperty(kAudioSessionProperty_InterruptionType, &InterruptionTypeSize, &InterruptionType);
    NSLog(@"InterruptionType;%u",(unsigned int)InterruptionType );
    
    UInt32 Mode ;
    UInt32 ModeSize  = sizeof(Mode);
    AudioSessionGetProperty(kAudioSessionProperty_Mode, &ModeSize, &Mode);
    NSLog(@"mode;%u",(unsigned int)Mode );
 
    UInt32 InputSources;
    UInt32 InputSourcesSize  = sizeof(InputSources);
    AudioSessionGetProperty(kAudioSessionProperty_InputSources, &InputSourcesSize, &InputSources);
    NSLog(@"mode;%u",(unsigned int)InputSources );

    UInt32 OutputDestinations;
    UInt32 OutputDestinationsSize  = sizeof(OutputDestinations);
    AudioSessionGetProperty(kAudioSessionProperty_OutputDestinations, &OutputDestinationsSize, &OutputDestinations);
    NSLog(@"mode;%u",(unsigned int)Mode );

    UInt32 InputSourc;
    UInt32 InputSourcSize  = sizeof(InputSourc);
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &InputSourcSize, &InputSourc);
    NSLog(@"InputSourc;%u",(unsigned int)InputSourc );

    UInt32 OutputDestination ;
    UInt32 OutputDestinationSize  = sizeof(OutputDestination);
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &OutputDestinationSize, &OutputDestination );
    NSLog(@"OutputDestination ;%u",(unsigned int)OutputDestination );

    UInt32 InputGainAvailable ;
    UInt32 InputGainAvailableSize  = sizeof(InputGainAvailable);
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &InputGainAvailableSize, &InputGainAvailable );
    NSLog(@"InputGainAvailable ;%u",(unsigned int)InputGainAvailable );

    UInt32 InputGainScalar ;
    UInt32 InputGainScalarSize  = sizeof(InputGainScalar);
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &InputGainScalarSize, &InputGainScalar);
    NSLog(@"InputGainScalar ;%u",(unsigned int)InputGainScalar);

    UInt32 AudioRouteDescription ;
    UInt32 AudioRouteDescriptionSize  = sizeof(AudioRouteDescription);
    AudioSessionGetProperty(kAudioSessionProperty_CurrentHardwareSampleRate, &AudioRouteDescriptionSize, &AudioRouteDescription);
    NSLog(@"InputGainScalar ;%u",(unsigned int)AudioRouteDescription);
 
    UInt32 OtherAudioIsPlaying ;
    UInt32 OtherAudioIsPlayingSize  = sizeof(OtherAudioIsPlaying);
    AudioSessionGetProperty(kAudioSessionProperty_OtherAudioIsPlaying, &OtherAudioIsPlayingSize, &OtherAudioIsPlaying);
    NSLog(@"OtherAudioIsPlaying ;%u",(unsigned int)OtherAudioIsPlaying);
}

- (void)onSessionNil {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    self.audioSession = session;
    [session setActive:NO error:nil];
    session = nil;
}

- (void)reconverSesssion {
    [self.audioSession setActive:YES error:nil];
    [self.audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)onInfoCenter {
    MPNowPlayingInfoCenter *infoCenter = [MPNowPlayingInfoCenter defaultCenter];
    NSDictionary<NSString *, id> *infos =  infoCenter.nowPlayingInfo;
    NSLog(@"infos : %@ , title : %@",infos,infos[@"title"]);
    MPMediaItemArtwork *artWork = infos[@"artwork"];
    NSLog(@"artwork : %@",artWork);
}

- (void)setReactiveClick {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:NO error:nil];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self createRemoteCommandCenter];
}

- (void)setSoloClick {
    NSError *error  = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:&error];
    if (error) {
        NSLog(@"设置solo失败");
        return;
    }
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)setAackGroundPlay {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    BOOL success = NO;
    success = [session setActive:YES error:&error];
    if (!success) NSLog(@"error setActive : %@", error);
    
    [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    if (error) {
        NSLog(@"error for background");
        return;
    }
}

- (void)onAmbient {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    BOOL success = NO;
    success = [session setActive:YES error:&error];
    if (!success) NSLog(@"error setActive : %@", error);
    
    [session setCategory:AVAudioSessionCategoryAmbient error:&error];
    if (error) {
        NSLog(@"error for background");
        return;
    }
}

- (void)onSoloAmbient {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    BOOL success = NO;
    success = [session setActive:YES error:&error];
    if (!success) NSLog(@"error setActive : %@", error);
    
    [session setCategory:AVAudioSessionCategorySoloAmbient error:&error];
    if (error) {
        NSLog(@"error for background");
        return;
    }
}

- (void)onPlayAndRecord {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    BOOL success = NO;
    success = [session setActive:YES error:&error];
    if (!success) NSLog(@"error setActive : %@", error);
    
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (error) {
        NSLog(@"error for background");
        return;
    }
}

- (void)onPreferredHardwareSampleRate {
    UInt32 allowMixWithOthers = YES;
    OSStatus result = AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareSampleRate,sizeof(allowMixWithOthers), &allowMixWithOthers);
    NSLog(@"result : %d",result);
}

- (void)onPreferredHardwareIOBufferDuration {
    UInt32 allowMixWithOthers = YES;
    OSStatus result = AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareIOBufferDuration,sizeof(allowMixWithOthers), &allowMixWithOthers);
    NSLog(@"result : %d",result);
}

- (void)onAudioRouteChange {
    UInt32 allowMixWithOthers = YES;
    OSStatus result = AudioSessionSetProperty(kAudioSessionProperty_AudioRouteChange,sizeof(allowMixWithOthers), &allowMixWithOthers);
    NSLog(@"result : %d",result);
}

- (void)onServerDied {
    UInt32 allowMixWithOthers = YES;
    OSStatus result = AudioSessionSetProperty(kAudioSessionProperty_ServerDied,sizeof(allowMixWithOthers), &allowMixWithOthers);
    NSLog(@"result : %d",result);
}

- (void)onOtherMixableAudioShouldDuck {
    UInt32 allowMixWithOthers = YES;
    OSStatus result = AudioSessionSetProperty(kAudioSessionProperty_OtherMixableAudioShouldDuck,sizeof(allowMixWithOthers), &allowMixWithOthers);
    NSLog(@"result : %d",result);
}

- (void)onOverrideCategoryMixWithOthers {
    UInt32 allowMixWithOthers = YES;
    OSStatus result = AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryMixWithOthers,sizeof(allowMixWithOthers), &allowMixWithOthers);
    NSLog(@"result : %d",result);
    [self createRemoteCommandCenter];
}

- (void)onOverrideCategoryMixWithOthersNO {
    UInt32 allowMixWithOthers = NO;
    OSStatus result = AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryMixWithOthers,sizeof(allowMixWithOthers), &allowMixWithOthers);
    NSLog(@"result : %d",result);
}

- (void)onOverrideCategoryDefaultToSpeaker {
    UInt32 allowMixWithOthers = YES;
    OSStatus result = AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker,sizeof(allowMixWithOthers), &allowMixWithOthers);
    NSLog(@"result : %d",result);
}

- (void)onOverrideCategoryEnableBluetoothInput {
    UInt32 allowMixWithOthers = YES;
    OSStatus result = AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryEnableBluetoothInput,sizeof(allowMixWithOthers), &allowMixWithOthers);
    NSLog(@"result : %d",result);
}

- (void)onMode {
    UInt32 allowMixWithOthers = YES;
    OSStatus result = AudioSessionSetProperty(kAudioSessionProperty_Mode,sizeof(allowMixWithOthers), &allowMixWithOthers);
    NSLog(@"result : %d",result);
}

- (void)onInputSource {
    UInt32 allowMixWithOthers = YES;
    OSStatus result = AudioSessionSetProperty(kAudioSessionProperty_InputSource,sizeof(allowMixWithOthers), &allowMixWithOthers);
    NSLog(@"result : %d",result);
}

- (void)onOutputDestination {
    UInt32 allowMixWithOthers = YES;
    OSStatus result = AudioSessionSetProperty(kAudioSessionProperty_OutputDestination,sizeof(allowMixWithOthers), &allowMixWithOthers);
    NSLog(@"result : %d",result);
}

- (void)onInputGainScalar {
    UInt32 allowMixWithOthers = YES;
    OSStatus result = AudioSessionSetProperty(kAudioSessionProperty_InputGainScalar,sizeof(allowMixWithOthers), &allowMixWithOthers);
    NSLog(@"result : %d",result);
}

- (void)onAudioCategory {
    UInt32 allowMixWithOthers = YES;
    OSStatus result = AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,sizeof(allowMixWithOthers), &allowMixWithOthers);
    NSLog(@"result : %d",result);
}

- (void)createRemoteCommandCenter {
    MPRemoteCommandCenter *cmdCenter = [MPRemoteCommandCenter sharedCommandCenter];
    __weak typeof (self) wSelf = self;
    [cmdCenter.playCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        NSLog(@"播放");
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    [cmdCenter.pauseCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        NSLog(@"暂停播放");
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    [cmdCenter.nextTrackCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        NSLog(@"下一个");
        return MPRemoteCommandHandlerStatusSuccess;
    }];
    
    //在控制台拖动进度条调节进度（仿QQ音乐的效果）
    [cmdCenter.changePlaybackPositionCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
        //        CMTime totlaTime = self.player.currentItem.duration;
        //        MPChangePlaybackPositionCommandEvent * playbackPositionEvent = (MPChangePlaybackPositionCommandEvent *)event;
        //        [self.player seekToTime:CMTimeMake(totlaTime.value*playbackPositionEvent.positionTime/CMTimeGetSeconds(totlaTime), totlaTime.timescale) completionHandler:^(BOOL finished) {
        //        }];
        return MPRemoteCommandHandlerStatusSuccess;
    }];
}

- (void)onSetAudioPlayControl {
    NSMutableDictionary * songDict = [[NSMutableDictionary alloc] init];
    //设置歌曲题目
    [songDict setObject:@"多幸运" forKey:MPMediaItemPropertyTitle];
    //设置歌手名
    [songDict setObject:@"韩安旭" forKey:MPMediaItemPropertyArtist];
    //设置专辑名
    [songDict setObject:@"专辑名" forKey:MPMediaItemPropertyAlbumTitle];
    
    UIImage *lrcImage = [UIImage imageNamed:@"backgroundImage5.jpg"];
    //设置显示的海报图片
    [songDict setObject:[[MPMediaItemArtwork alloc] initWithImage:lrcImage]
                 forKey:MPMediaItemPropertyArtwork];
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songDict];
}

- (void)dealloc {
    [self removeObserver];
}
//移除观察者
- (void)removeObserver{
    MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    [commandCenter.likeCommand removeTarget:self];
    [commandCenter.dislikeCommand removeTarget:self];
    [commandCenter.bookmarkCommand removeTarget:self];
    [commandCenter.nextTrackCommand removeTarget:self];
    [commandCenter.skipForwardCommand removeTarget:self];
    [commandCenter.changePlaybackPositionCommand removeTarget:self];
}

- (void)registerReceivingEvents {
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    NSLog(@"%ld",(long)event.subtype);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"songRemoteControlNotification" object:self userInfo:@{@"eventSubtype":@(event.subtype)}];
}

- (void)onPlayAiPing {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"叶启田 - 爱拼才会赢" ofType:@"mp3"];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    [_player play];
}

- (void)onPlayAiPingstop {
    [_player pause];
}

- (void)onPlayguimiStop {
    [_player0 pause];
}

- (void)onPlayfengjixuStop {
    [_player1 pause];
}

- (void)onPlayGuimi {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"李宗盛 - 鬼迷心窍 - live" ofType:@"mp3"];
    _player0 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    [_player0 play];
}

- (void)onPlayFengjixu {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"李克勤 - 风继续吹" ofType:@"mp3"];
    _player1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    [_player1 play];
}

- (void)onAudioNodePlay:(UIButton *)sender {
    YDAudioNodeViewController *vc = [YDAudioNodeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

//测试实现后台播放
- (void)test0 {
    _mgr = [YDAudioMgr shared];
    [self createMainTableView];
    [self __addNotify];
    [self loadBase];
    [self loadLyrcs];
}

- (void)testLink {
    NSString *urlString = @"http://localhost:8000/movie/多幸运.txt";
    NSString *url64String = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url 64 string :%@",url64String);
    NSLog(@"url string : %@",urlString);
    NSString *originString = [url64String stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSString *content = [NSString stringWithContentsOfURL:[NSURL URLWithString:url64String] encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"content : %@",content);
}

- (void)loadBase{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"播放音乐" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onPlay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 20, 100, 30);
}

- (void)__addNotify {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onScroll:) name:@"lyrcScroll" object:nil];
}

- (void)onScroll:(NSNotification *)noti {
    if ([noti.object isKindOfClass:[NSDictionary class]]) {
        NSInteger row = [[noti.object objectForKey:@"row"] integerValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
            [_tableView reloadData];
        });
    }
}

- (void)createMainTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifierId];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
}

- (void)loadLyrcs {
    [_mgr loadBase];
    _lyrcs = _mgr.lrcs;
}

- (void)onPlay:(UIButton *)sender {
    NSLog(@"开始播放音乐");
    [_mgr.player play];
//    [_mgr playControl];
    [_mgr playByTheLyricsTimes];
    [_mgr createRemoteCommandCenter];
}

#pragma mark -- tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _lyrcs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierId forIndexPath:indexPath];
    YDOneLyricUnit *unit= _lyrcs[indexPath.row];
    cell.textLabel.text = unit.oneLyric;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

@end

