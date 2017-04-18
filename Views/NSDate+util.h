//
//  NSDate+util.h
//  PickerCell
//
//  Created by zhou on 2016/11/24.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CALENDAR_UNIT       NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond

typedef NS_ENUM(NSInteger, ASTimeInterval){
    TimeIntervalSecond = 1,
    TimeIntervalMinute = 60,
    TimeIntervalHour = 3600,
    TimeIntervalDay = 86400
};

@interface NSDate (util)

/*
 * time
 * */
- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;
- (NSInteger)weekday;
- (NSInteger)weekOfMonth;

+ (NSInteger)currentYear;
+ (NSInteger)currentMonth;
+ (NSInteger)currentDay;
+ (NSInteger)currentHour;
+ (NSInteger)currentMinute;
+ (NSInteger)currentSecond;
+ (NSInteger)currentWeekday;
+ (NSInteger)currentWeekOfMonth;

/*
 * date string
 * */
- (NSString *)dateString;
- (NSString *)dateStringWithFormat:(NSString *)format;

+ (NSString *)dateStringFromNow;
+ (NSString *)dateStringFromNowWithFormat:(NSString *)format;

+ (NSDate *)dateWithString:(NSString *)dateString;
+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;

/*
 * custom date
 * */
- (NSDate *)dateWithYearOffset:(NSInteger)offset;
- (NSDate *)dateWithMonthOffset:(NSInteger)offset;
- (NSDate *)dateWithDayOffset:(NSInteger)offset;
- (NSDate *)dateWithHourOffset:(NSInteger)offset;
- (NSDate *)dateWithMinuteOffset:(NSInteger)offset;
- (NSDate *)dateWithSecondOffset:(NSInteger)offset;

+ (NSDate *)dateWithYearOffsetFromNow:(NSInteger)offset;
+ (NSDate *)dateWithMonthOffsetFromNow:(NSInteger)offset;
+ (NSDate *)dateWithDayOffsetFromNow:(NSInteger)offset;
+ (NSDate *)dateWithHourOffsetFromNow:(NSInteger)offset;
+ (NSDate *)dateWithMinuteOffsetFromNow:(NSInteger)offset;
+ (NSDate *)dateWithSecondOffsetFromNow:(NSInteger)offset;

@end
