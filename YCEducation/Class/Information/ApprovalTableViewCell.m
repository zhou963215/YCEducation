//
//  ApprovalTableViewCell.m
//  YCEducation
//
//  Created by zhou on 2017/3/30.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "ApprovalTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ApprovalTableViewCell()
@property(nonatomic,strong)UIImageView * leftImg;
@property(nonatomic,strong)UILabel * titleLB;
@property(nonatomic,strong)UILabel * timeLB;
@property(nonatomic,strong)UILabel * typeLB;

@end

@implementation ApprovalTableViewCell


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
    
    [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.titleLB);
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
    


}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
