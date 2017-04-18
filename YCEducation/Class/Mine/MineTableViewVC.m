//
//  MineTableViewVC.m
//  YCEducation
//
//  Created by zhou on 2017/3/27.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "MineTableViewVC.h"
#import "UIView+Controller.h"
#import "MineTableViewCell.h"
#import "DeailMineViewController.h"
#import <MJRefresh/MJRefresh.h>
@interface MineTableViewVC()

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArr;
@end

@implementation MineTableViewVC

+(instancetype)share{
    
    return [[MineTableViewVC alloc]init];
}- (instancetype)init{
    
    
    if (self = [super init]) {
      
        self.dataArr = @[@[@{@"clsName":@"",@"title":@"我的消息",@"img":@"m_xiaoxi"},@{@"clsName":@"MessageViewController",@"title":@"我的消息",@"img":@"m_xiaoxi"},@{@"clsName":@"PswViewController",@"title":@"密码修改",@"img":@"m_mima"},@{@"clsName":@"SetUpViewController",@"title":@"设置",@"img":@"m_shezhi"}],@[@{@"clsName":@"我的消息",@"title":@"关于我们",@"img":@"m_guanyu"},@{@"clsName":@"我的消息",@"title":@"意见反馈",@"img":@"m_yijian"}]];
        
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
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mine"];
        [self.tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"header"];
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//        self.tableView.scrollEnabled =NO;
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
        
        
    }
    return _tableView;
    
    
}

- (void)getData{
    
    [[ZHNetWorking sharedZHNetWorking]POST:MINE parameters:@{} success:^(id  _Nonnull responseObject) {
        
        [self.tableView.mj_header endRefreshing];
        self.headerDict = responseObject[@"data"];
        
    } failure:^(NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];

    }];
    
}

- (void)setHeaderDict:(NSDictionary *)headerDict{
    
    _headerDict = headerDict;
    [self.tableView reloadData];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0&&indexPath.row==0) {
        return 183;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 0.001;
    }
    return 6.5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray * arr = self.dataArr[section];
    
    return arr.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0&&indexPath.row==0) {
        
        MineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"header"];
        if (self.headerDict) {
            
            [cell upDataWithDict:self.headerDict];
 
        }
        return cell;
        
    }
    else{
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mine"];
        NSDictionary * dict = self.dataArr[indexPath.section][indexPath.row];
        cell.imageView.image = [UIImage imageNamed:dict[@"img"]];
        cell.textLabel.text = dict[@"title"];
        cell.textLabel.textColor = UICOLORRGB(0x282828);
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
   
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",(long)indexPath.row);
    
    if (indexPath.section==0&&indexPath.row==0) {
        
        if (self.headerDict) {
            
            DeailMineViewController * deail = [DeailMineViewController new];
            deail.dict = self.headerDict;
            [self.tableView.navigationController pushViewController:deail animated:YES];
        }
      
    }
    else{
        
        
        NSDictionary * dict = _dataArr[indexPath.section][indexPath.row];
        Class class =  NSClassFromString(dict[@"clsName"]);
        
        UIViewController * vc = [class new];
        
        if (vc) {
            [self.tableView.navigationController pushViewController:vc animated:YES];
            
        }
        
    }
    
}


@end
