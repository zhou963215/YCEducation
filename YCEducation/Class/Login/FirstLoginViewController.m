//
//  FirstLoginViewController.m
//  
//
//  Created by zhou on 2017/3/13.
//
//

#import "FirstLoginViewController.h"
#import "LoginTextField.h"
#import "LgoinLable.h"
#import "CountdownBtn.h"
#import "ZHHud.h"
#import "NSString+Md5.h"
#import "ZHTabrController.h"
@interface FirstLoginViewController ()
@property(nonatomic,strong)LoginTextField * codeTF;
@property(nonatomic,strong)LoginTextField * password;
@property(nonatomic,strong)LoginTextField * passwordagain;
@property(nonatomic,strong)UIButton * selectBtn;
@property(nonatomic,strong)UIScrollView * scrollView;

@end

@implementation FirstLoginViewController

- (void)viewWillDisappear:(BOOL)animated{
    
    
    [super viewWillDisappear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];


    self.title = @"首次登录";
    self.view.backgroundColor = UICOLORRGB(0xf8f8f8);
    [self backButton];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    _scrollView.contentSize = CGSizeMake(0, 667);
    _scrollView.showsVerticalScrollIndicator = NO;
    
    
    [self.view addSubview:_scrollView];
        
    [self addUI];



}


- (void)addUI{
    
    UILabel * topLB = [UILabel new];
    topLB.text = @"     您好,欢迎您首次登录!请核对好个人信息后重新修改密码";
    topLB.textColor = UICOLORRGB(0x8c8c8c);
    topLB.font = [UIFont systemFontOfSize:12];
    [_scrollView addSubview:topLB];
    
    UILabel * school = [LgoinLable new];
//    school.text = @"    学    校:  练市中学";
    school.text = [NSString stringWithFormat:@"    学    校:  %@",_dict[@"schName"]];
    school.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:school];
    
    UILabel * phone = [LgoinLable new];
//    phone.text = @"    手机号:  18838838438";
    phone.text = [NSString stringWithFormat:@"    手机号:  %@",_dict[@"phoneNum"]];
    [_scrollView addSubview:phone];
    
    UILabel * name = [LgoinLable new];
//    name.text = @"    姓    名:   张小虎";
    name.text = [NSString stringWithFormat:@"    姓    名:   %@",_dict[@"name"]];
    name.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:name];
    
    UILabel * codeLB = [LgoinLable new];
    codeLB.text = @"    请输入验证码";
    [_scrollView addSubview:codeLB];
    
    
    _codeTF = [LoginTextField new];
    [_scrollView addSubview:_codeTF];
    
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:view];
    
    CountdownBtn *btn = [CountdownBtn countdownButton];
    btn.title = @"获取验证码";
    btn.titleLabelFont = [UIFont systemFontOfSize:15];
    btn.nomalBackgroundColor = UICOLORRGB(0x3EA0E6);
    btn.disabledBackgroundColor = UICOLORRGB(0xb4b4b4);
    btn.totalSecond = 60;
    [btn addTarget:self action:@selector(countdownBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    [btn processBlock:^(NSUInteger second) {
        
        btn.title = [NSString stringWithFormat:@"%lis", second] ;
    } onFinishedBlock:^{  // 倒计时完毕
        btn.title = @"获取验证码";
    }];

   
    
    UILabel * pass1 = [LgoinLable new];
    pass1.text = @"    请输入新密码";
    [_scrollView addSubview:pass1];
 
    
    _password = [LoginTextField new];
    _password.secureTextEntry = YES;
    [_scrollView addSubview:_password];
    
    UILabel * pass2 = [LgoinLable new];
    pass2.text = @"    请确认新密码";
    [_scrollView addSubview:pass2];

    _passwordagain = [LoginTextField new];
    _passwordagain.secureTextEntry = YES;
    [_scrollView addSubview:_passwordagain];
    
    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectBtn setImage:[UIImage imageNamed:@"n_select"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"y_select"] forState:UIControlStateSelected];
    [_selectBtn addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_selectBtn];
    
    
    
    UIButton * agreement = [UIButton buttonWithType:UIButtonTypeCustom];
    [agreement setTitle:@"我已同意《言川教育》协议" forState:UIControlStateNormal];
    agreement.titleLabel.font = [UIFont systemFontOfSize:12];
    [agreement setTitleColor:UICOLORRGB(0x3EA0E6) forState:UIControlStateNormal];
    [_scrollView addSubview:agreement];
    
        
    UIButton * login = [UIButton buttonWithType:UIButtonTypeCustom];
    [login setBackgroundColor:UICOLORRGB(0x3EA0E6)];
    [login setTitle:@"登  录" forState:UIControlStateNormal];
    login.titleLabel.textColor = [UIColor whiteColor];
    login.titleLabel.font =[UIFont systemFontOfSize:18];
    login.layer.masksToBounds = YES;
    login.layer.cornerRadius = 5;
    [login addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:login];

    
    WEAKSELF(wk);
    
    [topLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.view);
        make.height.mas_equalTo(@30);
        make.top.equalTo(wk.scrollView);
    }];
    
    [school mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(topLB.mas_bottom);
        make.height.mas_equalTo(@45);
        
        
    }];
    
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wk.view);
        make.top.equalTo(school.mas_bottom);
        make.height.mas_equalTo(@45);
        

    }];
    
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(phone.mas_bottom);
        make.height.mas_equalTo(@45);
        

    }];
    
    [codeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wk.view);
        make.top.equalTo(name.mas_bottom);
        make.height.mas_equalTo(@45);
        

    }];
    
    [_codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.view);
        
        make.top.equalTo(codeLB.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(WIDTH-116, 45));
        

    }];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.codeTF.mas_right);
        make.right.equalTo(wk.view);
        make.top.height.equalTo(wk.codeTF);
