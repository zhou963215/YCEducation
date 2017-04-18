//
//  ActivityTableView.m
//  YCEducation
//
//  Created by zhou on 2017/3/30.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "ActivityTableView.h"
#import "ActivityTableViewCell.h"

@interface ActivityTableView ()


@end


@implementation ActivityTableView
+(instancetype)blog{
    
    return  [[ActivityTableView alloc]init];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[ActivityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary * dict = self.apList[indexPath.row];
    
    
    [cell upDataWithNSDictory:dict];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"活动%ld",(long)indexPath.row);
}

- (void)change:(UIButton *)sender
{
    sender.selected = !sender.selected;

    
    
    
    self.count=self.count==self.apList.count?0:self.apList.count;
    
    
    
    CGRect rect = self.tableView.frame;
    
    rect.size.height =self.count==self.apList.count?self.height:35;
    
    self.tableView.frame = rect;
    
    [self.tableView reloadData];
    
    UIScrollView *  scrollView = (UIScrollView *) self.tableView.superview.superview;
    
    if (!sender.selected) {
        
        if (!(self.apList.count<=0)) {
            
            CGPoint  point= scrollView.contentOffset;
            
            point.y +=self.height;
            scrollView.contentOffset = point;
            
        }

       
    }
    
    
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo( rect.size.height);
        
        
    }];
    
}



@end
