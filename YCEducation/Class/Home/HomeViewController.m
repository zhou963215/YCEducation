//
//  HomeViewController.m
//  YCEducation
//
//  Created by zhou on 2017/2/17.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "HomeViewController.h"
#import "ZHDateCell.h"
#import "SDCycleScrollView.h"
#import "AdvertisingView.h"
#import "FunctionCollection.h"
#import "TitleCollection.h"
#import "CYLTabBarController.h"
#import <MJRefresh/MJRefresh.h>
#import "ProductViewController.h"
#import "DetailWebProductVC.h"
@interface HomeViewController ()
{
    UIScrollView *scrollView;
    BOOL isFirst;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,strong)FunctionCollection * bgVC;
@property(nonatomic,strong)TitleCollection * ttCollection;
@property(nonatomic,strong)SDCycleScrollView * baner;
@property(nonatomic,strong)AdvertisingView * notic;
@property(nonatomic,strong)NSDictionary * data;
@property(nonatomic,strong)UILabel * welecomLB;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = [[NSUserDefaults standardUserDefaults]objectForKey:@"schName"];
    
    //    [self tokenLogin];
    
    scrollView = [UIScrollView new];
    scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    WEAKSELF(wk);
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(wk.view).with.insets(UIEdgeInsetsMake(0,0,0,0));
    }];
    
    [self tokenLogin];
    
    
}

- (void)tokenLogin{
    
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    
    [[ZHNetWorking sharedZHNetWorking]POSTLOGIN:@"2001" parameters:@{@"token":token} success:^(id  _Nonnull responseObject) {
        
//        NSLog(@"%@",responseObject);
        if ([responseObject[@"status"]isEqualToString:@"ok"]) {
            
            NSDictionary * dict = responseObject[@"data"];
            
            [[NSUserDefaults standardUserDefaults]setObject:dict[@"campusId"] forKey:@"campusId"];

            [scrollView.mj_header beginRefreshing];

        }
        
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

- (void)refresh{
    
    
    
    [[ZHNetWorking sharedZHNetWorking]POST:HOME parameters:@{} success:^(id  _Nonnull responseObject) {
        
        
        
        [scrollView.mj_header endRefreshing];
        
        if ([responseObject[@"status"]isEqualToString:@"ok"]) {
            if ([responseObject[@"status"]isEqualToString:@"ok"]) {
                
                NSDictionary * dict = responseObject[@"data"];
                if (!isFirst) {
                    
                    
                    [self loadSubViewsWithNSDictory:dict];
                    
                    
                }
                else{
                    
                    [self refrsehDataWithNSDictory:dict];
                    
                }
                isFirst = YES;
            }
            
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        
        [scrollView.mj_header endRefreshing];
        
        
    }];
    
    
    
}

- (void)refrsehDataWithNSDictory:(NSDictionary*)dict{
    
    _baner.imagesGroup = dict[@"bannerList"];
    [_ttCollection upDataWithData:dict[@"undeterminedList"]];
    _notic.imagesGroup = dict[@"noticeList"];
    _bgVC.apList = dict[@"apList"];
    _welecomLB = dict[@"welWord"];
    
    
}
- (void)loadSubViewsWithNSDictory:(NSDictionary *)dict{
    
    WEAKSELF(wk);
    
    
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    CGFloat h = (HEIGHT-64-49) *( 150/(HEIGHT-64-49));
    _baner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, h) imagesGroup:dict[@"banerList"]];
    _baner.imagesGroup = dict[@"bannerList"];
    _baner.autoScrollTimeInterval = 3;
    [container addSubview:_baner];
    
    _welecomLB = [UILabel new];
    _welecomLB.text = @"欢迎";
    [container addSubview:_welecomLB];
    
    [_welecomLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wk.baner.mas_bottom);
        //make.left.right.equalTo(wk.view);
        make.left.equalTo(wk.view).offset(16);
        make.height.mas_equalTo(@30);
        
    }];
    
    
    
    _ttCollection = [TitleCollection share];
    [_ttCollection upDataWithData:dict[@"undeterminedList"]];
    [container addSubview:_ttCollection.collection];
    
    [_ttCollection.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(wk.welecomLB.mas_bottom);
        make.left.right.equalTo(wk.view);
        
        make.height.mas_equalTo(@50);
    }];
    
    UIView * leftbg = [[UIView alloc]init];
    leftbg.backgroundColor = [UIColor whiteColor];
    [container addSubview:leftbg];
    
    [leftbg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.view);
        make.top.equalTo(wk.ttCollection.collection.mas_bottom).offset(6.5);
        make.size.mas_equalTo(CGSizeMake(80, 71.5));
    }];
    
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(27, 18, 40, 40)];
    imageView.image  = [UIImage imageNamed:@"tongzhi"];
    [leftbg addSubview:imageView];
    
    UIView * right = [[UIView alloc]initWithFrame:CGRectMake(79, 12.5, 1, 46.5)];
    right.backgroundColor = UICOLORRGB(0xf8f8f8);
    [leftbg addSubview:right];
    
    
    
    
    
    _notic = [AdvertisingView selectScrollViewWithFrame:CGRectZero data:_data[@"noticeList"]];
    _notic.imagesGroup = dict[@"noticeList"];
    _notic.autoScrollTimeInterval = 3;
    [container addSubview:_notic];
    
    [_notic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftbg.mas_right);
        make.right.equalTo(wk.view);
        make.height.top.equalTo(leftbg);
    }];
    
    
    _bgVC = [FunctionCollection share];
    _bgVC.apList = dict[@"apList"];
    [container addSubview:_bgVC.collection];
    
    [_bgVC.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(wk.notic.mas_bottom).offset(6.5);
        make.height.mas_equalTo(@190);
    }];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wk.bgVC.collection.mas_bottom).offset(49);
    }];
    
}







- (void)dealloc{
    
    NSLog(@"12312312313");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    
    
    
    
}


@end
