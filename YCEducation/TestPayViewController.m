//
//  TestPayViewController.m
//  YCEducation
//
//  Created by zhou on 2017/2/27.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "TestPayViewController.h"
#import "ZHNetWorking.h"
#import <AlipaySDK/AlipaySDK.h>
#import "CountdownBtn.h"
@interface TestPayViewController ()

@property(nonatomic,strong)NSDictionary * data;

@end

@implementation TestPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    CountdownBtn *btn = [CountdownBtn countdownButton];
    btn.title = @"获取验证码";
    
    [btn setFrame:CGRectMake(0, 0, 100, 30)];
    btn.center = self.view.center;
    
    // 字体
    btn.titleLabelFont = [UIFont systemFontOfSize:13];
    
    // 普通状态下的背景颜色
    btn.nomalBackgroundColor = [UIColor redColor];
    
    // 失效状态下的背景颜色
    btn.disabledBackgroundColor = [UIColor grayColor];
    
    // 倒计时的时长
    btn.totalSecond = 60;
    
    [btn addTarget:self action:@selector(countdownBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    //进度b
    [btn processBlock:^(NSUInteger second) {
        
        btn.title = [NSString stringWithFormat:@"(%lis)后重新获取", second] ;
    } onFinishedBlock:^{  // 倒计时完毕
        btn.title = @"重新获取验证码";
    }];

    
//      NSDictionary * dict3=@{@"campusId":@"1",@"cardNo":@"321",@"cztype":@"1",@"funds":@"0.01",@"payChannel":@"1"};
//
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//    [[ZHNetWorking sharedZHNetWorking]POST:@"3002"parameters:dict3 success:^(id  _Nonnull responseObject) {
//        
//        self.data = responseObject[@"data"];
//        [self zhifu];
//        
//    } failure:^(NSError * _Nonnull error) {
//        
//    
//        
//    }];
   
   


}

- (void)countdownBtn{
    
    NSLog(@"asdadasdasd");
    
}
- (void)zhifu{
    
    
    [[AlipaySDK defaultService]payOrder:self.data[@"orderInfo"] fromScheme:@"YCEducation" callback:^(NSDictionary *resultDic) {
        
        
        NSLog(@"vvreslut = %@",resultDic);
                    int resultStatus = [resultDic[@"resultStatus"] intValue];
                    if (9000 == resultStatus) {
                        
                        //支付成功
                        
                        
                    }
                    else {
        
                       //支付失败
                    }

        
        
    }];
    
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
