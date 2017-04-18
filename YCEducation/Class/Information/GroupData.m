//
//  GroupData.m
//  YCEducation
//
//  Created by zhou on 2017/4/7.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "GroupData.h"

@implementation GroupData

+ (GroupData *)dataModel
{
    static GroupData * dataModel = nil;
    
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dataModel = [[self alloc] init];
        dataModel.dataArray = [NSMutableArray array];
    });
    return dataModel;
    
}

@end
