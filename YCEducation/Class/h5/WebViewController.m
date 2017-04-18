//
//  WebViewController.m
//  YCEducation
//
//  Created by zhou on 2017/4/8.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "WebViewController.h"
#import "GroupViewController.h"
#import "GroupData.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "ZHHud.h"
@interface WebViewController ()<UINavigationControllerDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    
    BOOL _wasKeyboardManagerEnabled;
    CGFloat _keyBorardH;
    CGFloat _keyBorardY;
    
}
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)ZHHud * hud;
@end

@implementation WebViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if (_peopleType!=0) {
        [self throwData];

    }
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[IQKeyboardManager sharedManager] setEnable:_wasKeyboardManagerEnabled];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    [[IQKeyboardManager sharedManager]setEnable:NO];
    
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self backButton];
    
    _peopleType = 0;
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    [self.view addSubview:self.webView];
    self.webView.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.webView.scrollView.bounces = NO;
    [self.webView loadRequest:request];
    
    
    //    UITapGestureRecognizer *webTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(webTap:)];
    //    webTap.numberOfTouchesRequired = 1;
    //    webTap.numberOfTapsRequired = 1;
    //    webTap.delegate = self;
    //    webTap.cancelsTouchesInView = NO;
    //    [self.webView addGestureRecognizer:webTap];
    
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
        _hud = [ZHHud initWithLoading];

    
    
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    
    
    NSLog(@"%@",request.URL);
    return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    
        [_hud hideAnimated:YES];
        
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.context.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    
    //原生调用JS
    //token
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    [self.context[@"saveToken"] callWithArguments:@[token]];
    //设备ID
    NSString* identifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString] ;
    [self.context[@"savedeviceid"] callWithArguments:@[identifierNumber]];
    
    //版本号
    [self.context[@"saveVersion"] callWithArguments:@[@"1.0"]];
    
    
    
    __weak typeof(self) weakSelf = self;
    self.context[@"appBackAction"] = ^(){
        
        NSLog(@"%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
        });
        
        NSLog(@"123123");
        
        
    };
    //替代人选择跳转
    self.context[@"replaceGotoApp"] = ^(){
        
        GroupViewController * group = [GroupViewController new];
        group.isOnly = YES;
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            [weakSelf.navigationController pushViewController:group animated:YES];
            
        });
    };
    
    //抄送人
    self.context[@"copyGotoApp"] = ^(){
        
        GroupViewController * group = [GroupViewController new];
        group.isOnly = NO;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.navigationController pushViewController:group animated:YES];
            
        });
        
        
        
    };
    
    
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView{ // 实现代理方法， step 3
    return nil;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
    [_hud hideAnimated:YES];
     
    
}



#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}






- (void)throwData{
   
  
    
            GroupData * data = [GroupData dataModel];
            [data.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                NSMutableDictionary * dict = obj;
                [dict removeObjectForKey:@"m_name"];
                [dict setObject:dict[@"itemId"] forKey:@"obId"];
                [dict removeObjectForKey:@"itemId"];
                [dict setObject:dict[@"iType"] forKey:@"type"];
                [dict removeObjectForKey:@"iType"];
    
            }];
  
    //抄送人数据
    if (_peopleType==1) {
        
        [self.context[@"copyReceive"] callWithArguments:@[data.dataArray]];
        
    }
    //替代人数据
    if (_peopleType==2) {
        
        [self.context[@"replaceReceive"] callWithArguments:@[data.dataArray]];
        
    }
    
    _peopleType = 0;

    
}

- (void)backLastView{
    
    
     [self.context[@"backAction"] callWithArguments:@[]];
    
    
}

- ( void)dealloc{
            [_hud hideAnimated:YES];

    if(_webView){
        [_webView stopLoading];
        _webView.delegate = nil;
    }
    
}
- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue* value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue]; // 这里得到了键盘的frame
    // 你的操作，如键盘出现，控制视图上移等
    if (_keyBorardH>=keyboardRect.origin.y) {
        
        CGPoint webPoint = self.webView.scrollView.contentOffset;
        _keyBorardY = webPoint.y;
        webPoint.y += _keyBorardH-keyboardRect.origin.y+40;
        
        self.webView.scrollView.contentOffset = webPoint;
        
    }
    else if (_keyBorardH<=130){
        
        CGPoint webPoint = self.webView.scrollView.contentOffset;
        _keyBorardY = webPoint.y;
        webPoint.y = -80;
        
        self.webView.scrollView.contentOffset = webPoint;
        
        
    }
    else{
        
        CGPoint webPoint = self.webView.scrollView.contentOffset;
        _keyBorardY = webPoint.y;
        //
        //        webPoint.y = 0;
        //
        //        self.webView.scrollView.contentOffset = webPoint;
    }
    
    
}


- (void)keyboardWillHide:(NSNotification *)notification {
    // 获取info同上面的方法
    // 你的操作，如键盘移除，控制视图还原等
    
    CGPoint webPoint = self.webView.scrollView.contentOffset;
    
    webPoint.y = _keyBorardY;
    
    self.webView.scrollView.contentOffset = webPoint;
    
    
}
- (void)webTap:(UITapGestureRecognizer *)sender{
    CGPoint tapPoint = [sender locationInView:self.view]; // 获取相对于webView中的坐标，如果改成self.view则获取相对于superView中的坐标， step 4
    NSLog(@"tapPoint x:%f y:%f",tapPoint.x,tapPoint.y);
    _keyBorardH = tapPoint.y;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
