//
//  InformationHeader.m
//  YCEducation
//
//  Created by zhou on 2017/3/30.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "InformationHeader.h"

@implementation InformationHeader


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setSubviews];
        
    }
 
    return self;
}



- (void)setSubviews{
    
    _titleLB = [UILabel new];
    _titleLB.textColor = UICOLORRGB(0x787878);
    _titleLB.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleLB];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setImage:[UIImage imageNamed:@"b_down"] forState:UIControlStateNormal];
    [_rightBtn setImage:[UIImage imageNamed:@"b_right"] forState:UIControlStateSelected];
    [self.contentView addSubview:_rightBtn];
    
    UIView * view = [UIView new];
    view.backgroundColor = UICOLORRGB(0xf8f8f8);
    [self.contentView addSubview:view];
    
    WEAKSELF(wk);
    
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(wk);
        make.left.equalTo(wk).offset(16);
        
    }];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.right.bottom.equalTo(wk);
        make.width.mas_equalTo(@52);
        
    }];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(wk);
        make.height.mas_equalTo(@1);
    }];
}

@end
