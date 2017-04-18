//
//  ZHDateCell.m
//  PickerCell
//
//  Created by zhou on 2016/11/24.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZHDateCell.h"
#import "NSObject+Astray.h"
#import "NSDate+util.h"
@interface ZHDateCell ()
@property(nonatomic, retain) UIView *actionView;
@property(nonatomic, retain) UIToolbar *toolbar;
@property(nonatomic, retain) UIBarButtonItem *doneButton;
@property(nonatomic, retain) UIDatePicker *datePicker;

@property(nonatomic, retain) NSDate *date;

@property(nonatomic, retain) NSArray *path;


@end


@implementation ZHDateCell
- (instancetype)init {
    self = [super init];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return self;
}

#pragma mark - override

- (void)doAction {
    if (self.disabled) {
        return;
    }
    UIView *superView = self.superview;
    while(![superView isMemberOfClass:[UITableView class]]){
        superView = superView.superview;
    }
    [superView endEditing:YES];
    [[UIApplication sharedApplication].delegate.window addSubview:self.actionView];
}

- (void)setTitle:(NSString *)title withValue:(id)value {
    if (![title isNotEmptyString]) {
        return;
    }
    self.label.text = title;
    if (self.disabled) {
        self.label.textColor = [UIColor grayColor];
    } else {
        self.label.textColor = [UIColor blackColor];
    }
    
    if (value == nil) {
        return;
    }
    NSObject *obj = value;
    if ([obj isKindOfClass:[NSDate class]]) {
        NSDate *date = (NSDate *) obj;
        self.values = @[date];
        self.datePicker.date = date;
    } else if ([obj isKindOfClass:[NSString class]]) {
        NSString *dateString = (NSString *) obj;
        NSDate *date = [NSDate dateWithString:dateString];
        self.values = @[date];
        self.datePicker.date = date;
    } else {
        self.values = @[[NSDate date]];
    }
}

- (void)setTitles:(NSArray *)titles withValues:(NSArray *)values {
    if (values.count > 0) {
        [self setTitle:titles[0] withValue:values[0]];
    } else {
        [self setTitle:titles[0] withValue:nil];
    }
}

- (void)setDisabled:(BOOL)disabled {
    [super setDisabled:disabled];
    if (disabled) {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.label.textColor = [UIColor grayColor];
    } else {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.label.textColor = [UIColor blackColor];
    }
}


- (void)setRowHeight:(CGFloat)rowHeight {
    [super setRowHeight:rowHeight];
    CGRect frame = self.fieldView.frame;
    frame.size.height = rowHeight;
    self.fieldView.frame = frame;
    self.label.center = CGPointMake(self.fieldView.frame.size.width/2, self.fieldView.frame.size.height/2);
}


#pragma mark - private

- (void)hidePicker {
    [self.actionView removeFromSuperview];
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (self.values.count == 0 && !self.disabled) {
        self.label.text = placeholder;
        self.label.textColor = UICOLORRGB(0xcccccc);
    }
}


#pragma mark - event

- (void)tapDone {
    [self setTitleFromPicker];
//    if (self.valueChangedTarget && self.valueChangedAction) {
//        [self.valueChangedTarget performSelector:self.valueChangedAction withObject:self];
//    }
    [self hidePicker];
}

- (void)setTitleFromPicker {
    NSDate *date = self.datePicker.date;
    NSString *dateString = [date dateStringWithFormat:self.dateFormat];
    [self setTitle:dateString withValue:date];
}


#pragma mark - getter

- (UIView *)actionView {
    if (!_actionView) {
        _actionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        [_actionView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePicker)]];
        
        [_actionView addSubview:self.toolbar];
        [_actionView addSubview:self.datePicker];
    }
    return _actionView;
}

- (UIToolbar *)toolbar {
    if (!_toolbar) {
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, HEIGHT - UIPICKERVIEW_HEIGHT - TOOLBAR_HEIGHT, WIDTH, TOOLBAR_HEIGHT)];
        NSArray *toolbarItems = @[
                                  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                  self.doneButton,
                                  [[UIBarButtonItem alloc] initWithCustomView:[UIView new]]
                                  ];
        [_toolbar setItems:toolbarItems animated:YES];
    }
    return _toolbar;
}

- (UIBarButtonItem *)doneButton {
    if (!_doneButton) {
        _doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(tapDone)];
        
    }
    return _doneButton;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, HEIGHT - UIPICKERVIEW_HEIGHT, WIDTH, UIPICKERVIEW_HEIGHT)];
        _datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [_datePicker addTarget:self action:@selector(setTitleFromPicker) forControlEvents:UIControlEventValueChanged];
        
        if (self.showDate && self.showTime) {
            _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        } else if (self.showDate) {
            _datePicker.datePickerMode = UIDatePickerModeDate;
        } else if (self.showTime) {
            _datePicker.datePickerMode = UIDatePickerModeTime;
        } else {
            _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        }
        
        if (self.fromNow) {
            _datePicker.minimumDate = [NSDate date];
        }
        if (self.toNow) {
            _datePicker.maximumDate = [NSDate date];
        }
    }
    return _datePicker;
}

- (NSString *)dateFormat {
    if (!_dateFormat) {
        _dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    return _dateFormat;
}





@end
