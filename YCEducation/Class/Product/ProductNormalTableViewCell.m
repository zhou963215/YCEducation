//
//  ProductNormalTableViewCell.m
//  YCEducation
//
//  Created by zhou on 2017/3/28.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "ProductNormalTableViewCell.h"
#import "NSObject+Astray.h"
@interface ProductNormalTableViewCell()

@property(nonatomic,strong)UILabel * title;
@property(nonatomic,strong)UILabel * source;
@property(nonatomic,strong)UILabel * time;


@end

@implementation ProductNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setSubViews];
        
    }
    return self;
}

- (void)setSubViews{
    
    UIImageView * headerImg = [UIImageView new];
    headerImg.backgroundColor = [UIColor orangeColor];
    [self addSubview:headerImg];
    
    _title = [UILabel new];
    _title.textColor = UICOLORRGB(0x282828);
    _title.numberOfLines = 2;
    _title.font = [UIFont systemFontOfSize:15];
    [self addSubview:_title];
    
   
    
    _source = [UILabel new];
    _source.textColor = UICOLORRGB(0xa0a0a0);
    _source.font = [UIFont systemFontOfSize:12];
    [self addSubview:_source];
    
    _time = [UILabel new];
    _time.textColor =UICOLORRGB(0xa0a0a0);
    _time.font = [UIFont systemFontOfSize:12];
    [self addSubview:_time];
    
    WEAKSELF(wk);
    
    [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk).offset(16);
        make.top.equalTo(wk).offset(14);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        
        
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk).offset(74);
        make.top.equalTo(wk).offset(15);
        make.right.equalTo(wk).offset(-16);
        
    }];
    
    
    [_source mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk).offset(74);
        make.bottom.equalTo(wk).offset(-15);
    }];
    
    
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(wk).offset(-16);
        make.bottom.equalTo(wk.source);
    }];
}

- (void)upDataWithDict:(NSDictionary *)dict{
    
    NSMutableDictionary * data = [dict checkData:dict];
    
    self.title.text = data[@"title"];
    self.source.text = [NSString stringWithFormat:@"来源:  %@",data[@"frome"]];
    self.time.text = data[@"fromTime"];

    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
