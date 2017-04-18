//
//  InformationTopView.h
//  YCEducation
//
//  Created by zhou on 2017/3/29.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftBtton.h"

@interface InformationTopView : UIView
@property(copy,nonatomic)void(^ButtonClick)(NSInteger );
@property(nonatomic,strong)LeftBtton * first;


- (instancetype)initWithTop:(BOOL )top;
- (void)fillInTheData:(NSDictionary *)dict;
@end
