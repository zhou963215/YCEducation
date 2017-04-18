//
//  PageTableView.h
//  SupDoctor
//
//  Created by wyit on 16/1/19.
//  Copyright © 2016年 DingKou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

#pragma mark - paging protocol
@class PageTableView;
@protocol ASPagingTableProtocol<NSObject>

@required
- (UITableViewCell *)pagingTableView:(PageTableView *)pagingTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

@optional
- (void)pagingTableView:(PageTableView *)pagingTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object;

@optional
- (void)pagingTableView:(PageTableView *)pagingTableView didEndLoadPage:(NSInteger)page;

@end


@interface PageTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, assign) id <ASPagingTableProtocol> pagingTableProtocol;

@property(nonatomic, assign) NSInteger pageIndex;
@property(nonatomic, assign) NSInteger pageSize;
@property(nonatomic, assign) NSInteger pageCount;
@property(nonatomic, assign) NSInteger rowCount;

@property(nonatomic, retain) NSArray *rows;
@property(nonatomic, retain) NSArray *sections;

@property(nonatomic, retain) UIView *titleView;
@property(nonatomic, retain) UILabel *titleLabel;

@property(nonatomic, copy) NSString *sectionHeaderTitle;
@property(nonatomic, copy) NSString *sectionFooterTitle;
@property(nonatomic, retain) UIView *sectionHeaderView;
@property(nonatomic, retain) UIView *sectionFooterView;

@property(nonatomic, retain) UIView *emptyView;
@property(nonatomic, retain) UIView *noNetworkView;
@property(nonatomic,retain) NSString * notification;


- (void)refresh;
- (void)loadNext;

- (NSInteger)nextPage;
- (BOOL)hasNextPage;
- (void)endRefreshing;
- (void)upView;

@end
