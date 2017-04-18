//
//  BaseRefreshViewController.m
//  YCEducation
//
//  Created by zhou on 2017/2/20.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "RefreshViewController.h"
#import "UITableView+JRTableViewPlaceHolder.h"
#define MJRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]
static const CGFloat MJDuration = 2.0;

@interface RefreshViewController ()

@end

@implementation RefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self.view addSubview:self.tableView];
    __weak __typeof(self)weakSelf = self;
    [self.tableView jr_configureWithPlaceHolderBlock:^UIView * _Nonnull(UITableView * _Nonnull sender) {
        [weakSelf.tableView setScrollEnabled:NO];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [btn setImage:[UIImage imageNamed:@"no_data"] forState:UIControlStateNormal];
        [btn addTarget:weakSelf action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
        UIView *v = [[UIView alloc] initWithFrame:weakSelf.tableView.bounds];
        v.backgroundColor = [UIColor whiteColor];
        [v addSubview:btn];
        btn.center = weakSelf.tableView.center;
        return v;
    } normalBlock:^(UITableView * _Nonnull sender) {
        [weakSelf.tableView setScrollEnabled:YES];
    }];

    
   
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0.0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        
        [_tableView setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
//        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //cell无数据时，不显示间隔线
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView setTableFooterView:v];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        
        
        
    }
    return _tableView;

    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
    
    
    return [UITableViewCell new];
}


- (void)refresh{
    
    
    if (_pageCount==0) {
        
        [self requestWithPageCount:0];
    }
    else{
        [self requestWithPageCount:_pageCount];
    }
    
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data insertObject:MJRandomData atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    });

    
    NSLog(@"刷新");
    
}


- (void)requestWithPageCount:(int)count{
    
    //传入最后一条的标识码
    
    
    
    
    
}

- (NSMutableArray *)data
{
    if (!_data) {
        self.data = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            [self.data addObject:MJRandomData];
        }
    }
    return _data;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
