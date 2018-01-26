//
//  ViewController.m
//  TestCoreText
//
//  Created by mac on 22/1/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "CTDisplayView.h"
#import "YDCTModel.h"
#import "YDCTParser.h"
#import "UIView+frameAdjust.h"
#import "YDCTConfig.h"
#import "YDCTLinkModel.h"
#import <CoreText/CoreText.h>
#import "ImageViewController.h"
#import "WebContentViewController.h"
#import "YDCTImageModel.h"
#import "YDTransView.h"
#import <DTCoreText.h>
#import "YDHeaderView.h"
#import <DTWebVideoView.h>
#import "Masonry.h"

#import <libxml/list.h>
#import <libxml/HTMLparser.h>
#import <libxml/HTMLtree.h>
#import <libxml/uri.h>


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,DTLazyImageViewDelegate,DTHTMLParserDelegate,DTAttributedTextContentViewDelegate>

@property (nonatomic, strong) CTDisplayView *ctView;
@property (nonatomic, strong) YDTransView *transView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YDHeaderView *headerView;

@property (nonatomic, assign) CGFloat headerViewHeight;

@property (nonatomic, strong) DTAttributedLabel *headLabel;

@property (nonatomic, strong) UILabel *originLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // [self test2];
    [self test3];
}

//测试html文件解析库
- (void)test3 {
    NSString *urlStr = @"http://www.baidu.com/index.html";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
//    html = [NSString stringWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",readmePath,_fileName]] encoding:NSUTF8StringEncoding error:&error];

    NSLog(@"data length :%zd",data.length);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    _headerView = [[YDHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20.f)];
//    _headerViewHeight = 4000.f;
//    _headerView = [[YDHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _headerViewHeight)];
//    _headerView.backgroundColor = [UIColor grayColor];
//
//    _headerView.label.delegate = self;
//    self.tableView.tableHeaderView = _headerView;
    
//    _headerView.label.shouldDrawLinks = NO; // we draw them in DTLinkButton
//    _label.layoutFrame
//    CGRect frame = _headerView.label.layoutFrame.frame;
//    _headerView.label.attributedString = [self loadDatas];
//    _headLabel = [[DTAttributedLabel alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200.f)];
//    [self.view addSubview:_headLabel];
//    _headLabel.attributedString = [self loadDatas];
//    可以通过计算高度来进行实现
    
//    _originLabel = [UILabel new];
//    [self.view addSubview:_originLabel];
//    _originLabel.text = @"asdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkasasdjfhljkas";
//    _originLabel.numberOfLines = 0;
//    _originLabel.backgroundColor = [UIColor redColor];
//    [_originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self.view);
//    }];
}

- (void)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView willDrawLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame inContext:(CGContextRef)context {
    NSLog(@"willDrawLayoutFrame ");
}

- (void)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView didDrawLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame inContext:(CGContextRef)context {
    NSLog(@"didDrawLayoutFrame");
    
//    DTCoreTextLayoutLine = layoutFrame.layoutFrame
//    if (layoutFrame.frame.size.height != _headerViewHeight) {
        _headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1694);
        _tableView.tableHeaderView = _headerView;
//    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"y :%f",y);
}

- (BOOL)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView shouldDrawBackgroundForTextBlock:(DTTextBlock *)textBlock frame:(CGRect)frame context:(CGContextRef)context forLayoutFrame:(DTCoreTextLayoutFrame *)layoutFrame {
    return YES;
}

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame {
    if ([attachment isKindOfClass:[DTVideoTextAttachment class]])
    {
        NSURL *url = (id)attachment.contentURL;
        
        // we could customize the view that shows before playback starts
        UIView *grayView = [[UIView alloc] initWithFrame:frame];
        grayView.backgroundColor = [DTColor blackColor];
        return grayView;
    }
    else if ([attachment isKindOfClass:[DTImageTextAttachment class]])
    {
        // if the attachment has a hyperlinkURL then this is currently ignored
        DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
        imageView.delegate = self;
        
        // sets the image if there is one
        imageView.image = [(DTImageTextAttachment *)attachment image];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [imageView addGestureRecognizer:tapGR];
        
        // url for deferred loading
        imageView.url = attachment.contentURL;
     
        // if there is a hyperlink then add a link button on top of this image
        if (attachment.hyperLinkURL)
        {
            // NOTE: this is a hack, you probably want to use your own image view and touch handling
            // also, this treats an image with a hyperlink by itself because we don't have the GUID of the link parts
            imageView.userInteractionEnabled = YES;
            
            DTLinkButton *button = [[DTLinkButton alloc] initWithFrame:imageView.bounds];
            button.URL = attachment.hyperLinkURL;
            button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
            button.GUID = attachment.hyperLinkGUID;
            
            // use normal push action for opening URL
            [button addTarget:self action:@selector(linkPushed:) forControlEvents:UIControlEventTouchUpInside];
            
            // demonstrate combination with long press
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(linkLongPressed:)];
            [button addGestureRecognizer:longPress];
            
            [imageView addSubview:button];
        }
        
        return imageView;
    }
    else if ([attachment isKindOfClass:[DTIframeTextAttachment class]])
    {
        DTWebVideoView *videoView = [[DTWebVideoView alloc] initWithFrame:frame];
        videoView.attachment = attachment;
        
        return videoView;
    }
    else if ([attachment isKindOfClass:[DTObjectTextAttachment class]])
    {
        // somecolorparameter has a HTML color
        NSString *colorName = [attachment.attributes objectForKey:@"somecolorparameter"];
        UIColor *someColor = DTColorCreateWithHTMLName(colorName);
        
        UIView *someView = [[UIView alloc] initWithFrame:frame];
        someView.backgroundColor = someColor;
        someView.layer.borderWidth = 1;
        someView.layer.borderColor = [UIColor blackColor].CGColor;
        
        someView.accessibilityLabel = colorName;
        someView.isAccessibilityElement = YES;
        
        return someView;
    }
    
    return nil;
}

//- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForLink:(NSURL *)url identifier:(NSString *)identifier frame:(CGRect)frame {
//
//}

//- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttributedString:(NSAttributedString *)string frame:(CGRect)frame {
//
//}

- (NSAttributedString *)loadDatas {
    // Load HTML data
    NSString *readmePath = [[NSBundle mainBundle] pathForResource:@"Image.html" ofType:nil];
    NSString *html = [NSString stringWithContentsOfFile:readmePath encoding:NSUTF8StringEncoding error:NULL];
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    
    // Create attributed string from HTML
    CGSize maxImageSize = CGSizeMake(self.view.bounds.size.width - 20.0, self.view.bounds.size.height - 20.0);
    void (^callBackBlock)(DTHTMLElement *element) = ^(DTHTMLElement *element) {
        
        // the block is being called for an entire paragraph, so we check the individual elements
        
        for (DTHTMLElement *oneChildElement in element.childNodes)
        {
            // if an element is larger than twice the font size put it in it's own block
            if (oneChildElement.displayStyle == DTHTMLElementDisplayStyleInline && oneChildElement.textAttachment.displaySize.height > 2.0 * oneChildElement.fontDescriptor.pointSize)
            {
                oneChildElement.displayStyle = DTHTMLElementDisplayStyleBlock;
                oneChildElement.paragraphStyle.minimumLineHeight = element.textAttachment.displaySize.height;
                oneChildElement.paragraphStyle.maximumLineHeight = element.textAttachment.displaySize.height;
            }
        }
    };
    
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:1.0], NSTextSizeMultiplierDocumentOption, [NSValue valueWithCGSize:maxImageSize], DTMaxImageSize,
                                    @"Times New Roman", DTDefaultFontFamily,  @"purple", DTDefaultLinkColor, @"red", DTDefaultLinkHighlightColor, callBackBlock, DTWillFlushBlockCallBack, nil];
    
    [options setObject:[NSURL fileURLWithPath:readmePath] forKey:NSBaseURLDocumentOption];
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
    
    return string;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = @"asjdkf";
    return cell;
}

- (void)test2 {
    _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor yellowColor];
}

- (void)test1 {
    _transView = [[YDTransView alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    [self.view addSubview:_transView];
    _transView.backgroundColor = [UIColor yellowColor];
}

- (void)test0 {
    self.ctView = [CTDisplayView new];
    self.ctView.frame = CGRectMake(0, 100, self.view.width, 800);
    [self.view addSubview:self.ctView];
    
    [self setupUserInterface];
    [self setupNotifications];
}

- (void)setupUserInterface {
    YDCTConfig *config = [[YDCTConfig alloc] init];
    config.width = self.ctView.width;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    YDCTModel *data = [YDCTParser parseTemplateFile:path config:config];
    self.ctView.data = data;
    self.ctView.height = data.height;
    self.ctView.backgroundColor = [UIColor yellowColor];
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imagePressed:) name:@"CTDisplayViewImagePressedNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linkPressed:) name:@"CTDisplayViewLinkPressedNotification" object:nil];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)imagePressed:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    YDCTImageModel *imageData = userInfo[@"imageData"];
    
    ImageViewController *vc = [[ImageViewController alloc] init];
    vc.image = [UIImage imageNamed:imageData.name];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)linkPressed:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    YDCTLinkModel *linkData = userInfo[@"linkData"];
    
    WebContentViewController *vc = [[WebContentViewController alloc] init];
    vc.urlTitle = linkData.title;
    vc.url = linkData.url;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
