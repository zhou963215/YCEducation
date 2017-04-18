//
//  ChangePassWordVC.m
//  YCEducation
//
//  Created by zhou on 2017/3/15.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "ChangePassWordVC.h"
#import "LoginTextField.h"
#import "LgoinLable.h"
#import "ZHHud.h"
#import "NSString+Md5.h"
@interface ChangePassWordVC ()
@property(nonatomic,strong)LoginTextField * password;
@property(nonatomic,strong)LoginTextField * passwordagain;
@end

@implementation ChangePassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    self.view.backgroundColor = UICOLORRGB(0xf8f8f8);
    self.navigationController.navigationBar.translucent=NO;
    
    
    [self addUI];
}

- (void)addUI{
    
    UILabel * phone = [LgoinLable new];
    phone.text = @"    请输入新密码";
    [self.view addSubview:phone];
    
    self.password = [LoginTextField new];
    self.password.secureTextEntry = YES;
    [self.view addSubview:self.password];
    
    UILabel * codeUser = [LgoinLable new];
    codeUser.text = @"    请确认密码";
    [self.view addSubview:codeUser];
    
    self.passwordagain = [LoginTextField new];
    self.passwordagain.secureTextEntry = YES;
    [self.view addSubview:self.passwordagain];

    UIButton * login = [UIButton buttonWithType:UIButtonTypeCustom];
    [login setBackgroundColor:UICOLORRGB(0x3EA0E6)];
    [login setTitle:@"完  成" forState:UIControlStateNormal];
    login.titleLabel.textColor = [UIColor whiteColor];
    login.titleLabel.font =[UIFont systemFontOfSize:18];
    login.layer.masksToBounds = YES;
    login.layer.cornerRadius = 5;
    [login addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
    WEAKSELF(wk);
    
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(wk.view);
        make.height.mas_equalTo(@45);
        
    }];
    
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(phone.mas_bottom);
        make.height.mas_equalTo(@45);
    }];
    
    [codeUser mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(wk.password.mas_bottom);
        make.height.mas_equalTo(@45);
    }];
    
    [_passwordagain mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(codeUser.mas_bottom);
        make.height.mas_equalTo(@45);
    }];
    
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.view).offset(16);
        make.right.equalTo(wk.view).offset(-16);
        make.top.equalTo(wk.passwordagain.mas_bottom).offset(45);
        make.height.mas_equalTo(@40);
    }];
    

}

- (void)loginClick{
    
    [self.view endEditing:YES];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self login];
        
    });

}
- (void)login{
    
    if (!(self.password.text.length>0)||!(self.passwordagain.text.length>0)) {
        
        
        [ZHHud initWithMessage:@"请输入密码和新密码"];
        return;
    }
    
    if (![self.password.text isEqualToString:self.passwordagain.text]) {
        
        [ZHHud initWithMessage:@"两次输入密码不一致"];
        return;
    }

    
    NSDictionary * dict = @{@"newPwd":[self.password.text stringToMD5],@"phoneNum":self.phoneNum,@"verSign":self.verSign};
    
    
    [[ZHNetWorking sharedZHNetWorking]POSTLOGIN:L_FPWC parameters:dict success:^(id  _Nonnull responseObject) {
        
        
        if ([responseObject[@"status"]isEqualToString:@"error"]) {
            
            [ZHHud initWithMessage:responseObject[@"errMessage"]];
            
        }
        else{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
    
    
    //    [self.navigationController pushViewController:[ChangePassWordVC new] animated:YES];
    
    
    
    
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
