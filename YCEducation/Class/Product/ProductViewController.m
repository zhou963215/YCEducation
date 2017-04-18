//
//  ProductViewController.m
//  YCEducation
//
//  Created by zhou on 2017/2/17.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductTableView.h"
@interface ProductViewController ()
@property(nonatomic,strong)ProductTableView * tb;
@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"资讯";

    self.view.backgroundColor = [UIColor whiteColor];
    self.tb = [ProductTableView share];
    self.tb.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-64-49);
    
    [self.view addSubview:self.tb.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
