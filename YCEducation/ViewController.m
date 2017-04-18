//
//  ViewController.m
//  YCEducation
//
//  Created by zhou on 2017/2/17.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "ViewController.h"
#import "YBPopupMenu.h"
@interface ViewController ()<YBPopupMenuDelegate>
@property(nonatomic,strong)NSArray * rows;

@end

@implementation ViewController


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    self.navigationController.navigationBar.alpha = 1;

    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.rows = @[@{@"clsName":@"CellViewController",@"title":@"pickCell"},@{@"clsName":@"HudViewController",@"title":@"Hud"},@{@"clsName":@"RefrsehTableViewVC",@"title":@"下拉刷新"},@{@"clsName":@"TestPayViewController",@"title":@"支付"},@{@"clsName":@"TestRequestTC",@"title":@"接口测试"},@{@"clsName":@"NavController",@"title":@"头部"},@{@"clsName":@"FMDBViewController",@"title":@"数据库"}];
  
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"pop" style:UIBarButtonItemStyleDone target:self action:@selector(right)];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary * dict = _rows[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    
    return cell;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dict = _rows[indexPath.row];
    Class class =  NSClassFromString(dict[@"clsName"]);
    
    UIViewController * vc = [class new];
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (void)right{
    
    CGPoint p = CGPointMake(WIDTH-35, 44);
    
    YBPopupMenu *popupMenu = [YBPopupMenu showAtPoint:p titles:@[@"编辑",@"任务处理"] icons:nil menuWidth:110 delegate:nil];
    popupMenu.dismissOnSelected = NO;
    popupMenu.isShowShadow = YES;
    popupMenu.delegate = self;
    popupMenu.offset = 10;
    popupMenu.type = YBPopupMenuTypeDark;
    
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    if (index==0) {
        
        
       
        [ybPopupMenu dismiss];
    }
    else{
        
        [ybPopupMenu dismiss];
        
    }
    
    
    NSLog(@"点击了 %ld 选项",(long)index);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
