//
//  BaseTableViewCell.m
//  PickerCell
//
//  Created by zhou on 2016/11/24.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "BaseTableViewCell.h"
@implementation BaseTableViewCell

- (instancetype)init {
    self = [self initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addSubview:self.fieldView];
    self.textLabel.font = [UIFont systemFontOfSize:16];
    
    return self;
}
#pragma mark - public

- (void)setTitle:(NSString *)title withValue:(id)value {}

- (void)setTitles:(NSArray *)titles withValues:(id)values {}

- (void)setKey:(NSString *)key {
    self.keys = @[key];
}

- (NSDictionary *)keysAndValues {
    NSMutableDictionary *kvs = [NSMutableDictionary new];
    if(self.values.count == self.keys.count){
        [self.values enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *key = self.keys[idx];
            id value = obj;
            kvs[key] = value;
        }];
    }
    return kvs;
}

#pragma mark - getter

- (UIView *)fieldView {
    if(!_fieldView){
        _fieldView = [[UIView alloc] initWithFrame:CGRectMake((CGFloat) (WIDTH*0.4-30), 0, (CGFloat) (WIDTH*0.6), self.frame.size.height)];
        _fieldView.center = CGPointMake(_fieldView.center.x, self.frame.size.height/2);
    }
    return _fieldView;
}

- (CGFloat)rowHeight {
    if(_rowHeight == 0){
        _rowHeight = 44;
    }
    return _rowHeight;
}
- (NSArray *)values {
    if(!_values){
        _values = [NSArray new];
    }
    return _values;
}

- (NSArray *)keys {
    if(!_keys){
        _keys = [NSArray new];
    }
    return _keys;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
