//
//  VideoOperate.m
//  ffmpegdemo
//
//  Created by neil on 2017/11/1.
//  Copyright © 2017年 weixin. All rights reserved.
//

#import "VideoOperate.h"
#import "VideoDecode.h"
#import "VideoDisplay.h"
#import "ImageConverter.h"

@interface VideoOperate()<VideoDecodeDelegate>
{
    void (^_imageBlock)(UIImage *image);
}
@property (nonatomic, strong) VideoDecode *decoder;
@property (nonatomic, strong) VideoDisplay *display;


@property (nonatomic, strong) NSString *videoPath;
@end

@implementation VideoOperate

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"shortVideo" ofType:@".mp4"];
        self.videoPath = videoPath;
    }
    return self;
}

- (void)decodeWithImageBlock:(void (^)(UIImage *image))imageBlock {
    _imageBlock = imageBlock;
    if (!self.decoder) {

        VideoDecode *decoder = [[VideoDecode alloc] init];
        self.decoder = decoder;
        self.decoder.delegate = self;
    }
    BOOL success = [self.decoder decodeWithVideoPath:self.videoPath];
    if (success) {
        NSLog(@"decode success");
    } else {
        NSLog(@"decode fail");
    }
}

- (void)outputFrame:(AVFrame *)frame frameSequence:(NSInteger)sequence Size:(CGSize)size {
    if (!_imageBlock) {
        return;
    }
    if (sequence % 30 == 0) {
        UIImage *image = [ImageConverter imageFromAVFrame:frame];
        _imageBlock(image);
    }
    
}

- (void)playVideo {
    if (!self.display) {
        self.display = [[VideoDisplay alloc] init];
    }
    [self.display playVideo:self.videoPath];
}


@end
