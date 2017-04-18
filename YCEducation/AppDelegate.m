//
//  AppDelegate.m
//  YCEducation
//
//  Created by zhou on 2017/2/17.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "AppDelegate.h"
#import "ZHTabrController.h"
#import "ViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "LoginViewController.h"
#import <SDWebImage/SDWebImageManager.h>
#import <Bugtags/Bugtags.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Bugtags startWithAppKey:@"095035197540c661309911168ef3cfd0" invocationEvent:BTGInvocationEventBubble];
    
    NSLog(@"%@",NSHomeDirectory());
    
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    
    ZHTabrController *tabBarControllerConfig = [[ZHTabrController alloc] init];
    
    UINavigationController * login = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
    
    [self.window setRootViewController:token?tabBarControllerConfig.tabBarController:login];
    
//    [self.window setRootViewController:login];
    
//    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
//    
//    [self.window setRootViewController:nav];

    //手机序列号
    NSString* identifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString] ;
    NSLog(@"手机序列号: %@",identifierNumber);
    //设备名称
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    NSLog(@"设备名称: %@",deviceName );
    //手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"手机系统版本: %@", phoneVersion);
    //手机型号
    NSString* phoneModel = [[UIDevice currentDevice] model];
    NSLog(@"手机型号: %@",phoneModel );
    
//    SDWebImageDownloader * imgDownloader =[SDWebImageDownloader sharedDownloader];
//    
//    imgDownloader.headersFilter  = ^NSDictionary *(NSURL *url, NSDictionary *headers) {
//        
//        NSFileManager *fm = [[NSFileManager alloc] init];
//        NSString *imgKey =[[SDWebImageManager sharedManager]cacheKeyForURL:url];
//        NSString *imgPath = [[SDWebImageManager sharedManager].imageCache defaultCachePathForKey:imgKey];
//        NSDictionary *fileAttr = [fm attributesOfItemAtPath:imgPath error:nil];
//        
//        NSMutableDictionary *mutableHeaders = [headers mutableCopy];
//        
//        NSDate *lastModifiedDate = nil;
//        
//        if (fileAttr.count > 0) {
//            if (fileAttr.count > 0) {
//                lastModifiedDate = (NSDate *)fileAttr[NSFileModificationDate];
//            }
//            
//        }
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
//        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//        formatter.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss z";
//        
//        NSString *lastModifiedStr = [formatter stringFromDate:lastModifiedDate];
//        lastModifiedStr = lastModifiedStr.length > 0 ? lastModifiedStr : @"";
//        [mutableHeaders setValue:lastModifiedStr forKey:@"If-Modified-Since"];
//        // If-None-Match If-Modified-Since
//        return mutableHeaders;
//    };
    SDWebImageDownloader *imgDownloader = SDWebImageManager.sharedManager.imageDownloader;
    
    imgDownloader.headersFilter  = ^NSDictionary *(NSURL *url, NSDictionary *headers) {
        
        NSFileManager *fm = [[NSFileManager alloc] init];
        
        NSString *imgKey = [SDWebImageManager.sharedManager cacheKeyForURL:url];
        
        NSString *imgPath = [SDWebImageManager.sharedManager.imageCache defaultCachePathForKey:imgKey];
        
        NSDictionary *fileAttr = [fm attributesOfItemAtPath:imgPath error:nil];
        
        NSMutableDictionary *mutableHeaders = [headers mutableCopy];
        
        NSDate *lastModifiedDate = nil;
        
        if (fileAttr.count > 0) {
            
            if (fileAttr.count > 0) {
                
                lastModifiedDate = (NSDate *)fileAttr[NSFileModificationDate];
                
            }
            
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        
        formatter.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss z";
        
        NSString *lastModifiedStr = [formatter stringFromDate:lastModifiedDate];
        
        lastModifiedStr = lastModifiedStr.length > 0 ? lastModifiedStr : @"";
        
        [mutableHeaders setValue:lastModifiedStr forKey:@"If-Modified-Since"];
        
        return mutableHeaders;
        
    };
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSLog(@"result = %@",resultDic);
            NSLog(@"resultStatus=%@",resultDic[@"resultStatus"]);
            
            
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}


@end
