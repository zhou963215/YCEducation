//
//  MineTableViewVC.h
//  YCEducation
//
//  Created by zhou on 2017/3/27.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MineTableViewVC : NSObject<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSDictionary * headerDict;

+(instancetype)share;
- (UITableView *)tableView;
- (void)getData;
@end
