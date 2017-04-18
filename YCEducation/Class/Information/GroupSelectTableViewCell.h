//
//  GroupSelectTableViewCell.h
//  YCEducation
//
//  Created by zhou on 2017/4/7.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupSelectTableViewCell : UITableViewCell
@property(nonatomic,strong)UIButton * nextBtn;
@property(nonatomic,strong)UIButton * selectBtn;

- (void)upDataWithNSDictory:(NSDictionary *)dict withBool:(BOOL)isOnly;

@end
