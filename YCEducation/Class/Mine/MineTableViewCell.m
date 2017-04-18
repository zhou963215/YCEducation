//
//  MineTableViewCell.m
//  YCEducation
//
//  Created by zhou on 2017/3/27.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "MineTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSObject+Astray.h"
@interface MineTableViewCell()

@property(nonatomic,strong)UIImageView * headerImg;
@property(nonatomic,strong)UILabel * name;
@property(nonatomic,strong)UILabel * level;
@property(nonatomic,strong)UILabel * phone;
@property(nonatomic,strong)UILabel * teaching;

@end
@implementation MineTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setSubViews];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
    
}




- (void)setSubViews{
    
    UIImageView * image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@"m_bg"];
    [self addSubview:image];
    
    _headerImg = [UIImageView new];
    _headerImg.layer.masksToBounds = YES;
    _headerImg.layer.cornerRadius = 30;
    [self addSubview:_headerImg];
    
    _name = [UILabel new];
    _name.textColor = UICOLORRGB(0xfffefe);
//    _name.backgroundColor = [UIColor redColor];
    _name.font = [UIFont systemFontOfSize:18];
    _name.text = @"姓名";
    [self addSubview:_name];
    
    _level = [UILabel new];
    _level.layer.masksToBounds = YES;
    _level.layer.cornerRadius = 2;
    _level.backgroundColor = UICOLORRGB(0xcaa46c);
    _level.textColor = UICOLORRGB(0xffffff);
    _level.font = [UIFont systemFontOfSize:9];
    _level.text = @"  职务  ";
    [self addSubview:_level];
    
    _phone = [UILabel new];
    _phone.font = [UIFont systemFontOfSize:12];
    _phone.textColor = UICOLORRGB(0xfffefe);
    [self addSubview:_phone];
    
    _teaching = [UILabel new];
    _teaching.numberOfLines = 0;
    _teaching.textColor = UICOLORRGB(0xe6e6e6);
    _teaching.font = [UIFont systemFontOfSize:12];
    [self addSubview:_teaching];
    

    
    
    WEAKSELF(wk);
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.height.equalTo(wk);
    }];
    
    
    [_headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.equalTo(wk).offset(15);
        make.top.equalTo(wk).offset(54);
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(wk).offset(54);
        make.left.equalTo(wk.headerImg.mas_right).offset(18);
        make.height.mas_equalTo(@18);
        
        
    }];
    
    [_level mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.name.mas_right).offset(12);
        make.height.mas_equalTo(@13);
//        make.width.mas_equalTo(@70);
        make.top.equalTo(wk).offset(55);
    }];
    
    [_phone mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.left.equalTo(wk.name);
        make.top.equalTo(wk.name.mas_bottom).offset(7);
        make.height.mas_equalTo(@12);
        
    }];
    
    [_teaching mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.phone);
        make.top.equalTo(wk.phone.mas_bottom).offset(15);
        
    }];

    
}


- (void)upDataWithDict:(NSDictionary *)dict{
    
    self.headerImg.image = nil;
    NSMutableDictionary * data = [NSMutableDictionary dictionaryWithDictionary:dict];
    [data removeObjectForKey:@"otherJob"];
    data = [data checkData:data];
    

    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:data[@"headImg"]] placeholderImage:[UIImage imageNamed:@"m_tou"] options:SDWebImageRefreshCached];
    
        self.name.text = data[@"userName"];
    
    if ([data[@"xzJob"]isEqualToString:@""]) {
        
        self.level.hidden = YES;
        
    }
    self.level.text = [NSString stringWithFormat:@"  %@  ",data[@"xzJob"]];
    self.phone.text =[NSString stringWithFormat:@"手机号:  %@",data[@"phoneNum"]];
    
//    NSString * str1 = [self getStringWithArr:dict[@"otherJob"] withGruop:@"教研组"];
//    NSString * str2 = [self getStringWithArr:dict[@"otherJob"] withGruop:@"打分组"];
    
//    self.teaching.text = [NSString stringWithFormat:@"教研组:  %@",str1];
//    self.code.text = [NSString stringWithFormat:@"打分组:  %@",str2];
    self.teaching.text = [self getStringWithArr:dict[@"otherJob"]];
    
}



- (NSString * )getStringWithArr:(NSArray *)arr{
    
    NSMutableString  * str = [NSMutableString string];
    

    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSString *  s;
            if (idx !=arr.count-1) {
               s  = [NSString stringWithFormat:@"%@ :%@\n",obj[@"jobGroup"],obj[@"jobName"]];
                
            }
            else if(idx ==arr.count-1){
                s  = [NSString stringWithFormat:@"%@ :%@",obj[@"jobGroup"],obj[@"jobName"]];
            }
            [str appendString:s];

        }
        
    }];
    
    NSString * text = [NSString stringWithFormat:@"%@",str];
    
    return text;
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
