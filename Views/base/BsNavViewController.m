//
//  BsNavViewController.m
//  YCEducation
//
//  Created by zhou on 2017/3/18.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "BsNavViewController.h"

@interface BsNavViewController ()
{
    UIImageView *navBarHairlineImageView;
}
@end

@implementation BsNavViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    navBarHairlineImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    

    self.navigationController.navigationBar.barTintColor = UICOLORRGB(0x3EA0E6);
    self.view.backgroundColor = UICOLORRGB(0xf8f8f8);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];

}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)backButton{
    [super backButton];
    UIButton  *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"b_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backLastView) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 60, 40);
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 46);
    //    leftBtn.backgroundColor = [UIColor redColor];
    //将leftItem设置为自定义按钮
    UIBarButtonItem  *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

    
    
    
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
