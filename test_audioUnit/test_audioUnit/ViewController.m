//
//  ViewController.m
//  test_audioUnit
//
//  Created by Aka on 2018/5/9.
//  Copyright © 2018年 Aka. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#import "YDPerson.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[YDPerson new] sentd];
}


- (void)testCreateAudioUnit {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    NSLog(@"error :%@",error);
    
    NSTimeInterval bufferDuration = 0.2f;
    [audioSession setPreferredIOBufferDuration:bufferDuration error:&error];
    NSLog(@"buffer duration ; %@",error);
    
    double hwSampleRate = 44100.0;
    [audioSession setPreferredSampleRate:hwSampleRate error:&error];
    NSLog(@"sample rate error :%@",error);
    
    [audioSession setActive:YES error:&error];
    NSLog(@"active erroro :%@",error);
    
    //     描述一个audio unit (description 唯一的标识)
    AudioComponentDescription ioUnitDescription;
    ioUnitDescription.componentType = kAudioUnitType_Output;
    ioUnitDescription.componentSubType = kAudioUnitSubType_RemoteIO;
    ioUnitDescription.componentManufacturer  = kAudioUnitManufacturer_Apple;
    ioUnitDescription.componentFlags =0;
    ioUnitDescription.componentFlagsMask = 0;
    
    //    (1)裸数据的方式构造
    AudioComponent ioUnitRef = AudioComponentFindNext(NULL, &ioUnitDescription);
    AudioUnit iosUnitInstance;
    AudioComponentInstanceNew(ioUnitRef, &iosUnitInstance);
    
    //    （2）的使用AUGraph （、AUNode）
    AUGraph processingGraph;
    NewAUGraph(&processingGraph);
    AUNode ioNode;
    AUGraphAddNode(processingGraph, &ioUnitDescription, &ioNode);
    AUGraphOpen(processingGraph);
    AudioUnit ioUnit;
    AUGraphNodeInfo(processingGraph, ioNode, NULL, &ioUnit);
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
