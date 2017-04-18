//
//  ZHFormActionCell.m
//  PickerCell
//
//  Created by zhou on 2016/11/24.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "ZHFormActionCell.h"

@implementation ZHFormActionCell

- (instancetype)init{
    
    self = [super init];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self.fieldView  addSubview:self.label];
    [self.fieldView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doAction)]];
    
    return self;
    
    
}

#pragma mark - public

- (void)doAction {

}

- (void)setTitles:(NSArray *)titles withValues:(NSArray *)values {
    [self setTitle:titles[0] withValue:values[0]];
}

- (void)setTitle:(NSString *)title withValue:(id)value {
    self.label.text = title;
    self.values = @[value];
}


- (void)setDisabled:(BOOL)disabled {
    [super setDisabled:disabled];
    if(!disabled){
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _label.textColor = [UIColor blackColor];
    }else{
        self.accessoryType = UITableViewCellAccessoryNone;
        _label.textColor = [UIColor grayColor];
    }
}


#pragma mark - getter

- (UILabel *)label {
    if(!_label){
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.fieldView.frame.size.width, 20)];
        _label.center = CGPointMake(self.fieldView.frame.size.width/2, self.fieldView.frame.size.height/2);
        _label.textAlignment = NSTextAlignmentRight;
        _label.font = [UIFont systemFontOfSize:14];
    }
    return _label;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
