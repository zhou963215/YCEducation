//
//  MineViewController.m
//  YCEducation
//
//  Created by zhou on 2017/2/17.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewVC.h"
#import "PublicVoid.h"
#import "ZHHud.h"
#import <MJRefresh/MJRefresh.h>
@interface MineViewController ()<UINavigationControllerDelegate>
@property(nonatomic,strong)MineTableViewVC * mine;

@end

@implementation MineViewController

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    if (_isChange) {
        
        [self.mine getData];
    }
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.delegate = self;
    [self addUI];
    [self addExit];
    

}


- (void)addUI{
    
    
    self.mine = [MineTableViewVC share];
    self.mine.tableView.frame = CGRectMake(0, 0, WIDTH, 439.5);
    
    [self.view addSubview:self.mine.tableView];
    [self.mine getData];
}


- (void)addExit{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:UICOLORRGB(0x3ea0e6)];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    button.titleLabel.textColor = UICOLORRGB(0xffffff);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    WEAKSELF(wk);
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(wk.view);
        make.size.mas_equalTo(CGSizeMake(230, 41));
        make.bottom.equalTo(wk.view).offset(-67);
        
    }];
    
}

//退出登录
- (void)loginClick{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否退出登录?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [PublicVoid LogOut];
        
        [ZHHud initWithMessage:@"退出成功"];
    }];
    UIAlertAction * cance = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    [alert addAction:cance];
    [alert addAction:confirmAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
