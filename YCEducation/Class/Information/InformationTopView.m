//
//  InformationTopView.m
//  YCEducation
//
//  Created by zhou on 2017/3/29.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "InformationTopView.h"
#import "InformationButton.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>

#define SP_WIDTH  135
@interface InformationTopView ()
{
    
    
}
@property(nonatomic,strong)InformationButton * second;
@property(nonatomic,strong)InformationButton * third;
@property(nonatomic,strong)InformationButton * fourth;


@end

@implementation InformationTopView

- (instancetype)initWithTop:(BOOL )top{
    
    self = [super init];
    
    if (self) {
        
        [self setSubViewsWithArray:top];
        self.backgroundColor = UICOLORRGB(0xf8f8f8);
        
    }
    return self;
}

- (void)setSubViewsWithArray:(BOOL )top{
    
    WEAKSELF(wk);
    
    _first = [LeftBtton sharButton];
//    _first.tag = 1;
//    [_first addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_first];
  
    
    _second = [InformationButton sharButton];
    _second.numberLB.text = @"0";
    _second.tag =1;
    _second.titleLB.text =top?@"待我审批":@"待我参与";
    [_second addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_second];
    
    _third = [InformationButton sharButton];
    _third.numberLB.text = @"0";
    _third.tag = 2;
    _third.titleLB.text = @"我发起的";
    [_third addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_third];
    
    _fourth = [InformationButton sharButton];
    _fourth.numberLB.text = @"0";
    _fourth.tag = 3;
    _fourth.titleLB.text = top?@"抄送我的":@"待我确认";
    [_fourth addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_fourth];
    
    
    [_first mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.height.equalTo(wk);
        make.width.mas_equalTo(SP_WIDTH);
        
        
    }];
    
    [_second mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.first.mas_right).offset(1);
        make.top.height.equalTo(wk.first);
        make.width.equalTo(wk.third);
    }];
    
    [_third mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wk.second.mas_right).offset(1);
        make.top.height.equalTo(wk.first);
        make.width.equalTo(wk.fourth);
        
    }];
    
    [_fourth mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.third.mas_right).offset(1);
        make.top.height.equalTo(wk.first);
        make.right.equalTo(wk);
        
    }];
    
    
}


- (void)click:(UIButton *)sender{
    
//    NSLog(@"%ld",(long)sender.tag);
    
    if (self.ButtonClick) {
    
        self.ButtonClick(sender.tag);
    }
    
    
    
    
}

- (void)fillInTheData:(NSDictionary *)dict{
    
    
    _first.titleLB.text = dict[@"funName"];
    [_first.leftImg sd_setImageWithURL:[NSURL URLWithString:dict[@"funIcon"]] placeholderImage:[UIImage imageNamed:@"b_sp"]options:SDWebImageRefreshCached];
    
    NSArray * arr = dict[@"printNumList"];
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary * dict = obj;
        NSLog(@"%@",obj);
        switch (idx) {
            case 0:
                _second.numberLB.text = [NSString stringWithFormat:@"%@",dict[@"num"]];
                _second.titleLB.text = dict[@"numName"];
                break;
            case 1:
                _third.numberLB.text =[NSString stringWithFormat:@"%@",dict[@"num"]];
                _third.titleLB.text = dict[@"numName"];
                break;
            case 2:
                _fourth.numberLB.text =[NSString stringWithFormat:@"%@",dict[@"num"]];
                _fourth.titleLB.text = dict[@"numName"];
                break;
            default:
                break;
        }
        
    }];
    
    
    
}





@end
