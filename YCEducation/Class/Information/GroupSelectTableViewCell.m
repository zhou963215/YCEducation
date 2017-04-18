
//
//  GroupSelectTableViewCell.m
//  YCEducation
//
//  Created by zhou on 2017/4/7.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "GroupSelectTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GroupData.h"
@interface GroupSelectTableViewCell()

@property(nonatomic,strong)UIImageView * headerImg;
@property(nonatomic,strong)UILabel * nameLB;
@property(nonatomic,strong)NSDictionary * dict;
@end

@implementation GroupSelectTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationAction:) name:@"delete" object:nil];
        
    }
    
    return self;
}


- (void)setSubViews{
    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectBtn setImage:[UIImage imageNamed:@"b_nSelect"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"b_select"] forState:UIControlStateSelected];
    [self addSubview:_selectBtn];
    
    _headerImg  = [UIImageView new];
    _headerImg.layer.masksToBounds = YES;
    _headerImg.layer.cornerRadius = 15;
    [self addSubview: _headerImg];
    
    _nameLB = [UILabel new];
    _nameLB.font = [UIFont systemFontOfSize:16];
    _nameLB.textColor = UICOLORRGB(0x505050);
    [self addSubview:_nameLB];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setTitle:@"下级" forState:UIControlStateNormal];
    _nextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_nextBtn setTitleColor:UICOLORRGB(0x3ea0e6) forState:UIControlStateNormal];
    _nextBtn.layer.borderWidth = 1;
    _nextBtn.layer.borderColor = UICOLORRGB(0x3ea0e6).CGColor;
    _nextBtn.layer.masksToBounds = YES;
    _nextBtn.layer.cornerRadius = 2;
    _nextBtn.hidden = YES;
    [self addSubview:_nextBtn];
    
    WEAKSELF(wk);
    
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk).offset(16);
        make.centerY.equalTo(wk);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        
        
    }];
    
    [_headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.selectBtn.mas_right).offset(16);
        make.centerY.equalTo(wk);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        
    }];
    
    [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.headerImg.mas_right).offset(9);
        make.centerY.equalTo(wk);
        
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(wk);
        make.right.equalTo(wk).offset(-16);
        make.size.mas_equalTo(CGSizeMake(45, 20));
        
        
        
    }];
    
}


- (void)upDataWithNSDictory:(NSDictionary *)dict withBool:(BOOL)isOnly{
    
    self.dict = dict;
    _selectBtn.selected = NO;
    _selectBtn.hidden = NO;
    if ([dict[@"iType"]intValue]==1) {
        _headerImg.image = [UIImage imageNamed:@"b_tx"];
        _nextBtn.hidden = NO;
        _selectBtn.hidden = isOnly;

    }
    else{
        
        _nextBtn.hidden = YES;
        [_headerImg sd_setImageWithURL:[NSURL URLWithString:dict[@"icon"]] placeholderImage:[UIImage imageNamed:@"m_tou"]];
    }
    

    GroupData * data = [GroupData dataModel];
    
    [data.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (dict[@"itemId"]==obj[@"itemId"]) {
            
            _selectBtn.selected = YES;
        }
        
    }];
    
    
    
    
    _nameLB.text = dict[@"name"];
    
    
}

- (void)notificationAction:(NSNotification *)notification{

    NSDictionary * deleteData = notification.object;
    
    if (deleteData[@"itemId"]==self.dict[@"itemId"]) {
        
        
        _selectBtn.selected = NO;
        
    }
        
    
}
- (void)dealloc{
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"delete" object:nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