//        make.width.mas_equalTo(@90);
    }];
    
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(wk.view.mas_right).offset(-16);
        make.centerY.equalTo(wk.codeTF);
        make.size.mas_equalTo(CGSizeMake(90, 30));
        
    }];
    
    [pass1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(wk.view);
        make.top.equalTo(wk.codeTF.mas_bottom);
        make.height.mas_equalTo(@45);
        

    }];
    
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(pass1.mas_bottom);
        make.height.mas_equalTo(@45);
        

    }];
    
    [pass2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(wk.password.mas_bottom);
        make.height.mas_equalTo(@45);
        

    }];
    
    
    [_passwordagain mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(pass2.mas_bottom);
        make.height.mas_equalTo(@45);
        

    }];
    
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(wk.passwordagain.mas_bottom).offset(9);
        make.left.equalTo(wk.view).offset(16);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        
    }];
    
    [agreement mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.height.equalTo(wk.selectBtn);
        make.left.equalTo(wk.selectBtn.mas_right).offset(5);
        make.width.mas_equalTo(@147.5);
    }];
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.view).offset(16);
        make.right.equalTo(wk.view).offset(-16);
        make.top.equalTo(wk.passwordagain.mas_bottom).offset(45);
        make.height.mas_equalTo(@40);
    }];
    
}

//获取验证码
- (void)countdownBtn{
    
    [[ZHNetWorking sharedZHNetWorking]POSTLOGIN:L_YZM parameters:@{@"phoneNum":self.phone,@"type":@"1"} success:^(id  _Nonnull responseObject) {
        
        
        
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
    
    if(!_selectBtn.selected){
        
        [ZHHud initWithMessage:@"请遵守协议"];
        return;
    }
    
    if (!(self.codeTF.text.length>0)) {
        
        [ZHHud initWithMessage:@"请输入短信验证码"];
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
    
    NSDictionary * dict = @{@"newPwd":[self.password.text stringToMD5],@"verCode":self.codeTF.text};
    
    [[ZHNetWorking sharedZHNetWorking]POST:L_FCPW parameters:dict success:^(id  _Nonnull responseObject) {
        
        
        if ([responseObject[@"status"]isEqualToString:@"error"]) {
            
            [ZHHud initWithMessage:responseObject[@"errMessage"]];
            
        }
        else{
            
            [ZHHud initWithMessage:@"登陆成功"];

            //进入首页
            ZHTabrController *tabBarControllerConfig = [[ZHTabrController alloc] init];
            [[[[UIApplication sharedApplication]delegate]window] setRootViewController:tabBarControllerConfig.tabBarController];        }

        
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
    
    
}

- (void)selectClick{
    
    
    _selectBtn.selected = !_selectBtn.selected;
    
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
