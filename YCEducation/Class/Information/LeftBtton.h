//
//  LeftBtton.h
//  YCEducation
//
//  Created by zhou on 2017/4/1.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftBtton : UIButton
@property(nonatomic,strong)UIImageView * leftImg;
@property(nonatomic,strong)UILabel * titleLB;
+(instancetype)sharButton;
@end
