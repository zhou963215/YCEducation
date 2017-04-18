//
//  LoginViewController.m
//  YCEducation
//
//  Created by zhou on 2017/3/10.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "LoginViewController.h"
#import "ZHHud.h"
#import "FirstLoginViewController.h"
#import "LoginTextField.h"
#import "ForgetViewController.h"
#import "NSString+Md5.h"
#import "UIView+Alert.h"
#import "NSObject+Astray.h"
#import "ZHTabrController.h"
@interface LoginViewController ()
{
    
    NSInteger _errorCount;
    NSString * _username;
}
@property(nonatomic,strong)LoginTextField * userName;
@property(nonatomic,strong)LoginTextField * passWord;
@property(nonatomic,strong)UIButton * errorView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"登录";
    self.view.backgroundColor = UICOLORRGB(0xf8f8f8);
    self.navigationController.navigationBar.translucent=NO;
    
    _errorCount = 1;

    [self addUI];
    
}

- (void)addUI{
    
    
    WEAKSELF(wk);
    
    
    UILabel * phone = [UILabel new];
    phone.text = @"请输入手机号";
    phone.font = [UIFont systemFontOfSize:15];
    phone.textColor = UICOLORRGB(0x282828);
    [self.view addSubview:phone];
    
   
    
    self.userName = [[LoginTextField alloc]init];
    self.userName.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:self.userName];
    
    UILabel * pass = [UILabel new];
    pass.text = @"    请输入密码";
    pass.textColor = UICOLORRGB(0x282828);
    pass.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:pass];
    
    self.passWord = [LoginTextField new];
    self.passWord.secureTextEntry = YES;
    [self.view addSubview:self.passWord];
    
    UIButton * login = [UIButton buttonWithType:UIButtonTypeCustom];
    [login setBackgroundColor:UICOLORRGB(0x3EA0E6)];
    [login setTitle:@"登  录" forState:UIControlStateNormal];
    login.titleLabel.textColor = [UIColor whiteColor];
    login.titleLabel.font =[UIFont systemFontOfSize:18];
    login.layer.masksToBounds = YES;
    login.layer.cornerRadius = 5;
    [login addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
    
    UIButton * getUser = [UIButton buttonWithType:UIButtonTypeCustom];
    [getUser setTitle:@"获取新用户" forState:UIControlStateNormal];
    [getUser setTitleColor:UICOLORRGB(0x3EA0E6) forState:UIControlStateNormal];
    getUser.titleLabel.font =[UIFont systemFontOfSize:15];
    [getUser addTarget:self action:@selector(getUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getUser];
    
    UIButton * forget = [UIButton buttonWithType:UIButtonTypeCustom];
    [forget setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forget setTitleColor:UICOLORRGB(0x3EA0E6) forState:UIControlStateNormal];
    [forget addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    forget.titleLabel.font =[UIFont systemFontOfSize:15];
    [self.view addSubview:forget];

    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.view).offset(16);
        make.top.equalTo(wk.view).offset(14.5);
        make.height.mas_equalTo(@21);
        
    }];
    
   
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(wk.view).offset(45);
        make.height.mas_equalTo(@45);
    }];
    
    [pass mas_makeConstraints:^(MASConstraintMaker *make) {
        

        make.left.right.equalTo(wk.view);
        make.top.equalTo(wk.userName.mas_bottom);
        make.height.mas_equalTo(@45);
        
        
    }];
    
  
    
    
    [self.passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wk.view);
        make.top.equalTo(pass.mas_bottom);
        make.height.mas_equalTo(@45);
        
    }];
    
    
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.view).offset(16);
        make.right.equalTo(wk.view).offset(-16);
        make.top.equalTo(wk.passWord.mas_bottom).offset(45);
        make.height.mas_equalTo(@40);
    }];
    
    [getUser mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(login);
        make.size.mas_equalTo(CGSizeMake(76.5, 21));
        make.top.equalTo(login.mas_bottom).offset(16);
        
        
        
    }];
    
    [forget mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(login);
        make.size.mas_equalTo(CGSizeMake(70, 21));
        make.top.equalTo(login.mas_bottom).offset(16);
        

    }];
    
    self.errorView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_errorView setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_errorView setImage:[UIImage imageNamed:@"error"] forState:UIControlStateNormal];
    [_errorView setTitle:@"您已连续3次输入密码错误,建议找回密码" forState:UIControlStateNormal];
    _errorView.titleLabel.font = [UIFont systemFontOfSize:12];
    _errorView.enabled = NO;
    _errorView.hidden = YES;
    [self.view addSubview:self.errorView];
    
    [_errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(phone);
        make.size.mas_equalTo(CGSizeMake(230, 21));
        make.top.equalTo(wk.passWord.mas_bottom).offset(9);
    }];
    
    
    
}

- (void)loginClick{
    
    
    [self.view endEditing:YES];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self login];
        
    });

}


- (void)login{
    
    if (!(_userName.text.length>0)||!(_passWord.text.length>0)) {
        
        [ZHHud initWithMessage:@"请输入账号或密码"];
        return;
    }
    
   
    //13429661801
    NSDictionary * dict = @{@"phoneNum":self.userName.text,@"pwd":[self.passWord.text stringToMD5]};
    
    [[ZHNetWorking sharedZHNetWorking]POSTLOGIN:LOGIN parameters:dict success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"status"]isEqualToString:@"error"]) {
            
            [ZHHud initWithMessage:responseObject[@"errMessage"]];
            [self errorCount];
            
        }
        else{
            

            NSDictionary  * dict = responseObject[@"data"];
            [[NSUserDefaults standardUserDefaults]setObject:dict[@"token"] forKey:@"token"];
            [[NSUserDefaults standardUserDefaults]setObject:dict[@"schName"] forKey:@"schName"];

            if ([dict[@"isFirst"]boolValue]) {
                
                FirstLoginViewController * first = [FirstLoginViewController new];
                first.dict = [dict checkData:dict];
                first.phone = self.userName.text;
                [self.navigationController pushViewController:first animated:YES];
                
            }
            else{
                
                
                [ZHHud initWithMessage:@"登陆成功"];

                //进入首页
                ZHTabrController *tabBarControllerConfig = [[ZHTabrController alloc] init];
                 [[[[UIApplication sharedApplication]delegate]window] setRootViewController:tabBarControllerConfig.tabBarController];
                
            }

            
        }
        
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
    }];

}

- (void)errorCount{
    
    if (_errorCount<2) {
        if ([_username isEqualToString:_userName.text]) {
            
            _errorCount++;
            
        }
        else{
            _username=_userName.text;
        }
        
    }
    else{
        
        _errorView.hidden =NO;
    }
    

    
}
//获取账号
- (void)getUser{
    
    
    
    
}

- (void)forgetPassword{
    
    
    
    [self.navigationController pushViewController:[ForgetViewController new] animated:YES];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
