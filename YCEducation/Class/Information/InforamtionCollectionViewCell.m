//
//  InforamtionCollectionViewCell.m
//  YCEducation
//
//  Created by zhou on 2017/3/30.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "InforamtionCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface InforamtionCollectionViewCell ()
@property(nonatomic,strong)UILabel * titleLB;
@property(nonatomic,strong)UIImageView * imageView;


@end
@implementation InforamtionCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setSubview];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


- (void)setSubview
{
    
    _titleLB = [UILabel new];
    _titleLB.textColor = UICOLORRGB(0x282828);
    _titleLB.font =[UIFont systemFontOfSize:15];
    [self addSubview:_titleLB];
    
    _imageView  = [UIImageView new];
    [self addSubview:_imageView];
    
    WEAKSELF(wk);
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(wk);
        make.top.equalTo(wk).offset(29);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }] ;
    
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(wk);
        make.bottom.equalTo(wk);
    }];
    
    
    
}

- (void)setDataWithDict:(NSDictionary *)dict{
    
    NSString * str = dict[@"apIcon"];
    if (str.length>10) {
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"apIcon"]]placeholderImage:nil options:SDWebImageRefreshCached];
        
    }
    else{
        self.imageView.image  =[UIImage imageNamed:dict[@"apIcon"]];
    }
    self.titleLB.text = dict[@"apName"];
    
    
}


@end
