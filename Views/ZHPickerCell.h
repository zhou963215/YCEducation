//
//  ZHPickerCell.h
//  PickerCell
//
//  Created by zhou on 2016/11/24.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHFormActionCell.h"
@interface ZHPickerCell : ZHFormActionCell<UIPickerViewDelegate,UIPickerViewDataSource,UISearchBarDelegate, UITextFieldDelegate>
@property(nonatomic, retain) NSArray *rows;
@property(nonatomic, retain) NSArray *rowValues;

- (instancetype)initWithRows:(NSArray *)rows rowValues:(NSArray *)rowValues;
- (instancetype)initWithRowsAndValues:(NSDictionary *)rowWithValues;

- (void)showSearchBar;

- (void)setRows:(NSArray *)rows rowValues:(NSArray *)rowValues;
@end
