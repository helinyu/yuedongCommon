//
//  ViewController.m
//  testFMDB
//
//  Created by Aka on 2017/8/12.
//  Copyright © 2017年 Aka. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"create database" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onCreateDBClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 30);

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)onCreateDBClicked {

    NSFileManager *fileManager = [[NSFileManager alloc]init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *createPath = [NSString stringWithFormat:@"%@/data",pathDocuments];
//    if (![[NSFileManager defaultManager]fileExistsAtPath:createPath]) {
//        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
//
//    }else{
//        NSLog(@"有这个文件了");
//    }

    [FMDatabase databaseWithPath:createPath];
    
    
}

@end
