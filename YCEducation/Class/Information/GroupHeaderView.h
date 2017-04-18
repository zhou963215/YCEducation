//
//  GroupHeaderView.h
//  YCEducation
//
//  Created by zhou on 2017/4/7.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupHeaderView : UITableViewHeaderFooterView
@property(copy,nonatomic)void (^ButtonClick)(NSDictionary* dict);

@property(nonatomic,strong)NSMutableArray * titleArr;

@end
