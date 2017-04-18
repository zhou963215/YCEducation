//
//  RefrsehTableViewVC.m
//  YCEducation
//
//  Created by zhou on 2017/2/27.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "RefrsehTableViewVC.h"

@interface RefrsehTableViewVC ()


@end

@implementation RefrsehTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
       
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"清除" style:UIBarButtonItemStylePlain target:self action:@selector(clearn)];

    [self.tableView.mj_footer endRefreshingWithNoMoreData];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];


   

    
    
}
- (void)clearn{
    
    [self.data removeAllObjects];
    [self.tableView reloadData];
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    cell.textLabel.text = self.data[indexPath.row];
    

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"%ld",(long)indexPath.row);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
