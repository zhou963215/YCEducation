//
//  ZHNetWorking.m
//  AFNetWork
//
//  Created by zhc on 16/6/15.
//  Copyright © 2016年 zhc. All rights reserved.
//

#import "ZHNetWorking.h"
#import <AFNetworking/AFNetworking.h>
#import "ZHHud.h"
/**
 *  是否开启https SSL 验证
 *
 *  @return YES为开启，NO为关闭
 */
#define openHttpsSSL YES
/**
 *  SSL 证书名称，仅支持cer格式。“app.bishe.com.cer”,则填“app.bishe.com”
 */
#define certificate @"client"

static ZHNetWorking * netWorking=nil;
@interface ZHNetWorking()

@property(nonatomic,strong)AFHTTPSessionManager * manager;


@end

@implementation ZHNetWorking


//ZHSingletonM(ZHNetWorking);

+(ZHNetWorking *)sharedZHNetWorking{
    
    
    if (netWorking==nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            netWorking = [[self alloc] init];
            netWorking.manager = [AFHTTPSessionManager manager];
            
        });
        
    }
    return netWorking;
}

- (void)networkStatusUnknown:(Unknown)unknown reachable:(Reachable)reachable reachableViaWWAN:(ReachableViaWWAN)reachableViaWWAN reachableViaWiFi:(ReachableViaWiFi)reachableViaWiFi

{
    
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        
        NSLog(@"%ld",(long)status);
        
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                unknown();
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                reachable();
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                reachableViaWWAN();
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                reachableViaWiFi();
                break;
                
            default:
                break;
        }
        
        
    }];
    
    
    [manager startMonitoring];
    
    
    
    
}

/**
 *  封装的get请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */

