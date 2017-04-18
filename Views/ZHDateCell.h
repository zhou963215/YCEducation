//
//  ZHDateCell.h
//  PickerCell
//
//  Created by zhou on 2016/11/24.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHFormActionCell.h"
@interface ZHDateCell : ZHFormActionCell
@property(nonatomic, assign) BOOL fromNow;
@property(nonatomic, assign) BOOL toNow;

@property(nonatomic, assign) BOOL showDate;
@property(nonatomic, assign) BOOL showTime;

@property(nonatomic, copy) NSString *dateFormat;

@end
