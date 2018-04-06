//
//  StrategyViewController.m
//  Strategy
//
//  Created by Carlo Chung on 8/2/10.
//  Copyright Carlo Chung 2010. All rights reserved.
//

#import "StrategyViewController.h"


@implementation StrategyViewController

@synthesize numericTextField, alphaTextField;

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

#pragma mark -
#pragma mark UITextFieldDelegate methods

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  if ([textField isKindOfClass:[CustomTextField class]])
  {
    [(CustomTextField*)textField validate];
  }
}

@end
