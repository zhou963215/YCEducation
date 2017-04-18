//
//  PublicVoid.h
//  RaisePo
//
//  Created by zhou on 2016/11/25.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PublicVoid : NSObject
+(BOOL) isMobile:(NSString *)mobileNumbel;
+ (BOOL)isPassword:(NSString *)password;
+(NSString *) sha1:(NSString *)input;
+(BOOL)isValidateEmail:(NSString *)email;
+(BOOL)isUserName:(NSString * )userName;
+(void)LogOut;
@end
