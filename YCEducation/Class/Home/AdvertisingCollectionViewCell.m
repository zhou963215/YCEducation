//
//  AdvertisingCollectionViewCell.m
//  YCEducation
//
//  Created by zhou on 2017/3/16.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "AdvertisingCollectionViewCell.h"
#import "NSObject+Astray.h"
@interface AdvertisingCollectionViewCell ()

@property(nonatomic,strong)UILabel * title;
@property(nonatomic,strong)UILabel * detail;

@end


@implementation AdvertisingCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setSubview];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setSubview{
    
    
    self.title = [UILabel new];
    self.title.textColor = UICOLORRGB(0x282828);
    self.title.numberOfLines = 2;
    self.title.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.title];
    
    self.detail = [UILabel new];
    self.detail.textColor = UICOLORRGB(0x787878);
    self.detail.font = [UIFont systemFontOfSize:11];
    [self addSubview:self.detail];
    
    
    WEAKSELF(wk);
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(wk).offset(11);
        make.left.equalTo(wk).offset(12);
        make.right.equalTo(wk).offset(-16);
        
        
    }];
    
    [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.title);
        make.bottom.equalTo(wk).offset(-11);
        make.height.mas_equalTo(@18);
    }];
    
    
    
}
- (void)setDataWithDict:(NSDictionary * )dict{
    
    NSDictionary * data = [dict checkData:dict];
   
    self.title.text = data[@"title"];
    self.detail.text = [NSString stringWithFormat:@"来源:  %@    %@",data[@"from"],data[@"ctime"]];
    
}

@end
