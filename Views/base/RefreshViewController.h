//
//  BaseRefreshViewController.h
//  YCEducation
//
//  Created by zhou on 2017/2/20.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

@interface RefreshViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property (strong, nonatomic) NSMutableArray *data;

@property(nonatomic, assign) NSInteger pageIndex;
@property(nonatomic, assign) NSInteger pageSize;
@property(nonatomic, assign) int pageCount;
@property(nonatomic, assign) NSInteger rowCount;

@end
