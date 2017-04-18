//
//  ZHFormActionCell.h
//  PickerCell
//
//  Created by zhou on 2016/11/24.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@interface ZHFormActionCell : BaseTableViewCell
@property(nonatomic, retain) UILabel *label;
@property(nonatomic, copy) NSString *placeholder;


/*
 * override
 * */
- (void)doAction;

//- (void)addTargetForTapAction:(id)target action:(SEL)action;

@end
