//
//  LoginTextField.m
//  YCEducation
//
//  Created by zhou on 2017/3/15.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "LoginTextField.h"

@implementation LoginTextField

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        self.font = [UIFont systemFontOfSize:15];
        self.backgroundColor = [UIColor whiteColor];
        self.placeholder = @"点击输入";
    }
    
    return self;
    
}
//- (CGRect)borderRectForBounds:(CGRect)bounds{
//    CGRect inset = CGRectMake(bounds.origin.x+16, bounds.origin.y, bounds.size.width-16, bounds.size.height);//更好理解些
//    return inset;
//}
- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x+16, bounds.origin.y, bounds.size.width-16, bounds.size.height);//更好理解些
    return inset;
}
- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x+16, bounds.origin.y, bounds.size.width-16, bounds.size.height);//更好理解些
    return inset;
}




@end
