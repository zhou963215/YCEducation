//
//  InformationFUNtionVC.h
//  YCEducation
//
//  Created by zhou on 2017/3/30.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebViewController.h"
#import "ZHHud.h"
#import "UIView+Controller.h"

@interface InformationFuntionVC : NSObject<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic,strong)NSArray * apList;

+(instancetype)share;
- (UICollectionView *)collection;


@end
