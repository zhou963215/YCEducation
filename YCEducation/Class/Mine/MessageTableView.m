//
//  ProductTableView.m
//  YCEducation
//
//  Created by zhou on 2017/3/27.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "MessageTableView.h"
#import "MessageTableViewCell.h"
#import "UIView+Controller.h"
#import <MJRefresh/MJRefresh.h>
@interface MessageTableView ()
{
    int count;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArr;

@end

@implementation MessageTableView
+(instancetype)share{
    
    return [[MessageTableView alloc]init];
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
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        //        self.tableView.scrollEnabled =NO;
        [self.tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"message"];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        [_tableView.mj_header beginRefreshing];

        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshUp)];
        
        
    }
    return _tableView;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 71;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dict = self.dataArr [indexPath.row];
    MessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"message"];
    [cell upDataWithDict:dict];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
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
    
    [[ZHNetWorking sharedZHNetWorking]POST:M_MESSAGE parameters:dict success:^(id  _Nonnull responseObject) {
        
        [self stop];
        if ([responseObject[@"status"]isEqualToString:@"ok"]) {
            
            NSDictionary * data = responseObject[@"data"];
            
            if (![data isKindOfClass:[NSNull class]]) {
                
                if ([data[@"isAll"]boolValue]) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    
                }
                NSArray * rows = data[@"msgList"];
                
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
                count = (int)data[@"endIndex"];

                
            }
            
            
            
        }
        
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
        [self stop];
        
    }];
    
    
    
    
}
- (void)stop{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
}

@end
