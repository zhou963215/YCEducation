//
//  SetUpViewController.m
//  YCEducation
//
//  Created by zhou on 2017/3/28.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "SetUpViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ZHHud.h"
@interface SetUpViewController ()<UITableViewDelegate,UITableViewDataSource>
{
     CGFloat _sizeM;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArr;

@end



@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"设置";
    [self backButton];
    NSInteger size =  [[SDImageCache sharedImageCache]getSize];
    
    _sizeM =(CGFloat) size/1024/1024;
    NSString * str = [NSString stringWithFormat:@"清除本地缓存 (%.2fM)",_sizeM];

    self.dataArr = @[@{@"title":str}];

    [self.view addSubview:self.tableView];


}
- (UITableView *)tableView{
    
    if (!_tableView) {
        self.tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tableView.separatorColor = UICOLORRGB(0xdbdbdb);
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"header"];
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        self.tableView.scrollEnabled =NO;
        
        
    }
    return _tableView;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray * arr = self.dataArr[section];
    
    return arr.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dict = self.dataArr[indexPath.row];
    
    
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"header"];
    
        cell.textLabel.text = dict[@"title"];
        cell.textLabel.textColor = UICOLORRGB(0x282828);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
        return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self claer];
    
}

- (void)claer{
    
    if (_sizeM>1) {
        
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否清除缓存?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[SDImageCache sharedImageCache]clearDisk];
            
            [ZHHud initWithMessage:@"清理完成"];
            _sizeM = 0.0;
            NSString * str = [NSString stringWithFormat:@"清除本地缓存 (%.2fM)",_sizeM];
            
            self.dataArr = @[@{@"title":str}];

            [self.tableView reloadData];
        }];
        UIAlertAction * cance = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        [alert addAction:cance];
        [alert addAction:confirmAction];
        [self presentViewController:alert animated:YES completion:nil];
    
    }
    
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
