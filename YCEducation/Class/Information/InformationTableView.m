//
//  InformationTableView.m
//  YCEducation
//
//  Created by zhou on 2017/3/30.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "InformationTableView.h"
#import "UIView+Controller.h"
#import "ApprovalTableViewCell.h"
#import "WebViewController.h"
@interface InformationTableView ()

@property (strong, nonatomic) UITableView *tableView;


@end
@implementation InformationTableView
+(instancetype)blog{
    
    return  [[InformationTableView alloc]init];
}

- (instancetype)init{
    
    if (self = [super init]) {
        
//        _height = 230;
        _count =3;
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tableView.separatorColor = UICOLORRGB(0xdbdbdb);
        [self.tableView registerClass:[InformationHeader class] forHeaderFooterViewReuseIdentifier:@"header"];
        self.tableView.scrollEnabled =NO;

        UIView  * view = [UIView new];
        
        self.tableView.tableFooterView = view;
        
    }
    
    return self;
    
    
}


- (void)setApList:(NSArray *)apList{
    
    
    _apList = apList;
    _height = 35+_apList.count*65;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(_height);
        
        
    }];
    [self.tableView reloadData];
    
}


#pragma mark - UITableViewDataSource && Delegate

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    InformationHeader * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    view.titleLB.text = self.title;
    [view.rightBtn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        
        
    
    return view;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _apList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ApprovalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[ApprovalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSDictionary * dict = _apList[indexPath.row];
    
    [cell upDataWithNSDictory:dict];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSLog(@"%ld",(long)indexPath.row);
    
    NSDictionary * dict = _apList[indexPath.row];
    WebViewController * web = [WebViewController new];
    web.url =[PublicVoid getNewUrl: dict[@"href"]];
    [self.tableView.navigationController pushViewController:web animated:YES];

}



- (void)change:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    
    
    _count=_count==_apList.count?0:_apList.count;
    
    
    
    CGRect rect = self.tableView.frame;
    
    rect.size.height = _count==3?_height:35;
    
    self.tableView.frame = rect;
    
    [self.tableView reloadData];
    
    
    
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo( rect.size.height);
        
        
    }];
    
}

@end
