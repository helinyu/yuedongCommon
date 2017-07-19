//
//  BluetoothDaterView.m
//  SOMICS3
//
//  Created by mac-somic on 2017/4/17.
//  Copyright © 2017年 mac-somic. All rights reserved.
//

#import "BluetoothDaterView.h"
#import "UIView+Frame.h"

@interface BluetoothDaterView ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    UIView *daterContentView;
    UILabel *daterLab;
    UIPickerView *picker;
    UIButton *cancelBtn;
    UIButton *sureBtn;
    int nowYear;
    NSArray *dayArr1;
    NSArray *dayArr2;
    NSMutableArray *yearArr;
    NSMutableArray *hourArr;
    NSMutableArray *miniuteArr;
}
@end

@implementation BluetoothDaterView

- (void)initData{
    dayArr1 = @[@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
    dayArr2 = @[@"31",@"29",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    [formatter setDateFormat:@"yyyy"];
    _year = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"MM"];
    _month = [[formatter stringFromDate:date] intValue];
    [formatter setDateFormat:@"dd"];
    _day = [[formatter stringFromDate:date] intValue];
    yearArr = [NSMutableArray array];
    for (int i = 60; i>0; i--) {
        NSString *str = [NSString stringWithFormat:@"%d",_year-60+i];
        [yearArr addObject:str];
    }
    
}
- (void)initViews{
    self.frame=[UIScreen mainScreen].bounds;
    self.backgroundColor=RGBA(0, 0, 0, 0.3);
    daterContentView = [[UIView alloc]initWithFrame:Frame(WH(40), WH(200), SCREEN_WIDTH-WH(80), WH(200))];
    daterContentView.backgroundColor=WhiteColor;
    [self addSubview:daterContentView];
    daterContentView.layer.masksToBounds=YES;
    daterContentView.layer.cornerRadius=8;
    
    daterLab=[[UILabel alloc]initWithFrame:Frame(0, 0, daterContentView.width, WH(30))];
    daterLab.text=@"选择日期";
    daterLab.backgroundColor=MainGreenColor;
    daterLab.font=Font(14);
    daterLab.textColor=BlackFontColor;
    daterLab.textAlignment=1;
    [daterContentView addSubview:daterLab];
    
    picker = [[UIPickerView alloc]initWithFrame:Frame(WH(20), daterLab.height, SCREEN_WIDTH-WH(120), WH(130))];
    picker.dataSource=self;
    picker.delegate=self;
    [daterContentView addSubview:picker];
    
    
    cancelBtn = [[UIButton alloc]init];
    cancelBtn.frame = Frame(0, picker.bottom, daterContentView.width/2.0, WH(40));
    [cancelBtn setTitle:@"取 消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [daterContentView addSubview:cancelBtn];
    cancelBtn.backgroundColor=MainGreenColor;
    
    sureBtn = [[UIButton alloc]init];
    sureBtn.frame = Frame(daterContentView.width/2.0, cancelBtn.top, daterContentView.width/2.0, cancelBtn.height);
    [sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [daterContentView addSubview:sureBtn];
    sureBtn.backgroundColor=MainGreenColor;
    
    UIView *verLine=[[UIView alloc]initWithFrame:Frame(cancelBtn.width, cancelBtn.top, 1, cancelBtn.height)];
    verLine.backgroundColor=WhiteColor;
    [daterContentView addSubview:verLine];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        [self initViews];
        [self initData];
        
        [picker selectRow:[self midNum:60] inComponent:0 animated:YES];
        [picker selectRow:_month-1+[self midNum:12] inComponent:1 animated:YES];
        [picker selectRow:_day-1+[self midNum:[self daysInSelectMonth]] inComponent:2 animated:YES];
        self.dateString = [NSString stringWithFormat:@"%d-%02d-%02d",_year,_month,_day];
    }
    return self;
}


#pragma mark - pickerView delagate,datasource
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
    if (_dateViewType == BluetoothDaterViewTypeDate) {
        NSUInteger mid = 0;
        NSUInteger rowIndex = 0;
        if(component == 0){
            mid = [self midNum:(int)yearArr.count];
            rowIndex = row%yearArr.count;
            [picker selectRow:rowIndex+mid inComponent:0 animated:NO];
            _year = [yearArr[[picker selectedRowInComponent:0]%yearArr.count] intValue];
            if (_day <= [self daysInSelectMonth]) {
                [picker selectRow:_day-1+[self midNum:[self daysInSelectMonth]] inComponent:2 animated:NO];
            }else{
                [picker selectRow:[self daysInSelectMonth]-1+[self midNum:[self daysInSelectMonth]] inComponent:2 animated:NO];
            }
            
        }else if (component == 1){
            mid = [self midNum:12];
            rowIndex = row%12;
            [picker selectRow:rowIndex+mid inComponent:1 animated:NO];
            if (_day <= [self daysInSelectMonth]) {
                [picker selectRow:_day-1+[self midNum:[self daysInSelectMonth]] inComponent:2 animated:NO];
            }else{
                [picker selectRow:[self daysInSelectMonth]-1+[self midNum:[self daysInSelectMonth]] inComponent:2 animated:NO];
            }
            _month = (int)[picker selectedRowInComponent:1]%12+1;
        }else if (component == 2){
            mid = [self midNum:[self daysInSelectMonth]];
            rowIndex = row%[self daysInSelectMonth];
            [picker selectRow:rowIndex+mid inComponent:2 animated:NO];
            
        }
        _day = (int)[picker selectedRowInComponent:2]%[self daysInSelectMonth]+1;
        self.dateString = [NSString stringWithFormat:@"%d-%02d-%02d",_year,_month,_day];
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    int count = 0;
    if (_dateViewType == BluetoothDaterViewTypeDate) {
        if(component == 0){
            count = (int)yearArr.count;
        }else if(component == 1){
            count = 12;
        }else{
            //获得前二个滚轮的当前所选行的索引
            count = [self daysInSelectMonth];
        }
    }else if (_dateViewType == BluetoothDaterViewTypeTime){
        if(component == 0){
            count = 24;
        }else if(component == 1 || component==2){
            count = 60;
        }
    }
    return count*50;
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *rowLab = [[UILabel alloc] init];
    rowLab.textAlignment = NSTextAlignmentCenter;
    rowLab.backgroundColor = [UIColor clearColor];
    rowLab.frame = CGRectMake(0, 0, daterContentView.width/3.0, 50);
    [rowLab setFont:[UIFont systemFontOfSize:16]];
    if (_dateViewType == BluetoothDaterViewTypeDate) {
        if(component == 0){
            rowLab.text = [NSString stringWithFormat:@"%@年",yearArr[row%yearArr.count]];
        }else if(component == 1){
            rowLab.text = [NSString stringWithFormat:@"%ld月",row%12+1];
        }else{
            rowLab.text = [NSString stringWithFormat:@"%ld日",row%[self daysInSelectMonth]+1];
        }
    }
    return rowLab;
}

#pragma mark - Public Methods
- (void)showInView:(UIView *)aView animated:(BOOL)animated{
    [aView addSubview:self];
    if (animated) {
        [self fadeIn];
    }
}
- (void)setSelectYear:(int)year month:(int)month day:(int)day animated:(BOOL)animated{
    _year = year;
    _month = month;
    _day = day;
    self.dateString = [NSString stringWithFormat:@"%d-%02d-%02d",_year,_month,_day];
    [picker selectRow:[self midNum:60]+year-nowYear inComponent:0 animated:YES];
    [picker selectRow:_month-1+[self midNum:12] inComponent:1 animated:YES];
    [picker selectRow:_day-1+[self midNum:[self daysInSelectMonth]] inComponent:2 animated:YES];
    
}

- (void)setDateViewType:(BluetoothDaterViewType)dateViewType{
    _dateViewType = dateViewType;
    if (_dateViewType == BluetoothDaterViewTypeDate) {
        daterLab.text=@"选择日期";
    }

}

//}
#pragma mark - Private Methods
- (void)fadeIn{
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
    }];
    
}
- (void)fadeOut{
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 0.0;
    }completion:^(BOOL finished) {
        if (finished){
            [self removeFromSuperview];
        }
    }];
}
- (int)daysInSelectMonth{
    int count = 0;
    int row = (int)[picker selectedRowInComponent:0]%yearArr.count;
    int nowyear = [yearArr[row] intValue];
    int nowmonth = (int)[picker selectedRowInComponent:1]%12;
    if ((nowyear % 4 == 0 && nowyear % 100 !=0 )||(nowyear % 400 == 0)) {
        count = [[dayArr2 objectAtIndex:nowmonth] intValue];
    }else{
        count = [[dayArr1 objectAtIndex:nowmonth] intValue];
    }
    return count;
}
- (int)midNum:(int)arrCount{
    int mid = (arrCount*50/2)-(arrCount*50/2)%arrCount;
    return mid;
}
#pragma mark - delegate
- (void)sureAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(daterViewDidClicked:)]) {
        [self.delegate daterViewDidClicked:self];
    }
    [self fadeOut];
}
- (void)cancelAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(daterViewDidCancel:)]) {
        [self.delegate daterViewDidCancel:self];
    }
    [self fadeOut];
}


@end
