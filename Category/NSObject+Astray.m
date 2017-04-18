//
//  NSObject+Astray.m
//  PickerCell
//
//  Created by zhou on 2016/11/24.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "NSObject+Astray.h"

@implementation NSObject (Astray)
#pragma mark - null

- (BOOL)isNotNull {
    return nil != self && [NSNull null] != self;
}

#pragma mark - string

- (BOOL)isNotEmptyString {
    if([self isKindOfClass:[NSString class]]){
        NSString *string = (NSString *) self;
        if([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]>0){
            return YES;
        }
    }
    return NO;
}
#pragma mark - NSDictionary
- (NSMutableDictionary*)checkData:(NSDictionary*)dic{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSArray *arr = [dict allKeys];
    for (NSString *str in arr) {
        
        NSString *value = dict[str];
        if(![value isNotNull]){
            dict[str] = @"";
        }

    }
    return dict;
}


@end
