//
//  ASPageTableView.m
//  SupDoctor
//
//  Created by wyit on 16/1/19.
//  Copyright © 2016年 DingKou. All rights reserved.
//

#import "ASPageTableView.h"
#import "ZHNetWorking.h"
@implementation ASPageTableView


#pragma mark - data method

- (void)loadPage:(int)page{
    
    self.pageIndex = page;
    NSMutableDictionary *param = [[NSDictionary dictionaryWithDictionary:self.parameter] mutableCopy];
    [param setValue:@(page) forKey:@"page"];
    [param setValue:@(self.pageSize) forKey:@"pageSize"];
    

    [[ZHNetWorking sharedZHNetWorking]POST:self.url parameters:param success:^(id  _Nonnull responseObject) {
        

        NSDictionary *dataObject = responseObject[@"data"];
        NSLog(@"dataObject === %@",dataObject);
        
        if (self.notification) {
            [[NSNotificationCenter defaultCenter]postNotificationName:self.notification object:dataObject];
            
        }
        
        self.rowCount = [dataObject[@"count"] integerValue];
       
        NSArray *rows = dataObject[@"rows"]?dataObject[@"rows"]:dataObject[@"items"]?dataObject[@"items"]:dataObject[@"todoList"]?dataObject[@"todoList"][@"items"]?dataObject[@"todoList"][@"items"]:dataObject[@"todoList"][@"rows"]:dataObject[@"items"]?dataObject[@"items"]:dataObject[@"rows"];

//        NSArray *rows = dataObject[@"rows"]?dataObject[@"rows"]:dataObject[@"todoList"]?dataObject[@"todoList"][@"items"]:dataObject[@"items"];
        
        if (rows){
            
            if(page == 1)
            {
                self.rows = rows;
            }
            else
                
            {
                
                self.rows = [[NSMutableArray arrayWithArray:self.rows] arrayByAddingObjectsFromArray:rows];
            }
            
            NSMutableArray *array = [NSMutableArray new];
            
            [self.rows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSDictionary *dic = obj;
                NSMutableDictionary *model = [dic mutableCopy];
                [array addObject:model];
            }];
            self.rows = array;
            
        }
        self.mj_footer.hidden=!(self.rows.count > 0);
        self.emptyView.hidden = (self.rows.count > 0);
        self.titleLabel.text = @"";
        self.noNetworkView.hidden = YES;
        [self reloadData];
        [self endRefreshing];
        
        
    } failure:^(NSError * _Nonnull error) {
      
        NSLog(@"error ========== %@",error);
        self.mj_footer.hidden =YES;
        self.rows = nil;
        [self reloadData];
        self.noNetworkView.hidden = NO;
        self.emptyView.hidden = YES;
        [self endRefreshing];
        
        
    }];
    
    
    
};



@end