- (void)get:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    
    AFHTTPSessionManager * manager = self.manager;
    
    NSMutableSet * contentTypes = [[NSMutableSet alloc]initWithSet:manager.responseSerializer.acceptableContentTypes];
    
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    
    manager.securityPolicy = [self customSecurityPolicy];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    
    
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(responseObject);
            
            [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        [[UIApplication sharedApplication]
         setNetworkActivityIndicatorVisible:NO];
    }];
    
    
}
/**
 *  封装的POST请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    ZHHud * hud = [ZHHud initWithLoading];

    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    
    NSDictionary * dict =   @{@"token":token, @"tradeCode":URLString, @"deviceId":@"test", @"clientTime":@"2017-02-20 00:00:00", @"version":@"1.0.0",@"data":parameters};
    
    AFHTTPSessionManager *manager = self.manager;
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
    
    //https验证
    //    manager.securityPolicy = [self customSecurityPolicy];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; // 开启状态栏动画
    
    
    [manager POST:YCURL parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [hud hideAnimated:YES];

        
        if (success)
        {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            if ([dic[@"status"]isEqualToString:@"error"]) {
                
                [ZHHud initWithMessage:dic[@"errMessage"]];
                success(dic);
                
            }
            else{
                
                success(dic);
                
                
            }
            NSLog(@"success====%@",dic);
            
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [hud hideAnimated:YES];

        if (failure)
        {
            failure(error);
            [ZHHud initWithMessage:@"您的网络有问题,请稍后重试"];
            
            NSLog(@"error=====%@",error);
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
    }];
}
- (void)POSTNOHUD:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    
    NSDictionary * dict =   @{@"token":token, @"tradeCode":URLString, @"deviceId":@"test", @"clientTime":@"2017-02-20 00:00:00", @"version":@"1.0.0",@"data":parameters};
    
    AFHTTPSessionManager *manager = self.manager;
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
    
    //https验证
    //    manager.securityPolicy = [self customSecurityPolicy];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; // 开启状态栏动画
    
    
    [manager POST:YCURL parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        if (success)
        {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            if ([dic[@"status"]isEqualToString:@"error"]) {
                
                [ZHHud initWithMessage:dic[@"errMessage"]];
                success(dic);
                
            }
            else{
                
                success(dic);
                
                
            }
            NSLog(@"success====%@",dic);
            
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        if (failure)
        {
            failure(error);
            [ZHHud initWithMessage:@"您的网络有问题,请稍后重试"];
            
            NSLog(@"error=====%@",error);
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
    }];
}


- (void)POSTLOGIN:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    
    //    NSString * context = [self getDate];
    ZHHud * hud = [ZHHud initWithLoading];

    NSDictionary * dict =   @{@"tradeCode":URLString, @"deviceId":@"test", @"clientTime":@"2017-02-20 00:00:00", @"version":@"1.0.0",@"data":parameters};
    
    AFHTTPSessionManager *manager = self.manager;
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
    
    //https验证
    //    manager.securityPolicy = [self customSecurityPolicy];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = self.acceptableContentTypes;
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; // 开启状态栏动画
    
    
    [manager POST:YCURL parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [hud hideAnimated:YES];
        
        if (success)
        {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            success(dic);
            NSLog(@"success====%@",dic);
            
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [hud hideAnimated:YES];

        if (failure)
        {
            failure(error);
            [ZHHud initWithMessage:@"您的网络有问题,请稍后重试"];
            
            NSLog(@"error=====%@",error);
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
    }];
}


-(void)DownLoad:(NSString*)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString  *fullPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"test.mp4"];
    
    NSURL *url = [NSURL URLWithString:@"http://www.abc.com/test.mp4"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask * task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        //监听下载进度
        
        //completedUnitCount 已经下载的数据大小
        
        //totalUnitCount     文件数据的中大小
        
        NSLog(@"%f",1.0 *downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        
        NSLog(@"%@",filePath);
        
    }];
    
    [task resume];
    
    
    
}
//上传图片
- (void)UpWithPOST:(NSString *)URLString parameters:(NSDictionary *)parameters data:(NSData *)fileData UpFileType:(NSString *)type success:(Success)success failure:(Failure)failure
{
    
    ZHHud * hud = [ZHHud initWithLoading];

    AFHTTPSessionManager *manager = self.manager;
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/plain",
                                                         @"text/javascript",
                                                         @"text/json",
                                                         @"text/html",
                                                         @"image/jpeg", nil];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; // 开启状态栏动画
    
    NSURLSessionDataTask *uploadTask = [manager POST:UPLOADIMG parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 注意点: 当传图片的时候，typeName是image ， mimeType是@"image/*"
        // 注意点: 当传视频的时候，typeName是video ， mimeType是@"video/*"
        // filename一般不能省略后缀，比如jpg 和 mp4
        
        NSString *typeName, *mimeType, *fileName;
        if ([type isEqualToString:@"image"]) {
            typeName = @"image";
            mimeType = @"image/*";
            fileName = @"fileName.jpg";
        }else if ([type isEqualToString:@"video"]) {
            typeName = @"video";
            mimeType = @"video/*";
            fileName = @"fileName.mp4";
        }
        
        [formData appendPartWithFileData:fileData name:typeName fileName:fileName mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"%lld--%lld",uploadProgress.totalUnitCount, uploadProgress.completedUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        [hud hideAnimated:YES];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success)
        {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            success(dic);
            NSLog(@"success====%@",dic);
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [hud hideAnimated:YES];

        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (failure)
        {
            failure(error);
            [ZHHud initWithMessage:@"您的网络有问题,请稍后重试"];
            NSLog(@"error=====%@",error);
        }
        
    }];
    [uploadTask resume];
    
    
    
}



- (AFSecurityPolicy*)customSecurityPolicy {
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificate ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    NSSet *cerset = [NSSet setWithObjects:certData, nil];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = cerset;
    
    return securityPolicy;
}

- (NSString *)getDate{
    
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    
    NSString * dateFor = [formatter stringFromDate:date];
    
    
    return dateFor;
}



@end
