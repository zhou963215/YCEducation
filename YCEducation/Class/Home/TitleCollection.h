//
//  TitleCollection.h
//  YCEducation
//
//  Created by zhou on 2017/3/15.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleCollection : NSObject
<UICollectionViewDataSource, UICollectionViewDelegate>

+(instancetype)share;
- (UICollectionView *)collection;
-(void)upDataWithData:(NSDictionary *)countDict;
@end
