//
//  InputTableViewCell.m
//  RaisePo
//
//  Created by zhou on 2016/12/1.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "InputTableViewCell.h"
#import "NSObject+Astray.h"
@interface InputTableViewCell()<UITextFieldDelegate>

@property(nonatomic,strong)UIView *line;

@end

#import "InputTableViewCell.h"

@implementation InputTableViewCell

- (instancetype)init{
    
    self = [super init];
    return self;
    
}

- (instancetype)initWithValue:(NSString *)value tip:(NSString * )tip title:(NSString *)title{
    
   self =  [super init];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setSubviews];
    self.nameLB.text = title;
    self.value = @"";
    if (![value isEqualToString:@""]) {
        
        self.inupt.text = value;
        self.value = value;
    }
    else{
        
//        self.inupt.text = tip;
        
        self.inupt.placeholder = tip;
    }
    
    return self;
}

- (void)setSubviews{
    
    WEAKSELF(wk);
    
    self.nameLB = [UILabel new];
    self.nameLB.textColor = UICOLORRGB(0x777777);
    self.nameLB.font = [UIFont systemFontOfSize:17];
    self.nameLB.textAlignment = NSTextAlignmentLeft;
//    self.nameLB.backgroundColor = [UIColor redColor];
    [self addSubview:self.nameLB];
    
    self.line = [[UIView alloc]init];
    self.line.backgroundColor = UICOLORRGB(0xe8e7e7);
    [self addSubview:self.line];
    
    self.inupt = [UITextField new];
    self.inupt.delegate = self;
//    self.inupt.backgroundColor = [UIColor redColor];
    self.inupt.textColor = UICOLORRGB(0x8f8f8f);
    self.inupt.font = [UIFont systemFontOfSize:14];
    self.inupt.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.inupt];
    
    
    [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk).offset(20);
        make.centerY.equalTo(wk.mas_centerY);
        make.height.mas_offset(@20);
        make.width.mas_equalTo(@100);
    }];
    
   [self.inupt mas_makeConstraints:^(MASConstraintMaker *make) {
       
       make.right.equalTo(wk).offset(-20);
       make.centerY.equalTo(wk.mas_centerY);
       make.left.equalTo(wk.nameLB.mas_right).offset(10);
       make.height.mas_equalTo(@20);
       
       
       
   }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk).offset(10);
        make.right.equalTo(wk).offset(-10);
        make.height.mas_equalTo(@0.5);
        make.bottom.mas_equalTo(wk.mas_bottom);
        
    }];
    
    
}

- (void)editStyle:(BOOL)change{
    
    if (change) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        WEAKSELF(wk);
        [self.inupt mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(wk).offset(-30);
            make.centerY.equalTo(wk.mas_centerY);
            make.left.equalTo(wk.nameLB.mas_right).offset(10);
            make.height.mas_equalTo(@20);
            
        }];
        
    }
    else{
        
        self.accessoryType = UITableViewCellAccessoryNone;
        WEAKSELF(wk);
        [self.inupt mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(wk).offset(-20);
            make.centerY.equalTo(wk.mas_centerY);
            make.left.equalTo(wk.nameLB.mas_right).offset(10);
            make.height.mas_equalTo(@20);
            
            
        }];
        
    }
    
    
    
}
- (void)setValue:(NSString*)value labelText:(NSString*)text{
    
    self.value = value;
    self.inupt.text = text;
    
}


- (void)boldLine{
    WEAKSELF(wk);
    
    self.line.backgroundColor = UICOLORRGB(0xf7f7f7);
    [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk);
        make.right.equalTo(wk);
        make.height.mas_equalTo(@10);
        make.top.equalTo(wk.mas_bottom).offset(-10);
        
    }];
    
}


#pragma TextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    NSString * str = self.inupt.text;
    if (str.length>3) {
        str = [str substringToIndex:3];
        
        if ([str isEqualToString:@"请输入"]) {
            
            self.inupt.text = @"";
        }

    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if ([textField.text isNotEmptyString]) {
        self.inupt.text = textField.text;
        self.value = textField.text;
        
        
    }
    else{
        
        self.inupt.text = @"";
        self.value = @"";

    }
   
}

- (void)addRightLBWithTitle:(NSString*)title{
    
    WEAKSELF(wk);
    
    UILabel * lab = [UILabel new];
    lab.textColor = UICOLORRGB(0x8f8f8f);
    lab.text = title;
    lab.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(wk).offset(-25);
        make.centerY.equalTo(wk.mas_centerY);
        make.height.mas_equalTo(@20);
        
    }];
    
    
    [self.inupt mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(lab.mas_left);
        make.centerY.equalTo(wk.mas_centerY);
        make.left.equalTo(wk.nameLB.mas_right).offset(50);
        make.height.mas_equalTo(@20);
        
        
        
    }];

    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
