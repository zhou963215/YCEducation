//
//  DownRefreshVC.m
//  SupDoctor
//
//  Created by wyit on 16/1/19.
//  Copyright © 2016年 DingKou. All rights reserved.
//

#import "DownRefreshVC.h"

@interface DownRefreshVC ()

@property(nonatomic,strong) UIButton * btnLeft;

@end

@implementation DownRefreshVC
- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationController.navigationBar.translucent=NO;
    [self.navigationController.navigationBar setBarTintColor:UICOLORRGB(0x35ace1)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIButton  *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backLastView) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 60, 40);
    //    [leftBtn setBackgroundColor:[UIColor redColor]];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 46);
    
    //将leftItem设置为自定义按钮
    UIBarButtonItem  *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.view.backgroundColor = [UIColor whiteColor];
     self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.navigationController.navigationBar.translucent = NO;
}


- (void)hiddenLeft{
    
    self.navigationItem.leftBarButtonItem = nil;
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view addSubview:self.pagingTableView];
    [self.view sendSubviewToBack:self.pagingTableView];
    //    [self.view sendSubviewToBack:self.tableView];
    //    self.tableView = self.pagingTableView;
}

- (void)refresh {
    [self.pagingTableView refresh];
}


#pragma mark - paging protocol

- (UITableViewCell *)pagingTableView:(PageTableView *)pagingTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    //override
    return nil;
}

- (void)pagingTableView:(PageTableView *)pagingTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withObject:(id)object {
    //override
}

- (void)pagingTableView:(PageTableView *)pagingTableView didEndLoadPage:(NSInteger)page {
    //    [self setIsLoading:NO];
}


#pragma mark - setter

- (void)setUrl:(NSString *)url {
    _url = url;
    self.pagingTableView.url = url;
}

- (void)setParameter:(NSDictionary *)parameter {
    _parameter = parameter;
    self.pagingTableView.parameter = parameter;
}


- (void)setPageSize:(NSInteger)pageSize {
    _pageSize = pageSize;
    self.pagingTableView.pageSize = pageSize;
}

- (void)setSectionHeaderTitle:(NSString *)sectionHeaderTitle {
    _sectionHeaderTitle = sectionHeaderTitle;
    self.pagingTableView.sectionHeaderTitle = sectionHeaderTitle;
}

- (void)setSectionFooterTitle:(NSString *)sectionFooterTitle {
    _sectionFooterTitle = sectionFooterTitle;
    self.pagingTableView.sectionFooterTitle = sectionFooterTitle;
}

- (void)setSectionHeaderView:(UIView *)sectionHeaderView {
    _sectionHeaderView = sectionHeaderView;
    self.pagingTableView.sectionHeaderView = sectionHeaderView;
}

- (void)setSectionFooterView:(UIView *)sectionFooterView {
    _sectionFooterView = sectionFooterView;
    self.pagingTableView.sectionFooterView = sectionFooterView;
}

#pragma mark - getter

- (ASPageTableView *)pagingTableView {
    if(!_pagingTableView){
        _pagingTableView = [[ASPageTableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH,self.view.bounds.size.height)];
        _pagingTableView.pagingTableProtocol = self;
        _pagingTableView.separatorStyle = UITableViewCellSelectionStyleNone;

    }
    return _pagingTableView;
}

- (void)backLastView{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
