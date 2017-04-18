//
//  WebViewController.h
//  YCEducation
//
//  Created by zhou on 2017/4/8.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "BsNavViewController.h"
@interface WebViewController : BsNavViewController<UIWebViewDelegate>
@property (strong, nonatomic) JSContext *context;
@property(nonatomic,assign) int  peopleType;
@property(nonatomic,copy)NSString * url;
@end
