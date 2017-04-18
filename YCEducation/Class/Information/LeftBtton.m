//
//  LeftBtton.m
//  YCEducation
//
//  Created by zhou on 2017/4/1.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "LeftBtton.h"



@implementation LeftBtton
+(instancetype)sharButton{
    
    LeftBtton * btn = [LeftBtton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setUI];
    return btn;
}


- (void)setUI{
    
     WEAKSELF(wk);
    _leftImg = [UIImageView new];
    [self addSubview:_leftImg];
    
    _titleLB = [UILabel new];
    _titleLB.font = [UIFont systemFontOfSize:18];
    _titleLB.textColor = UICOLORRGB(0x282828);
    [self addSubview:_titleLB];
    
    
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk).offset(16);
        make.centerY.equalTo(wk);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        
    }];
    
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk).offset(52);
        make.centerY.equalTo(wk);
        
    }];
    
    
}

@end
