//
//  ViewController.h
//  TestCoreText
//
//  Created by mac on 22/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol vcDelegate <NSObject>

- (void)doText:(NSString *)text;

@end

@interface ViewController : UIViewController

@property (nonatomic, weak) id <vcDelegate> delegate;

@end

