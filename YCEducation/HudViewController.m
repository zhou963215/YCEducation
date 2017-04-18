//
//  HudViewController.m
//  YCEducation
//
//  Created by zhou on 2017/2/24.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "HudViewController.h"
#import "ZHHud.h"
#import "UIView+Alert.h"
@interface MBExample : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) SEL selector;

@end


@implementation MBExample

+ (instancetype)exampleWithTitle:(NSString *)title selector:(SEL)selector {
    MBExample *example = [[self class] new];
    example.title = title;
    example.selector = selector;
    return example;
}

@end

@interface HudViewController ()
@property (nonatomic, strong) NSArray<NSArray<MBExample *> *> *examples;

@end

@implementation HudViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.examples = @[@[[MBExample exampleWithTitle:@"showMessage" selector:@selector(showMessage)],[MBExample exampleWithTitle:@"showLoaing" selector:@selector(showLoading)],[MBExample exampleWithTitle:@"showLoaingLabel" selector:@selector(showLoaingLabel)],[MBExample exampleWithTitle:@"showfailedLabel" selector:@selector(showfailedLabel)],[MBExample exampleWithTitle:@"showSuccessLabel" selector:@selector(showSuccessLabel)]]];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MBExampleCell"];


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.examples.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.examples[section].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MBExample *example = self.examples[indexPath.section][indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MBExampleCell" forIndexPath:indexPath];
    cell.textLabel.text = example.title;
    cell.textLabel.textColor = self.view.tintColor;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectedBackgroundView = [UIView new];
    cell.selectedBackgroundView.backgroundColor = [cell.textLabel.textColor colorWithAlphaComponent:0.1f];
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MBExample *example = self.examples[indexPath.section][indexPath.row];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:example.selector];
#pragma clang diagnostic pop
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    });
}

- (void)showMessage{
    
    [ZHHud initWithMessage:@"文字提示"];
    
}

- (void)showLoading{
    
   ZHHud * hud =   [ZHHud initWithLoading];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        // Do something useful in the background
        [self doSomeWork];
        
        // IMPORTANT - Dispatch back to the main thread. Always access UI
        // classes (including MBProgressHUD) on the main thread.
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    });

    
    
    
}

- (void)showLoaingLabel{
    
    ZHHud * hud =   [ZHHud initLoadingWithLabel:@"加载中....."];
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        [self doSomeWork];
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    });

    
}
- (void)showfailedLabel{
    
    
//    [ZHHud initWithFailedWithMessage:@"请求出错"];
    [self.view showToastWithText:@"测试文件"];
    
}

- (void)showSuccessLabel{
    
//    [ZHHud initWithSuccessMessage:@"加载成功"];
    [self.view showHUDWithText:@"测试文件"];
    
}
- (void)doSomeWork {

    sleep(3.);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
