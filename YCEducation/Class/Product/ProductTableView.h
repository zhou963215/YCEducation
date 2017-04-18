//
//  ProductTableView.h
//  YCEducation
//
//  Created by zhou on 2017/3/27.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductTableView : NSObject<UITableViewDelegate,UITableViewDataSource>
+(instancetype)share;
- (UITableView *)tableView;
@end
