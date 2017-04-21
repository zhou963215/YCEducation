//
//  BsViewController.m
//  YCEducation
//
//  Created by zhou on 2017/3/15.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "BsViewController.h"

@interface BsViewController ()

@end

@implementation BsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//   
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor = UICOLORRGB(0xf8f8f8);
    self.navigationController.navigationBar.barTintColor = UICOLORRGB(0xffffff);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:UICOLORRGB(0x282828)}];

  
}


- (void)backButton{
    
    
    UIButton  *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backLastView) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 60, 40);
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 46);
    //    leftBtn.backgroundColor = [UIColor redColor];
    //将leftItem设置为自定义按钮
    UIBarButtonItem  *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
 
    
    
}

- (void)backLastView{
    [self.navigationController popViewControllerAnimated:YES];
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
