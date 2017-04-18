//
//  DownRefreshVC.h
//  SupDoctor
//
//  Created by wyit on 16/1/19.
//  Copyright © 2016年 DingKou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASPageTableView.h"
#import "PageTableView.h"


@interface DownRefreshVC :UIViewController <ASPagingTableProtocol>

@property(nonatomic, retain) ASPageTableView *pagingTableView;

@property(nonatomic, copy) NSString *url;
@property(nonatomic, retain) NSDictionary *parameter;

@property(nonatomic, assign) NSInteger pageSize;

@property(nonatomic, copy) NSString *sectionHeaderTitle;
@property(nonatomic, copy) NSString *sectionFooterTitle;
@property(nonatomic, retain) UIView *sectionHeaderView;
@property(nonatomic, retain) UIView *sectionFooterView;
- (void)hiddenLeft;
- (void)refresh;
@end
