//
//  TitleCollectionViewCell.m
//  YCEducation
//
//  Created by zhou on 2017/3/15.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "TitleCollectionViewCell.h"

@interface TitleCollectionViewCell()

@property(nonatomic,strong)UIImageView * imgaeView;
@property(nonatomic,strong)UILabel * title;


@end

@implementation TitleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setSubview];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setSubview{
    
    self.imgaeView = [UIImageView new];
    [self addSubview:self.imgaeView];
    
    self.title = [UILabel new];
    self.title.font = [UIFont systemFontOfSize:15];
    self.title.textColor = UICOLORRGB(0x282828);
    [self addSubview:self.title];
    
    self.numberLB  = [UILabel new];
    self.numberLB.text = @"10";
    self.numberLB.font  = [UIFont systemFontOfSize:15];
    self.numberLB.textColor = UICOLORRGB(0x4CA8E7);
    [self addSubview:self.numberLB];
    
    
    WEAKSELF(wk);
    
    [_imgaeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(wk);
        make.left.equalTo(wk).offset(27);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(wk);
        make.left.equalTo(wk.imgaeView.mas_right).offset(8.5);
        make.height.mas_equalTo(@21);
    }];
    
    [_numberLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(wk).offset(-16);
        make.centerY.equalTo(wk);
        make.height.mas_equalTo(@21);
    }];
    
    
}

- (void)setDataWithDict:(NSDictionary *)dict{
    
    
    self.imgaeView.image = [UIImage imageNamed:dict[@"imageName"]];
    
    self.title.text = dict[@"title"];
//    self.numberLB.text = dict[@"number"];
    
    
    
}


@end
