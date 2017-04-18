//
//  GroupData.h
//  YCEducation
//
//  Created by zhou on 2017/4/7.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupData : NSObject
@property(nonatomic,strong) NSMutableArray * dataArray;
+ (GroupData *)dataModel;

@end
