//
//  ForgetViewController.m
//  YCEducation
//
//  Created by zhou on 2017/3/15.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "ForgetViewController.h"
#import "LoginTextField.h"
#import "LgoinLable.h"
#import "CountdownBtn.h"
#import "ChangePassWordVC.h"
#import "ZHHud.h"
@interface ForgetViewController ()
@property(nonatomic,strong)LoginTextField * userName;
@property(nonatomic,strong)LoginTextField * userCode;
@property(nonatomic,strong)LoginTextField * code;
@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.title = @"忘记密码";
    self.view.backgroundColor = UICOLORRGB(0xf8f8f8);
    self.navigationController.navigationBar.translucent=NO;
    [self backButton];

    [self addUI];
    
}

- (void)addUI{
    
    UILabel * phone = [LgoinLable new];
    phone.text = @"    手机号码";
    [self.view addSubview:phone];
    
    self.userName = [LoginTextField new];
    [self.view addSubview:self.userName];
    
    UILabel * codeUser = [LgoinLable new];
    codeUser.text = @"    身份证号码";
    [self.view addSubview:codeUser];
    
    self.userCode = [LoginTextField new];
    [self.view addSubview:self.userCode];
    
    UILabel * codeLB = [LgoinLable new];
    codeLB.text = @"    请输入验证码";
    [self.view addSubview:codeLB];
    
    self.code = [LoginTextField new];
    [self.view addSubview:self.code];
    
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    CountdownBtn *btn = [CountdownBtn countdownButton];
    btn.title = @"获取验证码";
    btn.titleLabelFont = [UIFont systemFontOfSize:15];
    btn.nomalBackgroundColor = UICOLORRGB(0x3EA0E6);
    btn.disabledBackgroundColor = UICOLORRGB(0xb4b4b4);
    btn.totalSecond = 60;
    [btn addTarget:self action:@selector(countdownBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:btn];
    
    [btn processBlock:^(NSUInteger second) {
        
        btn.title = [NSString stringWithFormat:@"%lis", second] ;
    } onFinishedBlock:^{  // 倒计时完毕
        btn.title = @"获取验证码";
    }];
    
    UIButton * login = [UIButton buttonWithType:UIButtonTypeCustom];
    [login setBackgroundColor:UICOLORRGB(0x3EA0E6)];
    [login setTitle:@"下 一 步" forState:UIControlStateNormal];
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
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(phone.mas_bottom);
        make.height.mas_equalTo(@45);
    }];
    
    [codeUser mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(wk.userName.mas_bottom);
        make.height.mas_equalTo(@45);
    }];
    
    [_userCode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(codeUser.mas_bottom);
        make.height.mas_equalTo(@45);
    }];
    
    [codeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(wk.userCode.mas_bottom);
        make.height.mas_equalTo(@45);
        
    }];
    
    [_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wk.view);
        
        make.top.equalTo(codeLB.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(280, 45));

    }];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.code.mas_right);
        make.right.equalTo(wk.view);
        make.top.height.equalTo(wk.code);
        
    }];
    
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(wk.view.mas_right).offset(-16);
        make.centerY.equalTo(wk.code);
        make.size.mas_equalTo(CGSizeMake(90, 30));
        
    }];
    
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.view).offset(16);
        make.right.equalTo(wk.view).offset(-16);
        make.top.equalTo(wk.code.mas_bottom).offset(45);
        make.height.mas_equalTo(@40);
    }];
    
}

- (void)countdownBtn:(CountdownBtn*)btn{
    
    [self.view endEditing:YES];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self loginWithBtn:btn];
        
    });
    
    
    
}

- (void)loginWithBtn:(CountdownBtn *)btn{
    
    
    if (self.userName.text.length<11) {
        
        [btn stopTime];
        [ZHHud initWithMessage:@"请输入正确的手机号码"];
        return;
        
    }
    
    [[ZHNetWorking sharedZHNetWorking]POSTLOGIN:L_YZM parameters:@{@"phoneNum":_userName.text,@"type":@"1"} success:^(id  _Nonnull responseObject) {
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
        [ZHHud initWithMessage:@"获取失败!请检查您的网络"];

        
    }];

}
- (void)loginClick{
    
    
    [self.view endEditing:YES];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self login];
        
    });
    
}

- (void)login{
    
    
    NSDictionary * dict = @{@"certNum":self.userCode.text,@"phoneNum":self.userName.text,@"verCode":self.code.text};
    
    
    [[ZHNetWorking sharedZHNetWorking]POSTLOGIN:L_FPWY parameters:dict success:^(id  _Nonnull responseObject) {
        
        
        if ([responseObject[@"status"]isEqualToString:@"error"]) {
            
            [ZHHud initWithMessage:responseObject[@"errMessage"]];
            
        }
        else{
            
            NSDictionary * data = responseObject[@"data"];
            ChangePassWordVC * change = [ChangePassWordVC new];
            change.verSign = data[@"verSign"];
            change.phoneNum = self.userName.text;
            [self.navigationController pushViewController:change animated:YES];
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
