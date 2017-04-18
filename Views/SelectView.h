//
//  SelectView.h
//  SelectCity
//
//  Created by 张广全 on 16/11/2.
//  Copyright © 2016年 zgq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectView : UIView
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *town;
- (instancetype)initWithZGQFrame:(CGRect)rect SelectCityTtitle:(NSString *)title;

- (void)showCityView:(void(^)(NSString *proviceStr,NSString *cityStr,NSString * disStr))selectStr;
- (void)updateAddressAtProvince:(NSString *)province city:(NSString *)city town:(NSString *)town;
@end
