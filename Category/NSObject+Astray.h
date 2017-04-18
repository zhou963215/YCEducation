//
//  NSObject+Astray.h
//  PickerCell
//
//  Created by zhou on 2016/11/24.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Astray)
- (BOOL)isNotNull;

- (BOOL)isNotEmptyString;
- (NSMutableDictionary*)checkData:(NSDictionary*)dic;
@end
