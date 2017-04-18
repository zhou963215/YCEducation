//
//  ZHHud.h
//  YCEducation
//
//  Created by zhou on 2017/2/27.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>
@interface ZHHud : MBProgressHUD

+(instancetype)initWithMessage:(NSString *)message;
+(instancetype)initWithLoading;
+(instancetype)initLoadingWithLabel:(NSString *)message;
+(instancetype)initWithFailedWithMessage:(NSString *)message;
+(instancetype)initWithSuccessMessage:(NSString *)message;


@end
