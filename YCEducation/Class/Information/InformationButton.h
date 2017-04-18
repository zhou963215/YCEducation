//
//  InformationButton.h
//  YCEducation
//
//  Created by zhou on 2017/3/29.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationButton : UIButton

@property(nonatomic,strong)UILabel * numberLB;
@property(nonatomic,strong)UILabel * titleLB;
+(instancetype)sharButton;
@end
