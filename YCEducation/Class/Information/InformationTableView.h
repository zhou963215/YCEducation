//
//  InformationTableView.h
//  YCEducation
//
//  Created by zhou on 2017/3/30.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InformationHeader.h"
@interface InformationTableView : NSObject<UITableViewDelegate,UITableViewDataSource>

+(instancetype)blog;
- (UITableView *)tableView;
- (void)change:(UIButton *)sender;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)NSArray * apList;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,assign)CGFloat height;

@end
