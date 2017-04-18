//
//  HeaderTableViewCell.m
//  YCEducation
//
//  Created by zhou on 2017/3/28.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "HeaderTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation HeaderTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setSubViews];
    }
    
    return self;
    
}

- (void)setSubViews{
    
    _header = [UIImageView new];
    _header.layer.masksToBounds = YES;
    _header.layer.cornerRadius = 20;
    [_header sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"m_bg"]];
    [self addSubview:_header];
    
    WEAKSELF(wk);
    
    [_header mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(wk);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.equalTo(wk).offset(-32);
    }];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
