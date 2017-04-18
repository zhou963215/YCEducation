//
//  SubjectTableViewCell.m
//  RaisePo
//
//  Created by zhou on 2016/12/1.
//  Copyright © 2016年 zhou. All rights reserved.
//




#import "SubjectTableViewCell.h"

@interface SubjectTableViewCell()<UITextViewDelegate>

@end


@implementation SubjectTableViewCell


- (instancetype)init{
    
    self = [super init];
    return self;
}
- (instancetype)initWithTitle:(NSString*)title subject:(NSString *)subject height:(CGFloat)height{
    
    self =  [super init];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setSubviews];
    _inupt.text = subject;
    _nameLB.text = title;
    _value = @"";
  
    self.backgroundColor = [UIColor whiteColor];
    
    
    return self;
}

- (void)setSubviews{
    
    WEAKSELF(wk);
    
    self.nameLB = [UILabel new];
    self.nameLB.textColor = UICOLORRGB(0x777777);
    self.nameLB.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.nameLB];

    self.inupt = [UITextView new];
    _inupt.delegate = self;
    _inupt.scrollEnabled = NO;
    _inupt.font = [UIFont systemFontOfSize:14];
    _inupt.textColor = UICOLORRGB(0x8f8f8f);
    [self addSubview:self.inupt];
    [self.nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk).offset(20);
        make.height.mas_offset(@20);
        make.top.equalTo(wk).offset(11);
    }];

    
    [_inupt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wk).offset(21);
        make.right.equalTo(wk).offset(-19);
        make.top.equalTo(wk.nameLB.mas_bottom).offset(8);
        make.bottom.equalTo(wk.mas_bottom).offset(-11);
    }];
    
   
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if (textView.text.length>0) {
         self.value = textView.text;
    }
    else{
        textView.text = @"请输入任务描述";
        self.value = @"";
    }
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@"请输入任务描述"]) {
     
        textView.text = @"";
      
    }
    
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    CGRect bounds = textView.bounds;
    // 计算 text view 的高度
    CGSize maxSize = CGSizeMake(WIDTH-30, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    bounds.size = newSize;
//    textView.bounds = bounds;
//    textView.frame = CGRectMake(21, 39, WIDTH-30, bounds.size.height);
    if (self.UPHeight) {
        self.UPHeight(bounds.size.height+50);
    }
    
    
  }

- (void)setValue:(NSString*)value labelText:(NSString*)text{
    
    self.value = value;
    self.inupt.text = text;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
