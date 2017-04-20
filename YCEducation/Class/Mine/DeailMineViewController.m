//
//  DeailMineViewController.m
//  YCEducation
//
//  Created by zhou on 2017/3/28.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "DeailMineViewController.h"
#import "HeaderTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ZHHud.h"
#import "MineViewController.h"
@interface DeailMineViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL isChange;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArr;
@end

@implementation DeailMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"个人信息设置";
    [self backButton];
    self.dataArr = @[@[@{@"title":@"头像",@"img":_dict[@"headImg"]}],@[@{@"title":@"姓名",@"img":_dict[@"userName"]},@{@"title":@"部门",@"img":_dict[@"xzJob"]},@{@"title":@"职称",@"img":_dict[@"xzJob"]},@{@"title":@"手机号码",@"img":_dict[@"phoneNum"]},@{@"title":@"邮箱",@"img":_dict[@"phoneNum"]}]];

    [self.view addSubview:self.tableView];
 }


- (UITableView *)tableView{
    
    if (!_tableView) {
        self.tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 326.5)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tableView.separatorColor = UICOLORRGB(0xdbdbdb);
        [self.tableView registerClass:[HeaderTableViewCell class] forCellReuseIdentifier:@"header"];
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        self.tableView.scrollEnabled =NO;
        
        
    }
    return _tableView;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0&&indexPath.row==0) {
        return 70;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return 0.001;
    }
    return 6.5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray * arr = self.dataArr[section];
    
    return arr.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * dict = self.dataArr[indexPath.section][indexPath.row];

    if (indexPath.section==0&&indexPath.row==0) {
        
        HeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"header"];
        cell.textLabel.text = dict[@"title"];
        cell.textLabel.textColor = UICOLORRGB(0x282828);
        

        [cell.header sd_setImageWithURL:[NSURL URLWithString:dict[@"img"]] placeholderImage:[UIImage imageNamed:@"m_tou"]options:SDWebImageRefreshCached];
        return cell;
      
        
    }
    else{
       
        
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mine"];
        if (!cell) {
            
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mine"];
        }
        
        cell.textLabel.text = dict[@"title"];
        cell.textLabel.textColor = UICOLORRGB(0x282828);
        cell.detailTextLabel.text = dict[@"img"];
        cell.detailTextLabel.textColor = UICOLORRGB(0x282828);;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0&&indexPath.row==0) {
        
        [self callActionSheet];
    }
    
    
    
}


- (void)callActionSheet{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"上传头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        
        [self callImagePickerControllerWithIndex:0];
        
    }];
    UIAlertAction *phone = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [self callImagePickerControllerWithIndex:1];
        
    }];
    UIAlertAction * cance = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    [alert addAction:cance];
    [alert addAction:confirmAction];
    [alert addAction:phone];
    [self presentViewController:alert animated:YES completion:nil];
    
    
 
}

- (void)callImagePickerControllerWithIndex:(NSInteger)index{
    
    if (index==0&&![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        
        [ZHHud initWithMessage:@"请允许获取相册权限"];
        
        return;
  
    }

    if (index==1&&![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [ZHHud initWithMessage:@"请允许获取相机权限"];
        
        return;

    }

    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = index;
    ipc.delegate = self;

    [self presentViewController:ipc animated:YES completion:nil];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    
    NSLog(@"%@",info);
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    
    NSData * data = UIImageJPEGRepresentation(image, 0.1);
    
    [[ZHNetWorking sharedZHNetWorking]UpWithPOST:UPLOADIMG parameters:@{} data:data UpFileType:@"image" success:^(id  _Nonnull responseObject) {

        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"status"]isEqualToString:@"ok"]) {
            
            NSDictionary * dict = responseObject[@"data"];
            NSArray * arr = dict[@"imglist"];
            NSDictionary * data = arr[0];
            
            [self saveHeaderWithUrl:data[@"path"]];
            
        }
        else{
            
            [ZHHud initWithMessage:@"上传失败"];
            
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (void)saveHeaderWithUrl:(NSString *)url{
    
    
    [[ZHNetWorking sharedZHNetWorking]POST:@"3001" parameters:@{@"headUrl":url} success:^(id  _Nonnull responseObject) {

        if ([responseObject[@"status"]isEqualToString:@"ok"]) {

            [ZHHud initWithMessage:@"修改头像成功"];
            
//            NSDictionary * data = self.dataArr[0][0];
//            
//            NSString*key=[[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:data[@"img"]]];
//            
//                [[SDImageCache sharedImageCache]removeImageForKey:key withCompletion:^{
//            
//                    
//                }];
            HeaderTableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            [cell.header sd_setImageWithURL:[NSURL URLWithString:url]];
            isChange = YES;
        }
        
        
    } failure:^(NSError * _Nonnull error) {

    }];
    
    
}

- (void)backLastView{
    
    
    if (isChange) {
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[MineViewController class]]) {
                MineViewController *mine =(MineViewController *)controller;
                mine.isChange = YES;
                
                [self.navigationController popToViewController:mine animated:YES];
            }
        }
        
    }
    else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

@end
