//
//  ZHHud.m
//  YCEducation
//
//  Created by zhou on 2017/2/27.
//  Copyright © 2017年 zhou. All rights reserved.
//

#define WINDOW  [UIApplication sharedApplication].keyWindow

#import "ZHHud.h"

@implementation ZHHud


+ (instancetype)initWithMessage:(NSString *)message{
    
    
    ZHHud *hud = [ZHHud showHUDAddedTo:WINDOW animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = NSLocalizedString(message, @"HUD loading title");
    hud.offset = CGPointMake(0.f, 0.f);
    [hud hideAnimated:YES afterDelay:2.f];
    
    return hud;
}

+(instancetype)initWithLoading{
    
    ZHHud * hud = [ZHHud showHUDAddedTo:WINDOW animated:YES];

    return hud;
    
}
+(instancetype)initLoadingWithLabel:(NSString *)message{
    
    ZHHud * hud = [ZHHud showHUDAddedTo:WINDOW animated:YES];
    hud.label.text= NSLocalizedString(message, @"HUD loading title");
    return hud;
    
}


+(instancetype)initWithFailedWithMessage:(NSString *)message{
    
    ZHHud * hud = [ZHHud showHUDAddedTo:WINDOW animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.square = YES;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_error"]];
    hud.label.text= NSLocalizedString(message, @"HUD loading title");
    [hud hideAnimated:YES afterDelay:2.f];

    return hud;
}

+(instancetype)initWithSuccessMessage:(NSString *)message{
    
    ZHHud * hud = [ZHHud showHUDAddedTo:WINDOW animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.square = YES;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_done"]];
    hud.label.text= NSLocalizedString(message, @"HUD loading title");
    hud.label.textColor = [UIColor grayColor];
    [hud hideAnimated:YES afterDelay:2.f];
    
    return hud;
}



@end
