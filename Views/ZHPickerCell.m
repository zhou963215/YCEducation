//
//  ZHPickerCell.m
//  PickerCell
//
//  Created by zhou on 2016/11/24.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZHPickerCell.h"
#import "NSObject+Astray.h"


@interface ZHPickerCell()


@property(nonatomic, retain) UIView *actionView;
@property(nonatomic, retain) UIToolbar *toolbar;
@property(nonatomic, retain) UIBarButtonItem *doneButton;
@property(nonatomic, retain) UIPickerView *pickerView;
@property(nonatomic, retain) UISearchBar *searchBar;
@end

@implementation ZHPickerCell

- (instancetype)init {
    self = [super init];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return self;
}

- (instancetype)initWithRows:(NSArray *)rows rowValues:(NSArray *)rowValues {
    self = [self init];
    
    if (rows.count == rowValues.count) {
        self.rows = rows;
        self.rowValues = rowValues;
    }
    
    return self;
}

- (instancetype)initWithRowsAndValues:(NSDictionary *)rowWithValues {
    self = [self init];
    
    NSMutableArray *rows = [NSMutableArray new];
    NSMutableArray *rowValues = [NSMutableArray new];
    [rowWithValues enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [rows addObject:key];
        [rowValues addObject:obj];
    }];
    self.rows = rows;
    self.rowValues = rowValues;
    
    return self;
}
#pragma mark - public

- (void)setRows:(NSArray *)rows rowValues:(NSArray *)rowValues {
    self.rows = rows;
    self.rowValues = rowValues;
    [self.pickerView reloadComponent:0];
}

- (void)showSearchBar {
    [self.toolbar addSubview:self.searchBar];
}

- (BOOL)resignFirstResponder {
    [self hidePicker];
    return YES;
}
#pragma mark - override

- (void)doAction {
    if (self.disabled) {
        return;
    }
    [self.pickerView reloadComponent:0];
    UIView *superView = self.superview;
    while(![superView isMemberOfClass:[UITableView class]]){
        superView = superView.superview;
    }
    [superView endEditing:YES];
    [[UIApplication sharedApplication].delegate.window addSubview:self.actionView];
}

- (void)setTitle:(NSString *)title withValue:(id)value {
    if([title isNotEmptyString] && [value isNotNull]){
        self.label.text = title;
        self.values = @[value];
    }else if([value isNotNull]){
        [self.rowValues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if([obj isKindOfClass:[NSString class]]){
                NSString *str = obj;
                if([str isEqualToString:value]){
                    self.label.text = self.rows[idx];
                    self.values = @[value];
                    [self.pickerView selectRow:idx inComponent:0 animated:YES];
                    return;
                }
            }else if([obj isKindOfClass:[NSNumber class]]){
                NSNumber *number = obj;
                if(number == value){
                    self.label.text = self.rows[idx];
                    self.values = @[value];
                    [self.pickerView selectRow:idx inComponent:0 animated:YES];
                    return;
                }
            }
        }];
    }else if([title isNotEmptyString]){
        [self.rows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if([obj isKindOfClass:[NSString class]]){
                NSString *str = obj;
                if([str isEqualToString:title]){
                    self.label.text = title;
                    self.values = @[self.rowValues[idx]];
                    [self.pickerView selectRow:idx inComponent:0 animated:YES];
                    return;
                }
            }
        }];
    }
    
    if (self.disabled) {
        self.label.textColor = [UIColor grayColor];
    } else {
        self.label.textColor = [UIColor blackColor];
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

- (void)search:(NSString *)word {
    [self.rows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *row = obj;
        if ([row rangeOfString:word].length > 0) {
            [self.pickerView selectRow:idx inComponent:0 animated:YES];
            return;
        }
    }];
}


- (void)resetOffset {
    [UIView animateWithDuration:0.3 animations:^{
        self.actionView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    }];
}


#pragma mark - event

- (void)tapDone {
    if (self.rows.count > 0) {
        NSInteger row = [self.pickerView selectedRowInComponent:0];
        NSString *title = self.rows[(NSUInteger) row];
        id value = self.rowValues[(NSUInteger) row];
        [self setTitle:title withValue:value];
    }

    [self hidePicker];
}

- (void)changeKeyboardFrame:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    
    //计算偏移量
    CGFloat heightOffset = - keyboardHeight;
    [UIView animateWithDuration:0.3 animations:^{
        self.actionView.frame = CGRectMake(0, heightOffset, WIDTH, HEIGHT);
    }];
}


#pragma mark - picker protocol

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.rows.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = self.rows[(NSUInteger) row];
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *title = self.rows[(NSUInteger) row];
    id value = self.rowValues[(NSUInteger) row];
    [self setTitle:title withValue:value];
}


#pragma mark - search protocol

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self search:searchText];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self search:searchBar.text];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeKeyboardFrame:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(changeKeyboardFrame:)
    //                                                 name:UIKeyboardWillHideNotification
    //                                               object:nil];
    //#ifdef __IPHONE_5_0
    //    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    //    if (version >= 5.0) {
    //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeKeyboardFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //    }
    //#endif
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    [self resetOffset];
}


#pragma mark - getter

- (UIView *)actionView {
    if (!_actionView) {
        _actionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,WIDTH , HEIGHT)];
        [_actionView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePicker)]];
        
        [_actionView addSubview:self.toolbar];
        [_actionView addSubview:self.pickerView];
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

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        CGFloat width = WIDTH - 80;
        CGFloat height = 40;
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _searchBar.center = CGPointMake(15 + width / 2, TOOLBAR_HEIGHT / 2);
        _searchBar.placeholder = @"搜索";
        _searchBar.delegate = self;
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    }
    return _searchBar;
}

- (UIBarButtonItem *)doneButton {
    if (!_doneButton) {
        _doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(tapDone)];
    }
    return _doneButton;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, HEIGHT - UIPICKERVIEW_HEIGHT, WIDTH, UIPICKERVIEW_HEIGHT)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.backgroundColor = [UIColor whiteColor];
        
    }
    return _pickerView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
