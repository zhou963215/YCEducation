//
//  ProductTableView.m
//  YCEducation
//
//  Created by zhou on 2017/3/27.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "ProductTableView.h"
#import "ProductTableViewCell.h"
#import "ProductNormalTableViewCell.h"
#import "UIView+Controller.h"
#import <MJRefresh/MJRefresh.h>
#import "UITableView+JRTableViewPlaceHolder.h"
#import "MJDIYBackFooter.h"
#import "DetailWebProductVC.h"
@interface ProductTableView ()
{
    int count;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArr;

@end

@implementation ProductTableView
+(instancetype)share{
    
    return [[ProductTableView alloc]init];
}- (instancetype)init{
    
    
    if (self = [super init]) {
        
        count=0;

    }
    
    return self;
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        self.tableView  = [[UITableView alloc]initWithFrame:CGRectZero];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tableView.separatorColor = UICOLORRGB(0xdbdbdb);
        [self.tableView registerClass:[ProductTableViewCell class] forCellReuseIdentifier:@"mine"];
        [self.tableView registerClass:[ProductNormalTableViewCell class] forCellReuseIdentifier:@"normal"];
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        [_tableView.mj_header beginRefreshing];

        _tableView.mj_footer = [MJDIYBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshUp)];
        _tableView.mj_footer.hidden = YES;
//        __weak __typeof(self)weakSelf = self;
//        [self.tableView jr_configureWithPlaceHolderBlock:^UIView * _Nonnull(UITableView * _Nonnull sender) {
//            [weakSelf.tableView setScrollEnabled:NO];
//            
//            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//            [btn setImage:[UIImage imageNamed:@"m_bg"] forState:UIControlStateNormal];
//            [btn addTarget:weakSelf action:@selector(nodataRefresh) forControlEvents:UIControlEventTouchUpInside];
//            UIView *v = [[UIView alloc] initWithFrame:weakSelf.tableView.bounds];
//            v.backgroundColor = [UIColor whiteColor];
//            [v addSubview:btn];
//            btn.center = weakSelf.tableView.center;
//            return v;
//        } normalBlock:^(UITableView * _Nonnull sender) {
//            [weakSelf.tableView setScrollEnabled:YES];
//        }];

        
    }
    return _tableView;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 98;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDictionary * dict = self.dataArr[indexPath.row];
    
    if ([dict[@"isTop"]isEqualToString:@"Y"]) {
        
        ProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mine"];
        [cell upDataWithDict:dict];
        return cell;
        
    }
    else{
        
        ProductNormalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"normal"];
        
        [cell upDataWithDict:dict];
        return cell;
        

    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",(long)indexPath.row);
    NSDictionary * dict = self.dataArr[indexPath.row];
//    NSString * str = [NSString stringWithFormat:@"http://pro1test.zjyckj.com.cn:8082/consumer/appH5Pages/infordetails/infordeta.html?id=1&type=%@",dict[@"id"]];
    DetailWebProductVC * vc = [DetailWebProductVC new];
    vc.url = dict[@"href"];
    
    [self.tableView.navigationController pushViewController:vc animated:YES];
}

- (void)refreshUp{
    
    [self requeset];

    
}

-(void)refresh{
    
    count=0;
    [self requeset];
    
    
}


- (void)requeset{
    
    NSDictionary * dict = @{@"beginIndex":@(count),@"recordNum":@"10"};
    
    [[ZHNetWorking sharedZHNetWorking]POST:PROUCT parameters:dict success:^(id  _Nonnull responseObject) {
        
        [self stop];
        if ([responseObject[@"status"]isEqualToString:@"ok"]) {
            _tableView.mj_footer.hidden = NO;

            NSDictionary * data = responseObject[@"data"];
            
            if (![data isKindOfClass:[NSNull class]]) {
                
                if ([data[@"isAll"]boolValue]) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    
                }
                NSArray * rows = data[@"shList"];
                
                if(rows.count>0){
                    
                    if (count==0) {
                        
                        self.dataArr = rows;
                    }
                    else{
                        
                        self.dataArr = [[NSMutableArray arrayWithArray:self.dataArr]arrayByAddingObjectsFromArray:rows];
                        
                    }
                    
                    NSMutableArray *array = [NSMutableArray new];
                    
                    [self.dataArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        NSDictionary *dic = obj;
                        NSMutableDictionary *model = [dic mutableCopy];
                        [array addObject:model];
                    }];
                    
                    self.dataArr = array;
                    [self.tableView reloadData];
                }
                
               
                count = (int)data[@"endIndex"];

                
            }
            
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        [self stop];
        _tableView.mj_footer.hidden = YES;

    }];
    
    
    
    
}

- (void)nodataRefresh{
    [_tableView.mj_header beginRefreshing];

    
}
- (void)stop{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
}

@end
