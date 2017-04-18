//
//  GroupTableView.m
//  YCEducation
//
//  Created by zhou on 2017/4/7.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "GroupTableView.h"

@interface GroupTableView ()


@end

@implementation GroupTableView
+(instancetype)blog{
    
    return  [[GroupTableView alloc]init];
}

- (instancetype)init{
    
    if (self = [super init]) {
        
       
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tableView.separatorColor = UICOLORRGB(0xdbdbdb);
        [self.tableView registerClass:[GroupHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
        [self.tableView registerClass:[GroupSelectTableViewCell class] forCellReuseIdentifier:@"cell"];
        
        UIView  * view = [UIView new];
        
        self.tableView.tableFooterView = view;
        
        self.paramter = @{@"campusId":[[NSUserDefaults standardUserDefaults]objectForKey:@"campusId"],@"fzType":@"1"};
        self.titleArr = @[];
        [self getData];
        
    }
    
    return self;
    
    
}

- (void)getData{
    
    
    [[ZHNetWorking sharedZHNetWorking]POSTNOHUD:SELECT_GROUP parameters:self.paramter success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"status"]isEqualToString:@"ok"]) {
            
            NSDictionary * dict =  responseObject[@"data"];
            
            self.titleArr=dict[@"menuList"];
            self.dataArray = dict[@"itemList"];
            [self.tableView reloadData];
            
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
    
    
    
}


#pragma mark - UITableViewDataSource && Delegate

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    GroupHeaderView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    
    NSMutableArray  * arr =[NSMutableArray arrayWithArray:self.titleArr];
//    NSDictionary * dict = @{@"groupId":@0,@"groupName":[[NSUserDefaults standardUserDefaults]objectForKey:@"schName"]?[[NSUserDefaults standardUserDefaults]objectForKey:@"schName"]:@"练市中学",@"seq":@0};
//    [arr insertObject:dict atIndex:0];
    
    view.titleArr = [arr mutableCopy];
    

    
    view.ButtonClick = ^(NSDictionary * dict){
      
        NSMutableDictionary * para = [self.paramter mutableCopy];
        [para setObject:dict[@"groupId"] forKey:@"groupId"];
        self.paramter =para;
        [self getData];

        
        
    };
    
    
    return view;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GroupSelectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.nextBtn.tag = indexPath.row;
    cell.selectBtn.tag = indexPath.row+100;
    [cell.nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    NSDictionary * dict = self.dataArray[indexPath.row];
    [cell upDataWithNSDictory:dict withBool:self.isOnly];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIButton * button = (UIButton *)[self.tableView viewWithTag:indexPath.row+100];
    if (button.hidden) {
        
        return;
        
    }
    [self selectBtnClick:button];
}


- (void)nextBtnClick:(UIButton *)sender{
    
    GroupSelectTableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    
    if (cell.selectBtn.selected) {
        
        return;
    }
    
    
    NSDictionary * dict = self.dataArray[sender.tag];
    NSMutableDictionary * para = [self.paramter mutableCopy];
    [para setObject:dict[@"itemId"] forKey:@"groupId"];
    
    self.paramter = para;
    [self getData];
    NSLog(@"%@",dict);
    
    
    
}

- (void)selectBtnClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    [self.tableView reloadData];
    
    NSString * str;
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:self.dataArray[sender.tag-100]];
    if ([dict[@"iType"]isEqualToString:@"1"]) {
        
        NSInteger count = self.titleArr.count;
        
        if (count>=2) {
            
            NSDictionary * dict1 = self.titleArr[count-1];
            
            str = [NSString stringWithFormat:@"...%@>%@",dict1[@"groupName"],dict[@"name"]];
            
            [dict setObject:str forKey:@"m_name"];
            
        }
        else if(count==1){
            
            
            NSDictionary * dict1 = self.titleArr[count-1];
            
            str = [NSString stringWithFormat:@"%@>%@",dict1[@"groupName"],dict[@"name"]];
            
            [dict setObject:str forKey:@"m_name"];

        }
        
    }
    else{
        
        str = dict[@"name"];
        
        [dict setObject:str forKey:@"m_name"];
        
        
        
    }
    
    NSDictionary * data = @{@"isAdd":@(sender.selected),@"data":dict};
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"groupChange" object:data];
    
    
    
    
    
    
    
}
@end
