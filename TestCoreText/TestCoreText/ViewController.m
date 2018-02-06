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
#import "YDDisplayView.h"
#import "YDDisplayView.h"

#import <libxml/HTMLparser.h>
#import "YDTest10ViewController.h"

#import "Masonry.h"
#import "NSString+GHTransformation.h"
#import "YDCollectionNullReusableView.h"
#import <CoreText/CoreText.h>

#import "YDTest11ViewController.h"
#import <YYAsyncLayer.h>
#import "YDTest12ViewController.h"

#import "YDTest13ViewViewController.h"
#import "YDCollectionNullReusableView.h"
#import "YDCollectionReusableView.h"

#import "YDTest14ViewController.h"
#import "YDTest15ViewController.h"
#import <YYKeyboardManager.h>

#import <YYTextView.h>
#import "YDTest15ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,DTLazyImageViewDelegate,DTAttributedTextContentViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CALayerDelegate,YYAsyncLayerDelegate>
// html 页面解析
{
    htmlSAXHandler _handler; //处理
    NSData *_data; // 数据
    NSStringEncoding _encoding; // 编码
    htmlParserCtxtPtr _parserContext;
    NSMutableString *_accumulateBuffer; // 计算的缓存
    __weak id<vcDelegate> _delegate;
    BOOL _isAborting;
}

@property (nonatomic, strong) CTDisplayView *ctView;
@property (nonatomic, strong) YDTransView *transView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YDHeaderView *headerView;
@property (nonatomic, assign) CGFloat headerViewHeight;
@property (nonatomic, strong) DTAttributedLabel *headLabel;
@property (nonatomic, strong) UILabel *originLabel;

@property (nonatomic, strong) YDDisplayView *displayView;

//for test5
@property (nonatomic, strong) YDDisplayView *test5view;

//for test6
@property (nonatomic, strong) UILabel *test6Label;

//for test8
//@property (nonatomic, strong) UITableView *tableView;

//for test9
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

//for test10
@property (nonatomic, strong) UIButton *raBtn;

// test11
//@property (nonatomic, strong) YYAsyncLayer *sonLayer;

// test13

//test14

//test 15
//@property (nonatomic, strong) YYTextView *textView;
//@property (nonatomic, strong) YYTextLine *textLine;

@end

#pragma mark Event function prototypes

void yd_startDocument(void *context);
void yd_endDocument(void *context);
void yd_startElement(void *context, const xmlChar *name,const xmlChar **atts);
void yd_startElement_no_delegate(void *context, const xmlChar *name, const xmlChar **atts);
void yd_endElement(void *context, const xmlChar *name);
void yd_endElement_no_delegate(void *context, const xmlChar *chars);
void yd_characters(void *context, const xmlChar *ch, int len);
void yd_comment(void *context, const xmlChar *value);
void yd_dterror(void *context, const char *msg, ...);
void yd_cdataBlock(void *context, const xmlChar *value, int len);
void yd_processingInstruction (void *context, const xmlChar *target, const xmlChar *data);

#pragma mark Event functions

void yd_startDocument(void *context)
{
    NSLog(@"_startDocument");
}

void yd_endDocument(void *context)
{
    NSLog(@"end document");
}

void yd_startElement(void *context, const xmlChar *name, const xmlChar **atts)
{
    NSLog(@"start element");
}

void yd_startElement_no_delegate(void *context, const xmlChar *name, const xmlChar **atts)
{
    NSLog(@"start element");
}

void yd_endElement(void *context, const xmlChar *chars)
{
    NSLog(@"end element");
}

void yd_endElement_no_delegate(void *context, const xmlChar *chars)
{
    NSLog(@"end element no delegate");
}

void yd_characters(void *context, const xmlChar *chars, int len)
{
    NSLog(@"characters ");
}

void yd_comment(void *context, const xmlChar *chars)
{
    NSLog(@"comment");
}

void yd_dterror(void *context, const char *msg, ...)
{
    NSLog(@"tder4ror");
}

void yd_cdataBlock(void *context, const xmlChar *value, int len)
{
    NSLog(@"data block");
}

void yd_processingInstruction (void *context, const xmlChar *target, const xmlChar *data)
{
    NSLog(@"context :%@",context);
}

void yd_internalSubset (void *context, const xmlChar *name, const xmlChar *ExternalID, const xmlChar *SystemID) {
    NSLog(@"internalSubset");
}

@implementation ViewController

