//
//  SelectView.m
//  YCEducation
//
//  Created by zhou on 2017/4/7.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "SelectGroupView.h"

@implementation SelectGroupView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    
    return self;
}
- (void)setreMenUI{
    
    
    
    UIImageView *shuimg= [[UIImageView alloc]initWithFrame:CGRectMake(15, 16, 17, 17)];
    shuimg.image = [UIImage imageNamed:@"b_yxz"];
    [self addSubview:shuimg];
    
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc]initWithString:@"已选择(点击可删除)"];
   
    [str addAttribute:NSForegroundColorAttributeName value:UICOLORRGB(0x646464) range:NSMakeRange(0,3)];
    [str addAttribute:NSForegroundColorAttributeName value:UICOLORRGB(0xb4b4b4) range:NSMakeRange(3,7)];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(shuimg.frame)+10, CGRectGetMinY(shuimg.frame), 200, 20)];
    lab.attributedText = str;
    lab.font = [UIFont systemFontOfSize:16];
    [self addSubview:lab];

    
    float butX = 26;
    float butY = CGRectGetMaxY(shuimg.frame)+17;
    for(int i = 0; i < _dataArr.count; i++){
        
        //宽度自适应
        NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        NSDictionary * dict =_dataArr[i];
        
        CGRect frame_W = [dict[@"m_name"] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
        
        if (butX+frame_W.size.width>WIDTH-26) {
            
            butX = 26;
            
            butY += 28;
        }
        
        UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(butX, butY, frame_W.size.width, 13)];
        [but setTitle:dict[@"m_name"]forState:UIControlStateNormal];
        [but setTitleColor:UICOLORRGB(0x3ea0e6) forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:14];
        but.tag = i+1;
        [but addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:but];
        
        butX = CGRectGetMaxX(but.frame)+18;
    }
    
    CGRect rect = self.frame;
    rect.size.height = butY + 30;
    self.frame = rect;
}
- (void)click:(UIButton * )sender{
    
    NSLog(@"%ld",(long)sender.tag);
    
    NSDictionary * dict  = self.dataArr[sender.tag-1];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"delete" object:dict];
    
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_dataArr removeObjectAtIndex:sender.tag-1];
    [self setreMenUI];
    
    
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    
    
    _dataArr = dataArr;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setreMenUI];
    
}


@end
