//
//  ActivityCollectionVC.m
//  YCEducation
//
//  Created by zhou on 2017/3/30.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "ActivityCollectionVC.h"

@implementation ActivityCollectionVC


+(instancetype)share{
    
    [super share];
    
    
    return [[ActivityCollectionVC alloc]init];
 
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDictionary * dict = self.apList[indexPath.row];
    
    int type = [dict[@"apType"]intValue];
    
    if (type==1) {
        
        WebViewController * wb = [WebViewController new];
        wb.url  = dict[@"apUrl"];
        if ([wb.url isEqualToString:@""]||wb.url==nil) {
            
            [ZHHud initWithMessage:@"暂无页面"];
            return;
            
        }
        [self.collection.navigationController pushViewController:wb animated:YES];
        
        
        
    }
    
}


@end
