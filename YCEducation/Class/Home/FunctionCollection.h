//
//  FunctionCollection.h
//  YCEducation
//
//  Created by zhou on 2017/3/15.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FunctionCollection : NSObject<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic,strong)NSArray * apList;

+(instancetype)share;
- (UICollectionView *)collection;
@end
