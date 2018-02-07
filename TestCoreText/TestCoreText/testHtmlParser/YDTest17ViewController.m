//
//  YDTest17ViewController.m
//  TestCoreText
//
//  Created by mac on 7/2/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YDTest17ViewController.h"
#import <libxml/HTMLparser.h>
#import "YDHTMLParser.h"

@interface YDTest17ViewController ()
{
    htmlSAXHandler _handler; //处理
    htmlParserCtxtPtr _parserContext;
}

@end

void testStartElement(void *ctx, const xmlChar *name, const xmlChar **atts) {
    NSLog(@"start element");
}

@implementation YDTest17ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initParser];
}

- (void)initParser {
    NSString *readmePath;
    NSString *html;
    
    readmePath = @"http://localhost:8080/index.html";
    NSError *error = nil;
    html = [NSString stringWithContentsOfURL:[NSURL URLWithString:readmePath] encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"yd error :%@",error);
    }
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
// element html , data 2byte
    
    void *dataBytes = (char *)[data bytes];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
