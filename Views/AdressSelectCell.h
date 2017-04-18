//
//  AdressSelectCell.h
//  RaisePo
//
//  Created by zhou on 2016/12/9.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHFormActionCell.h"
@interface AdressSelectCell : ZHFormActionCell

@property(nonatomic,strong)NSArray * value;
- (void)updateAddressWithProvince:(NSString *)province city:(NSString *)city town:(NSString *)town;
@end
