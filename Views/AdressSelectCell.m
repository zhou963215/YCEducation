//
//  AdressSelectCell.m
//  RaisePo
//
//  Created by zhou on 2016/12/9.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "AdressSelectCell.h"
#import "SelectView.h"
@interface AdressSelectCell ()

{
    NSString * _province;
    NSString * _citystr;
    NSString * _town;
    
}
@property(nonatomic,strong)UIView *line;

@property(nonatomic,strong) SelectView *city;
@end



@implementation AdressSelectCell

- (instancetype)init {
    self = [super init];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self setSubviews];
    
    return self;
}


- (void)setSubviews{
    
    CGPoint  point = self.fieldView.center;
    
    point.x = point.x-10;
    
    self.fieldView.center = point;
    
    
    WEAKSELF(wk);
    
   
   
    self.line = [[UIView alloc]init];
    self.line.backgroundColor = UICOLORRGB(0xe8e7e7);
    [self addSubview:self.line];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk).offset(10);
        make.right.equalTo(wk).offset(-10);
        make.height.mas_equalTo(@0.5);
        make.bottom.mas_equalTo(wk.mas_bottom);
        
    }];

    
    
    
    
    
}

- (void)doAction{
    
    if (self.disabled) {
        return;
    }
    UIView *superView = self.superview;
    while(![superView isMemberOfClass:[UITableView class]]){
        superView = superView.superview;
    }
    [superView endEditing:YES];
    
   _city = [[SelectView alloc]initWithZGQFrame:CGRectMake(0, 0, WIDTH, HEIGHT) SelectCityTtitle:@"城市选择"];
    [_city updateAddressAtProvince:_province city:_citystr town:_town];

    [_city showCityView:^(NSString *proviceStr, NSString *cityStr, NSString *disStr) {
        
        _province =proviceStr;
        _citystr = cityStr;
        _town = disStr;

        self.label.text = [NSString stringWithFormat:@"%@%@%@",proviceStr,cityStr,disStr];
        self.value = @[proviceStr,cityStr,disStr];
    }];

    
}

- (void)updateAddressWithProvince:(NSString *)province city:(NSString *)city town:(NSString *)town{
    _province = province;
    _citystr = city;
    _town = town;
    
    self.label.text = [NSString stringWithFormat:@"%@%@%@",province,city,town];
    self.label.textColor = UICOLORRGB(0x8f8f8f);

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
