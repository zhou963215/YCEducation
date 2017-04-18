//
//  TitleCollectionViewCell.h
//  YCEducation
//
//  Created by zhou on 2017/3/15.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UILabel * numberLB;

- (void)setDataWithDict:(NSDictionary *)dict;
@end
