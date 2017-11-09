//
//  YDSortViewController.m
//  test_effective
//
//  Created by Aka on 2017/11/9.
//  Copyright © 2017年 forest. All rights reserved.
//

#import "YDSortViewController.h"
#import "YDPerson.h"

@interface YDSortViewController ()

@end

@implementation YDSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    YDPerson *person1 = [YDPerson new];
    person1.name = @"Smith John";
    person1.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:300];
  
    YDPerson *person2 = [YDPerson new];
    person2.name = @"Andersen Jane";
    person2.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:500];
    
    YDPerson *person3 = [YDPerson new];
    person3.name = @"amith John";
    person3.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:1000];
    
    YDPerson *person4 = [YDPerson new];
    person4.name = @"nmith John";
    person4.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:1500];
    
    YDPerson *person5 = [YDPerson new];
    person5.name = @"kmith John";
    person5.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:3000];
    
    NSArray<YDPerson *> *arrs = @[person1, person5, person2, person4, person3];
    for (YDPerson *person in arrs) {
        NSLog(@"person name: %@, date : %@",person.name, person.dateOfBirth);
    }
    NSLog(@"——————————————————————");
    NSArray<YDPerson *> *sortedArray = [arrs sortedArrayUsingComparator:^NSComparisonResult(YDPerson *p1, YDPerson *p2){
        return [p1.dateOfBirth compare:p2.dateOfBirth];
    }];
    
    for (YDPerson *person in sortedArray) {
        NSLog(@"person name: %@, date : %@",person.name, person.dateOfBirth);
    }
    
    NSLog(@"——————————————————————");
    NSLog(@"——————————————————————");

    NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateOfBirth" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:firstDescriptor, nil];
    NSArray *sortedArray1 = [arrs sortedArrayUsingDescriptors:sortDescriptors];
    for (YDPerson *person in sortedArray1) {
        NSLog(@"person name: %@, date : %@",person.name, person.dateOfBirth);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
