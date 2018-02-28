//
//  YDChainReponsibilityViewController.m
//  TestCoreText
//
//  Created by mac on 28/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDChainReponsibilityViewController.h"
#import "AttackHandler.h"
#import "Avatar.h"
#import "MetalArmor.h"
#import "CrystalShield.h"
#import "SwordAttack.h"
#import "MaginfireAttack.h"
#import "LightAttack.h"

@interface YDChainReponsibilityViewController ()

@end

@implementation YDChainReponsibilityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    AttackHandler *avatar = [Avatar new];
    
//     一种防御
    AttackHandler *metalArmoredAvatar = [MetalArmor new];
    metalArmoredAvatar.nextHandler = avatar;
    
//    1种防御
    AttackHandler *superAvatar = [CrystalShield new];
    superAvatar.nextHandler = metalArmoredAvatar;
    
//    下面开始工具
    NSLog(@"建 开始工具");
    Attack *swordAttack = [SwordAttack new];
    [superAvatar handlerAttack:swordAttack];
    
    NSLog(@"火开始攻击");
    Attack *mgicFireAttack = [MaginfireAttack new];
    [superAvatar handlerAttack:mgicFireAttack];
    
    NSLog(@"闪电开始攻击");
    Attack *lightAttack = [LightAttack new];
    [superAvatar handlerAttack:lightAttack];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
