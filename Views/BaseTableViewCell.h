//
//  BaseTableViewCell.h
//  PickerCell
//
//  Created by zhou on 2016/11/24.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIPICKERVIEW_HEIGHT     216
#define TOOLBAR_HEIGHT      44
#define NAVI_HEIGHT     self.controller.navigationController.navigationBar.bounds.size.height
#define WIDTH  [UIScreen mainScreen].bounds.size.width

@interface BaseTableViewCell : UITableViewCell
@property(nonatomic, retain) UIView *fieldView;
@property(nonatomic, retain) NSArray *values;
@property(nonatomic, retain) NSArray *keys;

@property(nonatomic, assign) CGFloat rowHeight;

@property(nonatomic, assign) BOOL disabled;


- (void)setKey:(NSString *)key;

/*
 * override
 * */
- (void)setTitle:(NSString *)title withValue:(id)value;
- (void)setTitles:(NSArray *)titles withValues:(NSArray *)values;

- (NSDictionary *)keysAndValues;

//- (void)addTargetForValueChange:(id)target action:(SEL)action;

@end
