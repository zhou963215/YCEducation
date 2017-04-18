//
//  AdvertisingView.h
//  YCEducation
//
//  Created by zhou on 2017/3/8.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdvertisingView;
@protocol ZHCycleScrollViewDelegate <NSObject>

- (void)selectScrollView:(AdvertisingView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

@end
@interface AdvertisingView : UIView
@property (nonatomic, strong) NSArray *imagesGroup;
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
@property (nonatomic, weak) id<ZHCycleScrollViewDelegate> delegate;

+ (instancetype)selectScrollViewWithFrame:(CGRect)frame data:(NSArray *)data;


@end
