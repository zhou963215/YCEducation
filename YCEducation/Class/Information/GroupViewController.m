//
//  GroupViewController.m
//  YCEducation
//
//  Created by zhou on 2017/4/7.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "GroupViewController.h"
#import "SelectGroupView.h"
#import "ScrollView.h"
#import "GroupTableView.h"
#import "GroupData.h"
#import "DisciplineTableView.h"
#import "GradeTableView.h"
#import "WebViewController.h"
@interface GroupViewController ()<seletedControllerDelegate,UIScrollViewDelegate>
{
    ScrollView * scr;
}
@property(nonatomic,strong) GroupData * dataModel;
@property(nonatomic,strong) SelectGroupView * group;
@property(nonatomic,strong) UIScrollView *mainScroll;

@property(nonatomic,strong)GroupTableView * first;
@property(nonatomic,strong)DisciplineTableView * second;
@property(nonatomic,strong)GradeTableView * third;
@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self backButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"groupChange" object:nil];

    self.navigationItem.title = @"请选择人员或部门";
    self.dataModel = [GroupData dataModel];
    [self.dataModel.dataArray removeAllObjects];

    [self setSubViews];
    
    
    
}
- (void)setSubViews{
    
    
    _group = [[SelectGroupView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [_group setreMenUI];
    [self.view addSubview:_group];
    
   
    
    scr = [[ScrollView alloc]initWithFrame:CGRectZero];
    NSArray * title = @[@"按行政组",@"按学科组",@"按年级组"];
    scr.headArray = [title mutableCopy];
    scr.SeletedDelegate = self;
    [self.view addSubview:scr];
    
    WEAKSELF(wk);
    [scr mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(wk.group.mas_bottom).offset(1);
        make.left.right.equalTo(wk.view);
        make.height.mas_equalTo(@45);
        
    }];
    _mainScroll = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _mainScroll.delegate = self;
    _mainScroll.contentSize = CGSizeMake(WIDTH*title.count, 0) ;
    _mainScroll.pagingEnabled = YES;
    _mainScroll.showsHorizontalScrollIndicator = NO;
    _mainScroll.scrollEnabled = NO;
    [self.view addSubview:_mainScroll];
    
    [_mainScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(scr.mas_bottom).offset(1);
        make.bottom.left.width.equalTo(wk.view);
        
        
        
    }];
    
    self.first= [GroupTableView blog];
    self.first.isOnly = self.isOnly;
    [self.mainScroll addSubview:_first.tableView];
    
    [self.first.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.equalTo(wk.mainScroll);
    }];
    
    self.second = [DisciplineTableView blog];
    self.second.isOnly = self.isOnly;
    [self.mainScroll addSubview:_second.tableView];
    [self.second.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.width.height.equalTo(wk.first.tableView);
        make.left.equalTo(wk.first.tableView.mas_right);
        
        
    }];
    
    self.third = [GradeTableView blog];
    self.third.isOnly = self.isOnly;
    [self.mainScroll addSubview:_third.tableView];
    
    [self.third.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.width.height.equalTo(wk.first.tableView);
        make.left.equalTo(wk.second.tableView.mas_right);
        
    }];
    
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [scr changeBtntitleColorWith:scrollView.contentOffset.x/WIDTH+1000];
    int count  = scrollView.contentOffset.x/WIDTH+1000;
    
    switch (count) {
        case 1000:
            [self.first.tableView reloadData];
            break;
        case 1001:
            [self.second.tableView reloadData];
            break;
        case 1002:
            [self.third.tableView reloadData];
            break;
            
        default:
            break;
    }

    
    
}
-(void)seletedControllerWith:(UIButton *)btn{
    
    _mainScroll.contentOffset = CGPointMake(WIDTH*(btn.tag - 1000), 0);
    
    [scr changeBtntitleColorWith:btn.tag];
    switch (btn.tag) {
        case 1000:
            [self.first.tableView reloadData];
            break;
        case 1001:
            [self.second.tableView reloadData];
            break;
        case 1002:
            [self.third.tableView reloadData];
            break;
   
        default:
            break;
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)notificationAction:(NSNotification *)notification{

    NSDictionary * dict = notification.object;
    if ([dict[@"isAdd"]boolValue]) {
        
        if (_isOnly) {
            
            [self.dataModel.dataArray removeAllObjects];
            
        }
        
        if (![self.dataModel.dataArray containsObject:dict[@"data"]]) {
            
            [self.dataModel.dataArray addObject:dict[@"data"]];
            _group.dataArr = self.dataModel.dataArray;

        }
    }
    else{
        
        NSDictionary * data = dict[@"data"];
        [self.dataModel.dataArray removeObject:data];
        
        _group.dataArr = self.dataModel.dataArray;

        
    }
    
    
    
    NSLog(@"%@",dict);
    
    
}
- (void)backLastView{
    
    if (self.dataModel.dataArray.count>0) {
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[WebViewController class]]) {
                WebViewController *mine =(WebViewController *)controller;
                
                mine.peopleType = self.isOnly?2:1;
               
                
                [self.navigationController popToViewController:mine animated:YES];
            }
        }

        
    }
    else{
       
        [self.navigationController popViewControllerAnimated:YES];

    }
   
    
    
}

- (void)dealloc{
    
    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"groupChange" object:nil];
    
}

@end
