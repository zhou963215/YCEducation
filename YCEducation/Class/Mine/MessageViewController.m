//
//  MessageViewController.m
//  YCEducation
//
//  Created by zhou on 2017/3/28.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableView.h"
@interface MessageViewController ()

@property(nonatomic,strong)MessageTableView * tb;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的消息";
    [self backButton];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tb = [MessageTableView share];
    self.tb.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT-64);
    
    [self.view addSubview:self.tb.tableView];

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
