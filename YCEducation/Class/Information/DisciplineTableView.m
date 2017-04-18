//
//  DisciplineTableView.m
//  YCEducation
//
//  Created by zhou on 2017/4/7.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "DisciplineTableView.h"

@implementation DisciplineTableView


+(instancetype)blog{
    
    return  [[DisciplineTableView alloc]init];
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
        self.paramter = @{@"campusId":@"1",@"fzType":@"2"};
        
        [self getData];
        
    }
    
    return self;
    
    
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    GroupHeaderView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header1"];
//    
//    NSMutableArray  * arr =[NSMutableArray arrayWithArray:self.titleArr];
//    NSDictionary * dict = @{@"groupId":@0,@"groupName":[[NSUserDefaults standardUserDefaults]objectForKey:@"schName"],@"seq":@0};
//    [arr insertObject:dict atIndex:0];
//    
//    view.titleArr = [arr mutableCopy];
//    
//    
//    
//    view.ButtonClick = ^(NSDictionary * dict){
//        
//        NSMutableDictionary * para = [self.paramter mutableCopy];
//        [para setObject:dict[@"groupId"] forKey:@"groupId"];
//        self.paramter =para;
//        [self getData];
//        
//        
//        
//    };
//    
//    
//    return view;
//    
//    
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    GroupSelectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
//    cell.nextBtn.tag = indexPath.row;
//    cell.selectBtn.tag = indexPath.row+100;
//    [cell.nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    NSDictionary * dict = self.dataArray[indexPath.row];
//    [cell upDataWithNSDictory:dict];
//    
//    return cell;
//}
@end
