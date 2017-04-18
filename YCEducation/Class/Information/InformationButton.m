//
//  InformationButton.m
//  YCEducation
//
//  Created by zhou on 2017/3/29.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "InformationButton.h"

@interface InformationButton()

@end
@implementation InformationButton

+(instancetype)sharButton{
    
    InformationButton * btn = [InformationButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setUI];
    return btn;
}



- (void)setUI{
    
    WEAKSELF(wk);
    
    _numberLB = [UILabel new];
    _numberLB.textColor= UICOLORRGB(0x787878);
    _numberLB.font = [UIFont systemFontOfSize:15];
    [self addSubview:_numberLB];
    
    
    _titleLB = [UILabel new];
    _titleLB.textColor = UICOLORRGB(0x787878);
    _titleLB.font = [UIFont systemFontOfSize:12];
    [self addSubview:_titleLB];
    
    
    [_numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(wk);
        make.top.equalTo(wk).offset(13);
        
    }];
    
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(wk);
        make.bottom.equalTo(wk).offset(-13);

    }];
    
    
    
    
    
    
}
@end
