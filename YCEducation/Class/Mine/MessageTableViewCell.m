//
//  MessageTableViewCell.m
//  YCEducation
//
//  Created by zhou on 2017/3/28.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "NSObject+Astray.h"
@interface MessageTableViewCell ()
@property(nonatomic,strong)UILabel * title;
@property(nonatomic,strong)UILabel * detail;

@end
@implementation MessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setSubViews];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
    
}
- (void)setSubViews{
    
    _title = [UILabel new];
    _title.font = [UIFont systemFontOfSize:18];
    _title.textColor = UICOLORRGB(0x282828);
    [self addSubview:_title];
    
    _detail = [UILabel new];
    _detail.font = [UIFont systemFontOfSize:14];
    _detail.textColor = UICOLORRGB(0xa0a0a0);
    [self addSubview:_detail];
    
    WEAKSELF(wk);
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk).offset(16);
        make.right.equalTo(wk).offset(-16);
        make.top.equalTo(wk).offset(15);
    }];
    
    [_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.title);
        make.top.equalTo(wk.title.mas_bottom).offset(11);
        
        
    }];
    
    
}
- (void)upDataWithDict:(NSDictionary *)dict{
    
    NSMutableDictionary * data = [dict checkData:dict];
    
    self.title.text = data[@"msgTitle"];
    self.detail.text = data[@"createTime"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
