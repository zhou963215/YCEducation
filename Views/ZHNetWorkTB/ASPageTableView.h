//
//  ASPageTableView.h
//  SupDoctor
//
//  Created by wyit on 16/1/19.
//  Copyright © 2016年 DingKou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageTableView.h"
@interface ASPageTableView : PageTableView

@property(nonatomic, copy) NSString *url;
@property(nonatomic, retain) NSDictionary *parameter;


@end
