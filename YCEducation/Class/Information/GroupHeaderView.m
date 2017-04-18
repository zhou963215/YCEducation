//
//  GroupHeaderView.m
//  YCEducation
//
//  Created by zhou on 2017/4/7.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "GroupHeaderView.h"

@implementation GroupHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        
    }
    
    return self;
}



- (void)setSubviews{

    if (_titleArr.count==0) {
        return;
    }
    
    
    WEAKSELF(wk);
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(wk).with.insets(UIEdgeInsetsMake(0,0,0,0));
    }];
    
    UIView *container = [UIView new];

    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.height.equalTo(scrollView);
    }];
    
    float butX = 16;
    
    UIView *lastView = nil;
    for(int i = 0; i < _titleArr.count; i++){
        
        //宽度自适应
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
        NSDictionary * dict = _titleArr[i];
        
        
        CGRect frame_W = [dict[@"groupName"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
        
        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(butX,7.5, frame_W.size.width, 30)];
        [but setTitle:dict[@"groupName"] forState:UIControlStateNormal];
        [but setTitleColor:i==_titleArr.count-1?UICOLORRGB(0x3ea0e6):UICOLORRGB(0x505050) forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:16];
       
        but.tag = i+100;
        [but addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:but];
        
        butX = CGRectGetMaxX(but.frame)+12;
        if (_titleArr.count>1&&i!=_titleArr.count-1) {
            
            UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(butX, 16.5, 12, 12)];
            image.image = [UIImage imageNamed:@"b_jt"];
            [container addSubview:image];
            
            butX = CGRectGetMaxX(image.frame)+12;
            lastView = image;
            
        }
        else{
            
            lastView = but;
  
        }
        
        
        
    }
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.mas_right).offset(15);
        
    }];






}

- (void)setTitleArr:(NSMutableArray *)titleArr{
    
    
    _titleArr = titleArr;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setSubviews];
    
}
- (void)click:(UIButton * )sender{
    
    
    if (self.ButtonClick) {
        
        NSDictionary * dict = self.titleArr[sender.tag-100];
        
        self.ButtonClick(dict);
        
    }
    
//    NSLog(@"%ld",(long)sender.tag);
    
    
}


@end
