//
//  ActivityTableViewCell.m
//  YCEducation
//
//  Created by zhou on 2017/3/31.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ActivityTableViewCell()
@property(nonatomic,strong)UIImageView * leftImg;
@property(nonatomic,strong)UILabel * titleLB;
@property(nonatomic,strong)UILabel * timeLB;
@property(nonatomic,strong)UILabel * typeLB;
@property(nonatomic,strong)UILabel * addressLB;
@end

@implementation ActivityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    return self;
}


- (void)setSubViews{
    
    _leftImg = [UIImageView new];
    [self addSubview:_leftImg];
    
    _titleLB = [UILabel new];
    _titleLB.font = [UIFont systemFontOfSize:15];
    _titleLB.textColor = UICOLORRGB(0x282828);
    [self addSubview:_titleLB];
    
    UIImageView *  addressImg = [UIImageView new];
    addressImg.image = [UIImage imageNamed:@"b_dw"];
    [self addSubview:addressImg];
    
    
    _addressLB = [UILabel new];
    _addressLB.textColor = UICOLORRGB(0x646464);
    _addressLB.font = [UIFont systemFontOfSize:12];
    [self addSubview:_addressLB];
    
    _timeLB = [UILabel new];
    _timeLB.font = [UIFont systemFontOfSize:12];
    _timeLB.textColor = UICOLORRGB(0x646464);
    [self addSubview:_timeLB];
    
    _typeLB = [UILabel new];
    _typeLB.textColor = UICOLORRGB(0x3ea0e6);
    _typeLB.font = [UIFont systemFontOfSize:12];
    [self addSubview:_typeLB];
    
    WEAKSELF(wk);
    
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk).offset(16);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(wk).offset(15);
    }];
    
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk).offset(57);
        make.top.equalTo(wk).offset(15);
    }];
    
    [addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.titleLB);
        make.size.mas_equalTo(CGSizeMake(9.5, 12));
        make.top.equalTo(wk.titleLB.mas_bottom).offset(11.5);
        
    }];
    
    [_addressLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressImg.mas_right).offset(8);
        make.top.equalTo(addressImg);
        
    }];
    
    
    [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.addressLB.mas_right).offset(24);
        make.top.equalTo(wk.titleLB.mas_bottom).offset(11.5);
        
    }];
    
    [_typeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(wk).offset(15);
        make.right.equalTo(wk).offset(-16);
    }];
    
}

- (void)upDataWithNSDictory:(NSDictionary *)dict{
    
    [_leftImg sd_setImageWithURL:[NSURL URLWithString:dict[@"infoIcon"]] placeholderImage:[UIImage imageNamed:@"b_xc"]options:SDWebImageRefreshCached];
    _titleLB.text =dict[@"infoTitle"];
    _timeLB.text = dict[@"infoTime"];
    _typeLB.text = dict[@"infoStatus"];
    _addressLB.text = dict[@"infoAddress"];
    
    if ([_typeLB.text isEqualToString:@"进行中"]) {
        _typeLB.textColor = UICOLORRGB(0x30c744);
    }
    if ([_typeLB.text isEqualToString:@"未开始"]) {
        _typeLB.textColor = UICOLORRGB(0xfc5f55);
    }
    if ([_typeLB.text isEqualToString:@"待确认"]) {
        _typeLB.textColor = UICOLORRGB(0x3ea0e6);
    }

    
//    _leftImg.image = [UIImage imageNamed:@"b_sys"];
//    _titleLB.text = @"王老师的用车申请";
//    _addressLB.text = @"实验楼";
//    _timeLB.text = @"2017.03.04  13:02";
//    _typeLB.text = @"未审批";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
