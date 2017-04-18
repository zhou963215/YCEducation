//
//  DetailWebProductVC.m
//  YCEducation
//
//  Created by zhou on 2017/4/13.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "DetailWebProductVC.h"
#import "ZHHud.h"
@interface DetailWebProductVC ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)ZHHud * hud;
@end

@implementation DetailWebProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self backButton];
    self.navigationItem.title = @"资讯详情";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];

    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    
    [self.webView loadRequest:request];
    _hud = [ZHHud initWithLoading];
    
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    [_hud hideAnimated:YES];
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
    [_hud hideAnimated:YES];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
