//
//  InformationViewController.m
//  YCEducation
//
//  Created by zhou on 2017/2/17.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "InformationViewController.h"
#import "InformationButton.h"
#import "InformationTopView.h"
#import "InformationFuntionVC.h"
#import "ActivityCollectionVC.h"
#import "InformationTableView.h"
#import "ActivityTableView.h"
#import <MJRefresh/MJRefresh.h>
#import "WebViewController.h"
#import "ZHHud.h"
@interface InformationViewController ()<UINavigationControllerDelegate>
{
    UIScrollView *scrollView;
    BOOL isFirst;
   
}
@property(nonatomic,strong)InformationTopView * approvalView;
@property(nonatomic,strong)InformationTopView * activityView;
@property(nonatomic,strong)InformationFuntionVC * approvalFuntionList;
@property(nonatomic,strong)ActivityCollectionVC * activityFuntionList;
@property(nonatomic,strong)InformationTableView * approalTableView;
@property(nonatomic,strong)ActivityTableView * activityTableView;
@property(nonatomic,strong)    NSArray * topArr;
@property(nonatomic,strong)    NSArray * downArr;


@end

@implementation InformationViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLORRGB(0xf8f8f8);
    self.navigationItem.title = @"办公";
    
    scrollView = [UIScrollView new];
    scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [scrollView.mj_header beginRefreshing];
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    WEAKSELF(wk);

    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(wk.view).with.insets(UIEdgeInsetsMake(0,0,0,0));
    }];

    
}


- (void)loadSubViewsWithNSDictory:(NSArray *)dataArr{
    
    WEAKSELF(wk);
    
    
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    
#pragma mark -----------审核
    
  
    _approvalView= [[InformationTopView alloc]initWithTop:YES];
    
    [container addSubview:_approvalView];
    
    
    [_approvalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(container);
        make.height.mas_equalTo(@60);
        
    }];
    

    _approvalFuntionList = [InformationFuntionVC share];
    [container addSubview:_approvalFuntionList.collection];

    [_approvalFuntionList.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_approvalView.mas_bottom).offset(1);
        make.left.right.equalTo(container);
        make.height.mas_equalTo(@195);
        
    }];
    
    
    _approalTableView = [InformationTableView blog];
    [container addSubview:_approalTableView.tableView];
    [_approalTableView.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(wk.approvalFuntionList.collection.mas_bottom).offset(1);
        make.left.width.equalTo(container);
        make.height.mas_equalTo(@230);
        
    }];
#pragma mark -----------活动
    
    
    _activityView = [[InformationTopView alloc]initWithTop:NO];
    [container addSubview:_activityView];
    [_activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(wk.approalTableView.tableView.mas_bottom).offset(9);
        make.left.right.equalTo(container);
        make.height.mas_equalTo(@60);
        
    }];

    
    _activityFuntionList = [ActivityCollectionVC share];
    [container addSubview:_activityFuntionList.collection];
    
    
    
    [_activityFuntionList.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(wk.activityView.mas_bottom).offset(1);
        make.left.right.equalTo(container);
        make.height.mas_equalTo(@195);
        
    }];
    
    _activityTableView = [ActivityTableView blog];

    [container addSubview:_activityTableView.tableView];
    
    [_activityTableView.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(wk.activityFuntionList.collection.mas_bottom).offset(1);
        make.left.width.equalTo(container);
        make.height.mas_equalTo(@230);
        
    }];
    
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wk.activityTableView.tableView.mas_bottom).offset(49);
    }];
    
    [self refrsehDataWithNSArray:dataArr];
    
}


- (void)refresh{
    
    
    [[ZHNetWorking sharedZHNetWorking]POST:INFORMATION parameters:@{} success:^(id  _Nonnull responseObject) {
        
        [scrollView.mj_header endRefreshing];
        
        if ([responseObject[@"status"]isEqualToString:@"ok"]) {
            
            NSDictionary * dict = responseObject[@"data"];
            NSArray * dataArr = dict[@"funList"];
            if (!isFirst) {
                
                [self loadSubViewsWithNSDictory:dataArr];

                
            }
            else{
                [self refrsehDataWithNSArray:dataArr];
  
            }
            isFirst = YES;
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        
        [scrollView.mj_header endRefreshing];

        
    }];

    
    
}

- (void)refrsehDataWithNSArray:(NSArray *)dataArr{
    
    NSDictionary * topDict = dataArr[0];

    [_approvalView fillInTheData:topDict];
    _approvalFuntionList.apList = topDict[@"apList"];
    _approalTableView.apList = topDict[@"jqinfoList"];
    _approalTableView.title = topDict[@"jqInfo"];
    
    NSDictionary * activityDict = dataArr[1];
    [_activityView fillInTheData:activityDict];
    _activityFuntionList.apList = activityDict[@"apList"];
    _activityTableView.apList = activityDict[@"jqinfoList"];
    _activityTableView.title = activityDict[@"jqInfo"];

    _topArr = topDict[@"printNumList"];
    _downArr = activityDict[@"printNumList"];
    WEAKSELF(wk);
    _approvalView.ButtonClick = ^void(NSInteger tag){
      
        NSLog(@"%ld",(long)tag);
        NSDictionary * urlDict = wk.topArr[tag-1];
        WebViewController * wb = [WebViewController new];
        wb.url  = [PublicVoid getNewUrl:urlDict[@"url"]];
        if ([wb.url isEqualToString:@""]||wb.url==nil) {
            
            [ZHHud initWithMessage:@"暂无页面"];
            return;
            
        }
        [wk.navigationController pushViewController:wb animated:YES];
        
        
    };
    
    _activityView.ButtonClick = ^void(NSInteger tag){
        
        
        NSLog(@"%ld",(long)tag);
        NSDictionary * urlDict = wk.topArr[tag-1];
        WebViewController * wb = [WebViewController new];
        wb.url  = urlDict[@"url"];
        if ([wb.url isEqualToString:@""]||wb.url==nil) {
            
            [ZHHud initWithMessage:@"暂无页面"];
            return;
            
        }

        [wk.navigationController pushViewController:wb animated:YES];
        
        
    };
    

   

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
