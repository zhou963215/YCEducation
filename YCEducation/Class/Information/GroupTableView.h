//
//  GroupTableView.h
//  YCEducation
//
//  Created by zhou on 2017/4/7.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupHeaderView.h"
#import "GroupSelectTableViewCell.h"
@interface GroupTableView : NSObject<UITableViewDelegate,UITableViewDataSource>
+(instancetype)blog;
- (void)getData;
- (void)nextBtnClick:(UIButton *)sender;
- (void)selectBtnClick:(UIButton *)sender;
@property (strong, nonatomic) UITableView *tableView;
@property(nonatomic,strong)NSDictionary * paramter;

@property(nonatomic,strong)NSArray * titleArr;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,assign)BOOL isOnly;

@end