- (id<vcDelegate>)delegate {
    return _delegate;
}

- (void)setDelegate:(id <vcDelegate>)delegate
{
    _delegate = delegate;
    
    if ([delegate respondsToSelector:@selector(doText:)])
    {
        _handler.startDocument = yd_startDocument;
    }
    else
    {
//        _handler.startDocument = yd_stat;
    }
  
}
- (void)viewDidLoad {
    [super viewDidLoad];

//    [self test0];
//    [self test2];
//    [self test3];
//    [self test4];
//    [self test5];
//    [self test6];
//    [self test7];
//    [self test8];
//    [self test9];
//    [self test10];
//    [self test11];
//    [self test12];
//    [self test13];
    [self test14];
//    [self test15];
}

- (void)test15 {
    YDTest15ViewController *vc = [YDTest15ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)test14 {
    YDTest14ViewController *vc = [YDTest14ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)test13 {
    YDTest13ViewViewController *vc = [YDTest13ViewViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)test12 {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(onTest12) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"test12" forState:UIControlStateNormal];
}

- (void)onTest12 {
    YDTest12ViewController *vc = [YDTest12ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)test11 {
//    _sonLayer = [YYAsyncLayer new];
//    _sonLayer.delegate = self;
//    [self.view.layer addSublayer:_sonLayer];
//    _sonLayer.frame = CGRectMake(0, 100, 200, 100);
//    _sonLayer.backgroundColor = [UIColor yellowColor].CGColor;
}

- (void)test10 {
    _raBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _raBtn.frame = CGRectMake(0, 100, 100, 40);
    _raBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:_raBtn];
    [_raBtn setTitle:@"test10" forState:UIControlStateNormal];
    [_raBtn addTarget:self action:@selector(onRATap:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *raBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    raBtn1.frame = CGRectMake(0, 150, 100, 40);
    raBtn1.backgroundColor = [UIColor redColor];
    [self.view addSubview:raBtn1];
    [raBtn1 setTitle:@"测试collectionView 转化为TableView" forState:UIControlStateNormal];
    [raBtn1 addTarget:self action:@selector(onRATap1:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onRATap1:(id)sender {
    YDTest11ViewController *vc = [YDTest11ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)onRATap:(UIButton *)sender {
    YDTest10ViewController *vc =[YDTest10ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)test9 {
    _layout = [UICollectionViewFlowLayout new];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _layout.itemSize = CGSizeMake(80, 80);
    _layout.minimumLineSpacing = 8.f;
    _layout.minimumInteritemSpacing = 8.f;
    _layout.estimatedItemSize = CGSizeMake(100, 100);
//    preferredLayoutAttributesFittingAttributes 和这个有关
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    _layout.footerReferenceSize = CGSizeMake(self.view.bounds.size.width, 100.f);
    _layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 80.f);
    _layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _layout.sectionInsetReference = UICollectionViewFlowLayoutSectionInsetFromContentInset; //11
    _layout.sectionHeadersPinToVisibleBounds = YES;// 9
    _layout.sectionFootersPinToVisibleBounds = YES; //9
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    [_collectionView registerClass:[YDCollectionNullReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([YDCollectionNullReusableView class])];
    [_collectionView registerClass:[YDCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([YDCollectionReusableView class])];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        return nil;
    }

    if (indexPath.section == 0) {
        YDCollectionNullReusableView *reuserView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([YDCollectionNullReusableView class]) forIndexPath:indexPath];
        reuserView.backgroundColor  = [UIColor yellowColor];
        return reuserView;
    }
    else {
        YDCollectionNullReusableView *resuseView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([YDCollectionNullReusableView class]) forIndexPath:indexPath];
        resuseView.backgroundColor = [UIColor blueColor];
        return resuseView;
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return _layout.headerReferenceSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return _layout.footerReferenceSize;
}

//- (NSIndexPath *)collectionView:(UICollectionView *)collectionView targetIndexPathForMoveFromItemAtIndexPath:(NSIndexPath *)originalIndexPath toProposedIndexPath:(NSIndexPath *)proposedIndexPath {
//
//}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(100.f, 100.f);
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did selected item ");
}

- (void)test8 {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)test7 {
    
    UILabel *label = [[UILabel alloc]initWithFrame:self.view.frame];
    label.font = [UIFont fontWithName:@"Strawberry Blossom" size:100];
    label.text = @"Dong";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];

//    这个路径要正确，否则是系统的
    CFStringRef aCFString = CFSTR("Strawberry Blossom");
    CTFontRef fontRef = CTFontCreateWithName(aCFString, 0.0,NULL);
    CFStringRef sampleText=CTFontCopyName(fontRef,kCTFontSampleTextNameKey);
    CFStringRef copyRight = CTFontCopyName(fontRef,kCTFontCopyrightNameKey);
    CFStringRef familyName = CTFontCopyName(fontRef,kCTFontFamilyNameKey);
    CFStringRef postSCriptName = CTFontCopyName(fontRef,kCTFontPostScriptNameKey);
    CFStringRef urlName = CTFontCopyName(fontRef,kCTFontDesignerURLNameKey);
    CFStringRef manufacturerName = CTFontCopyName(fontRef,kCTFontManufacturerNameKey);
    
//    NSLog(@"%@",sampleText);
}

- (void)test6 {
    NSString *str = @"text\ntext\ntext\ntext\ntext";
    _test6Label = [UILabel new];
    [self.view addSubview:_test6Label];
    _test6Label.text = str;
//    let textSize = [str ];
//    str.uppercaseString.sizeWithAttributes([NSFontAttributeName:UIFont(name: label.font as String, size: label.fontSize)!])
    
    
    //    1.
    int32_t version = CTGetCoreTextVersion();
    NSString *hex = [NSString hexByDecimal:version];
    
    UIFont *currentFont = [UIFont systemFontOfSize:17.f];
    UIFont *currentfont3 = [UIFont fontWithName:@"PingFangSC-Semibold" size:17.f];
    UIFont *currentFont1 = [UIFont systemFontOfSize:17.f];
    UIFont *currentFont2 = [UIFont systemFontOfSize:14.f];
    CFTypeID cfId = CFGetTypeID((CFTypeRef)(currentFont));
    CFTypeID cfId1 = CFGetTypeID((CFTypeRef)(currentFont1));
    CFTypeID cfId2 = CFGetTypeID((CFTypeRef)(currentFont2));
    CFTypeID cfId3 = CFGetTypeID((CFTypeRef)(currentfont3));
    CFTypeID ctId = CTFontGetTypeID();
//    CFStringRef aCFstring = CTFontGetGlyphWithName(CTFontRef(currentFont), <#CFStringRef  _Nonnull glyphName#>)();
    
    if (cfId == ctId) {
        NSLog(@"yes");
    }
    else {
        NSLog(@"no");
    }
    //    2. 有关字体换行大小可能存在问题

}


- (void)test5 {
    _test5view = [YDDisplayView new];
    _test5view.frame = CGRectMake(100, 100, 200, 200);
    [self.view addSubview:_test5view];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)test4 {
    
    _displayView = [YDDisplayView new];
    [self.view addSubview:_displayView];
    _displayView.backgroundColor = [UIColor yellowColor];
    _displayView.frame = CGRectMake(0, 100, 300, 100);
}

//测试html文件解析库
- (void)test3 {
    NSString *urlStr = @"http://localhost:8080/index.html";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
    NSLog(@"data length :%zd",data.length);
    NSString *string = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlStr] encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"string:%@",string);
    _data = data;
    _encoding = NSUTF8StringEncoding;

//    _handler.startDocument = yd_startDocument;
//    _handler.endDocument = yd_endDocument;
//    _handler.startElement = yd_startElement;
//    _handler.endElement = yd_endElement;
//    _handler.characters = yd_characters;
//    _handler.comment = yd_comment;
//    _handler.cdataBlock = yd_cdataBlock;
//    _handler.processingInstruction = yd_processingInstruction;
//    _handler.internalSubset = yd_internalSubset;
    
    xmlSAX2InitHtmlDefaultSAXHandler(&_handler);
    
    void *dataBytes = (char *)[data bytes];

    _parserContext = htmlCreatePushParserCtxt(&_handler, (__bridge void *)self, dataBytes, (int)data.length, NULL, XML_CHAR_ENCODING_UTF8);
    htmlCtxtUseOptions(_parserContext, HTML_PARSE_RECOVER | HTML_PARSE_NONET | HTML_PARSE_COMPACT | HTML_PARSE_NOBLANKS);
    
    int result = htmlParseDocument(_parserContext);
    NSLog(@"result code :%zd",result);
}

- (void)dealloc
{
    if (_parserContext)
    {
        htmlFreeParserCtxt(_parserContext);
    }
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
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
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
