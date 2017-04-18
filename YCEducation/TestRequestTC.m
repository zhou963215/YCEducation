//
//  TestRequestTC.m
//  YCEducation
//
//  Created by zhou on 2017/2/28.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "TestRequestTC.h"

@interface TestRequestTC ()

@property(nonatomic,strong)NSArray * data;
@property(nonatomic,strong)NSArray * interfaceData;
@property(nonatomic,strong)NSArray * titleArr;
@end
@implementation TestRequestTC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    self.data = @[@[@{@"beginSeq":@"0",@"campusId":@"1",@"cardNum":@"123",@"type":@"0"},@{@"cztype":@"1",@"idOrder":@"123"},@{@"campusId":@"1",@"cardNo":@"321",@"cztype":@"1",@"funds":@"0.01",@"payChannel":@"1"},@{@"cztype":@"1",@"idOrder":@"123",@"payChannel":@"ALI",@"reqData":@""},@{@"cardNum":@"123",@"type":@"1"},@{@"accountName":@"123",@"cardNum":@"123",@"certificateId":@"1231231231",@"schoolId":@"1"}]];
//    self.titleArr = @[@[@{@"face":JYCX,@"name":@"交易查询"},@{@"face":CZLX,@"name":@"充值之后的轮询"},@{@"face":CZZB,@"name":@"充值准备"},@{@"face":CZTJ,@"name":@"充值提交"},@{@"face":GSJG,@"name":@"挂失解挂"},@{@"face":XYKBD,@"name":@"校园卡绑定"},@{@"face":BK,@"name":@"补卡"}]];
    
//    self.interfaceData = @[@"一卡通业务页面",@"基本接口",@"登录注册模块",@"资讯页面",@"首页"];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    
//    
//    return self.interfaceData.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray * arr = self.data[section];
    
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary * dict  = self.titleArr[indexPath.section][indexPath.row];
    
    cell.textLabel.text = dict[@"name"];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     NSDictionary * dict  = self.titleArr[indexPath.section][indexPath.row];
     NSDictionary * dict1  = self.data[indexPath.section][indexPath.row];
    
    [self requestWithDict:dict1 withFace:dict[@"face"]];
    
    
    
}


-(void)requestWithDict:(NSDictionary *)data withFace:(NSString *)url{
    
    
    
    [[ZHNetWorking sharedZHNetWorking]POST:url parameters:data success:^(id  _Nonnull responseObject) {
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
        
    }];
    
    
    
    
    
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
