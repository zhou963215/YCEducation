//
//  InputTableViewCell.h
//  RaisePo
//
//  Created by zhou on 2016/12/1.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface InputTableViewCell : UITableViewCell
@property(nonatomic,copy)NSString * value;
@property(nonatomic,strong)UILabel * nameLB;
@property(nonatomic,strong)UITextField * inupt;


- (void)editStyle:(BOOL)change;
- (void)boldLine;
- (void)setValue:(NSString*)value labelText:(NSString*)text;
- (void)addRightLBWithTitle:(NSString*)title;
- (instancetype)initWithValue:(NSString *)value tip:(NSString * )tip title:(NSString *)title;
@end
