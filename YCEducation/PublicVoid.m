//
//  PublicVoid.m
//  RaisePo
//
//  Created by zhou on 2016/11/25.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "PublicVoid.h"
#import<CommonCrypto/CommonDigest.h>
#import "LoginViewController.h"
@implementation PublicVoid

//sha1加密方式
+(NSString *) sha1:(NSString *)input
{
    //const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    //NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}
+ (BOOL)isPassword:(NSString *)password{
    
    NSString * str = @"^[A-Za-z0-9]{6,20}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    
    if ([regextestmobile evaluateWithObject:password]) {
        return YES;
    }
    
    return NO;
}

+(BOOL)isUserName:(NSString * )userName{
    
    
    NSString * str = @"^[A-Za-z0-9_.]{6,20}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    
    if ([regextestmobile evaluateWithObject:userName]) {
        return YES;
    }
    
    return NO;
    
    
}

+(BOOL) isMobile:(NSString *)mobileNumbel{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181(增加)
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        return YES;
    }
    
    return NO;
    
}
+(BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+(void)LogOut{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:@"token"];
    [user removeObjectForKey:@"schName"];
    [user synchronize];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
    [[[[UIApplication sharedApplication]delegate]window] setRootViewController:nav];
    
    
    
    
}
+ (NSString *)getNewUrl:(NSString *)url{
    
    
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    //设备ID
    NSString* identifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString] ;
    
    //版本号
    NSString * str = [NSString stringWithFormat:@"%@&token=%@&deviceId=%@&version=1.0.0",url,token,identifierNumber];
    
    
    
    return str;
}


@end
