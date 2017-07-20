//
//  CharacteristicViewController.h
//  YDBlueTooth
//
//  Created by Aka on 2017/7/20.
//  Copyright © 2017年 forest. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDBlueToothMgr;

@interface CharacteristicViewController : UIViewController

- (CharacteristicViewController *(^)(YDBlueToothMgr *mgr))deliverMgr;


@end
