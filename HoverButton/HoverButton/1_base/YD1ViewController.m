//
//  YD1ViewController.m
//  HoverButton
//
//  Created by Aka on 2017/8/31.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "YD1ViewController.h"
#import "YD2ViewController.h"

@interface YD1ViewController ()

@property (nonatomic, strong) UIWindow *externalWindow;

@property (nonatomic, strong) UIWindow *hoverWindow;

@property (nonatomic, strong) UIButton *convertPointBtn;

@end

@implementation YD1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor blueColor];
    
//    YD2ViewController *vc2 = [YD2ViewController new];
//    [self configureExternalDisplayAndShowWithContent:vc2];
    
//    [self testConvertPoint];
    
    [self alertAWindow];
}

- (void)alertAWindow {
    _hoverWindow = [[UIWindow alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    _hoverWindow.windowLevel = UIWindowLevelAlert + 2;
    _hoverWindow.screen = [UIScreen mainScreen];
    _hoverWindow.backgroundColor = [UIColor purpleColor];
    [_hoverWindow makeKeyAndVisible];
    _hoverWindow.hidden  = YES;
    
//    resign override in the subclass
    
//    NSLog(@"now _hover window is key : %d",_hoverWindow.isKeyWindow);
//    [_hoverWindow becomeKeyWindow];
//    NSLog(@"now _hover window is key : %d",_hoverWindow.isKeyWindow);
//    [_hoverWindow makeKeyWindow];
//    NSLog(@"now _hover window is key : %d",_hoverWindow.isKeyWindow);
//    [_hoverWindow resignKeyWindow];
//    NSLog(@"now _hover window is key : %d",_hoverWindow.isKeyWindow);
//    NSLog(@"_______");
//    [_hoverWindow makeKeyAndVisible];
//    
//    _convertPointBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [_convertPointBtn setTitle:@"转变点坐标" forState:UIControlStateNormal];
//    [_convertPointBtn addTarget:self action:@selector(testConvertPoint) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_convertPointBtn];
//    _convertPointBtn.frame = CGRectMake(0, 0, 50, 100);
//    _convertPointBtn.backgroundColor = [UIColor redColor];
//    [_hoverWindow addSubview:_convertPointBtn];
//    
//    NSLog(@"now _hover window is key : %d",_hoverWindow.isKeyWindow);
//    [_hoverWindow resignKeyWindow];
//    NSLog(@"now _hover window is key : %d",_hoverWindow.isKeyWindow);
//     [_hoverWindow resignKeyWindow];
//    NSLog(@"now _hover window is key : %d",_hoverWindow.isKeyWindow);
//    [_hoverWindow makeKeyAndVisible];
//    NSLog(@"now _hover window is key : %d",_hoverWindow.isKeyWindow);
//    [_hoverWindow resignKeyWindow];
//    NSLog(@"now _hover window is key : %d",_hoverWindow.isKeyWindow);
//    [_hoverWindow makeKeyWindow];
//    NSLog(@"now _hover window is key : %d",_hoverWindow.isKeyWindow);
//    [_hoverWindow resignKeyWindow];
//    NSLog(@"hover windown level :%f",_hoverWindow.windowLevel);
//    NSLog(@"screen :%@",_hoverWindow.screen);
//    NSLog(@"screen root VC :%@",_hoverWindow.rootViewController);
}

//- (void)sendEvent:(UIEvent *)event;                    // called by UIApplication to dispatch events to views inside the window

- (void)testConvertPoint {
    NSLog(@"转变坐标");
    CGRect rect =  [_hoverWindow convertRect:CGRectMake(50, 50, 50, 50) toWindow:nil];
    NSLog(@" to window : rect x :%f ,y :%f , width; %f, height :%f",rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
// 应该就是针对当前所在的screen
    
    CGRect rect1 = [_hoverWindow convertRect:CGRectMake(-50, -50, 50, 50) fromWindow:nil];
    NSLog(@"from window : rect x:%f, y :%f, width :%f, height :%f",rect1.origin.x, rect1.origin.y, rect1.size.width, rect.size.height);
//    将当前screen 上面的坐标转化为当前的window上的坐标
    
    CGPoint point1 = [_hoverWindow convertPoint:CGPointMake(50, 50) toWindow:nil];
    NSLog(@"to window : x :%f, y: %f",point1.x,point1.y);
    
    CGPoint point2 = [_hoverWindow convertPoint:CGPointMake(50, 50) fromWindow:nil];
    NSLog(@"from window x :%f , y : %f",point2.x, point2.y);
}

- (void)configureExternalDisplayAndShowWithContent:(UIViewController*)rootVC
{
    NSArray *screens = [UIScreen screens];
    if ([screens count] > 1) {
        for (UIScreen *screen in screens) {
            NSLog(@"size ;widht : %f , height :%f ,x :%f ,y:%f",screen.bounds.size.width,screen.bounds.size.height,screen.bounds.origin.x,screen.bounds.origin.y);
        }
        UIScreen* externalScreen = [[UIScreen screens] objectAtIndex:1];
        CGRect screenBounds = externalScreen.bounds;
        
        // Configure the window
        self.externalWindow = [[UIWindow alloc] initWithFrame:screenBounds];
        self.externalWindow.windowLevel = UIWindowLevelNormal;
        self.externalWindow.screen = externalScreen;
        
        // Install the root view controller
        self.externalWindow.rootViewController = rootVC;

        // Show the window, but do not make it key.
        self.externalWindow.hidden = NO;
    }
    else {
        NSLog(@"only a screen ");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
