//
//  PageTableView.m
//  SupDoctor
//
//  Created by wyit on 16/1/19.
//  Copyright © 2016年 DingKou. All rights reserved.
//

#import "PageTableView.h"

@interface PageTableView ()

@end

@implementation PageTableView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    self.dataSource = self;
    self.delegate = self;
    
//    self.tableHeaderView = self.titleView;
//    self.tableFooterView = [UIView new];
    
    self.backgroundColor = UICOLORRGB(0xffffff);
    self.separatorColor = UICOLORRGB(0xe5e5e5);
    
    
    //header
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载 ..." forState:MJRefreshStateRefreshing];
    header.stateLabel.font = [UIFont systemFontOfSize:14];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    self.mj_header = header;
    
    //footer
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNext)];
    [footer setTitle:@"点击上拉刷新" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载 ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    self.mj_footer = footer;
    
    self.mj_footer.hidden=YES;
   
    [self addSubview:self.emptyView];
    [self addSubview:self.noNetworkView];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame style:UITableViewStyleGrouped];
}

- (void)showEmptyView{
    [self addSubview:self.emptyView];
}

- (void)hideEmptyView{
    [self.emptyView removeFromSuperview];
}

#pragma mark - data method

- (void)refresh {
//    [self.mj_header beginRefreshing];
    self.emptyView.hidden = YES;
    self.noNetworkView.hidden = YES;
    [self loadPage:1];

}

- (void)loadNext{
    //if current page is not the last
    if([self hasNextPage]){
        //load next page data
        [self loadPage:self.nextPage];
    }else{
        [self endRefreshing];
    }
}

- (void)loadPage:(NSInteger)page{
    //override
    
    
}

//错误的情况恢复请求
- (void)reloadPage{
    
    [self.mj_header beginRefreshing];
    [self refresh];
}


#pragma mark - page method

- (NSInteger)nextPage {
    if(self.hasNextPage){
        return self.pageIndex + 1;
    }
    return 0;
}

- (BOOL)hasNextPage
{
    
    return self.pageIndex >=0 && self.pageIndex < self.pageCount;
}

- (void)endRefreshing{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    if(self.rowCount == 0){
        [self.mj_footer endRefreshingWithNoMoreData];
    }else if(![self hasNextPage]){
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}


#pragma mark - table datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([self.pagingTableProtocol respondsToSelector:@selector(pagingTableView:cellForRowAtIndexPath:withObject:)]){
        if(self.rows.count>0){
            
            return [self.pagingTableProtocol pagingTableView:self cellForRowAtIndexPath:indexPath withObject:self.rows[(NSUInteger) indexPath.row]];
        }
    }
    
    return [UITableViewCell new];
}


#pragma mark - table delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(self.sectionHeaderHeight <= 0){
        return 0.0001;
    }
    return self.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(self.sectionFooterHeight <= 0){
        return 0.0001;
    }
    return self.sectionFooterHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([self.pagingTableProtocol respondsToSelector:@selector(pagingTableView:didSelectRowAtIndexPath:withObject:)]){
        [self.pagingTableProtocol pagingTableView:self didSelectRowAtIndexPath:indexPath withObject:self.rows[(NSUInteger) indexPath.row]];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionHeaderTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return self.sectionFooterTitle;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.sectionHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.sectionFooterView;
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //设置Cell的动画效果为3D效果
//    //设置x和y的初始值为0.1；
//    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//    //x和y的最终值为1
//    [UIView animateWithDuration:1 animations:^{
//        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//        
//    }];
//}

#pragma mark - setter

- (void)setRowCount:(NSInteger)rowCount
{
    _rowCount = rowCount;
    self.pageCount = (rowCount) / self.pageSize;
}



#pragma mark - getter

- (NSArray *)rows
{
    if(!_rows)
    {
        _rows = [[NSArray alloc] init];
    }
    
    return _rows;
}

- (NSInteger)pageSize
{
    if(_pageSize == 0)
    {
        _pageSize = 20;
    }
    return _pageSize;
}

- (UIView *)titleView {
    if(!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 24)];
        [_titleView addSubview:self.titleLabel];
    }
    return _titleView;
}

- (UILabel *)titleLabel {
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH-30, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = UICOLORRGB(0x787878);
        _titleLabel.backgroundColor = UICOLORRGB(0xf5f5f5);
        _titleLabel.center = self.titleView.center;
    }
    return _titleLabel;
}

- (UIView *)emptyView {
    if(!_emptyView){
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
        _emptyView.center = self.center;
        _emptyView.hidden = YES;
        
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_data"]];
        image.center = CGPointMake(100, 0);
        [_emptyView addSubview:image];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        label.center = CGPointMake(100, 70);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"暂无记录";
        label.textColor = [UIColor lightGrayColor];
        [_emptyView addSubview:label];
    }
    return _emptyView;
}

- (UIView *)noNetworkView {
    if(!_noNetworkView){
        _noNetworkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)];
//        _noNetworkView.backgroundColor = [UIColor redColor];
        _noNetworkView.center = self.center;
        _noNetworkView.hidden = YES;
        
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wifi"]];
        image.center = CGPointMake(100, 0);
        [_noNetworkView addSubview:image];
        
        UILabel *noticeTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        noticeTitle.center = CGPointMake(100, 60);
        noticeTitle.text = @"网络请求失败";
        noticeTitle.font = [UIFont boldSystemFontOfSize:16];
        noticeTitle.textAlignment = NSTextAlignmentCenter;
        noticeTitle.textColor = [UIColor lightGrayColor];
        [_noNetworkView addSubview:noticeTitle];
        
        UILabel *noticeContent = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
        noticeContent.center = CGPointMake(100, 90);
        noticeContent.text = @"请检查您的网络\n重新加载吧";
        noticeContent.font = [UIFont systemFontOfSize:10];
        noticeContent.numberOfLines = 2;
        noticeContent.textAlignment = NSTextAlignmentCenter;
        noticeContent.textColor = [UIColor lightGrayColor];
        [_noNetworkView addSubview:noticeContent];
        
        UIButton *reload = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        reload.center = CGPointMake(100, 130);
        [reload setTitle:@"重新加载" forState:UIControlStateNormal];
        [reload setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        reload.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        reload.layer.masksToBounds = YES;
        reload.layer.cornerRadius = 3;
        reload.layer.borderWidth = 0.5;
        reload.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [reload addTarget:self action:@selector(reloadPage) forControlEvents:UIControlEventTouchUpInside];
        [_noNetworkView addSubview:reload];
    }
    return _noNetworkView;
}
- (void)upView{
    CGPoint center = self.center;
    center.y = self.bounds.size.height/2;
    center.x = self.bounds.size.width/2;
    self.noNetworkView.center = center;
    self.emptyView.center =center;
}

@end
