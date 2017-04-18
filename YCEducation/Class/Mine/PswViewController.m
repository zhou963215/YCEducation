//
//  PswViewController.m
//  YCEducation
//
//  Created by zhou on 2017/3/29.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "PswViewController.h"
#import "LoginTextField.h"
#import "LgoinLable.h"
#import "ZHHud.h"
#import "NSString+Md5.h"
#import "PublicVoid.h"
@interface PswViewController ()
@property(nonatomic,strong)LoginTextField * oldPassword;
@property(nonatomic,strong)LoginTextField * password;
@property(nonatomic,strong)LoginTextField * passwordagain;
@end

@implementation PswViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"修改密码";
    [self backButton];

    [self addUI];
    
    
}
- (void)addUI{
    
    UILabel * oldphone = [LgoinLable new];
    oldphone.text = @"    请输入原密码";
    [self.view addSubview:oldphone];
    
    
    self.oldPassword = [LoginTextField new];
    self.oldPassword.secureTextEntry = YES;
    [self.view addSubview:self.oldPassword];
    
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
    
    [oldphone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(wk.view);
        make.height.mas_equalTo(@45);
        
    }];
    
    [_oldPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(oldphone.mas_bottom);
        make.height.mas_equalTo(@45);
    }];
    
    
    
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wk.oldPassword.mas_bottom);

        make.left.right.equalTo(wk.view);
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
    
    
    if (!(self.oldPassword.text.length>0)) {
        
        
        [ZHHud initWithMessage:@"请输入原密码"];
        return;
    }

    
    
    if (!(self.password.text.length>0)||!(self.passwordagain.text.length>0)) {
        
        
        [ZHHud initWithMessage:@"请输入密码和新密码"];
        return;
    }
    
    if (![self.password.text isEqualToString:self.passwordagain.text]) {
        
        [ZHHud initWithMessage:@"两次输入密码不一致"];
        return;
    }
    
    
    NSDictionary * dict = @{@"newPwd":[self.password.text stringToMD5],@"oldPwd":[self.oldPassword.text stringToMD5]};
    
    
    [[ZHNetWorking sharedZHNetWorking]POST:L_CPW parameters:dict success:^(id  _Nonnull responseObject) {
        
        
        if ([responseObject[@"status"]isEqualToString:@"error"]) {
            
            [ZHHud initWithMessage:responseObject[@"errMessage"]];
            
        }
        else{
            
            [ZHHud initWithMessage:@"您的登录密码已经修改成功，请牢记您的秘密，并重新登录。"];

            
            [PublicVoid LogOut];
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
    
    
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
