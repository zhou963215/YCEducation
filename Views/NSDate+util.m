//
//  NSDate+util.m
//  PickerCell
//
//  Created by zhou on 2016/11/24.
//  Copyright © 2016年 zhou. All rights reserved.
//

#import "NSDate+util.h"
#import "NSObject+Astray.h"


@implementation NSDate (util)

#pragma mark - date

- (NSInteger)year {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:self];
    return [yearString integerValue];
}

- (NSInteger)month {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    NSString *monthString = [formatter stringFromDate:self];
    return [monthString integerValue];
}

- (NSInteger)day {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    NSString *dayString = [formatter stringFromDate:self];
    return [dayString integerValue];
}

- (NSInteger)hour {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSString *hourString = [formatter stringFromDate:self];
    return [hourString integerValue];
}

- (NSInteger)minute {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm"];
    NSString *minuteString = [formatter stringFromDate:self];
    return [minuteString integerValue];
}

- (NSInteger)second {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"ss"];
    NSString *secondString = [formatter stringFromDate:self];
    return [secondString integerValue];
}

- (NSInteger)weekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return components.weekday;
}

- (NSInteger)weekOfMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekOfMonth fromDate:self];
    return components.weekOfMonth;
}


+ (NSInteger)currentYear {
    NSDate *d = [self date];
    return d.year;
}

+ (NSInteger)currentMonth {
    NSDate *d = [self date];
    return d.month;
}

+ (NSInteger)currentDay {
    NSDate *d = [self date];
    return d.day;
}

+ (NSInteger)currentHour {
    NSDate *d = [self date];
    return d.hour;
}

+ (NSInteger)currentMinute {
    NSDate *d = [self date];
    return d.minute;
}

+ (NSInteger)currentSecond {
    NSDate *d = [self date];
    return d.second;
}

+ (NSInteger)currentWeekday {
    NSDate *d = [self date];
    return d.weekday;
}

+ (NSInteger)currentWeekOfMonth {
    NSDate *d = [self date];
    return d.weekOfMonth;
}

#pragma mark - date string

- (NSString *)dateString {
    return [self dateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)dateStringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

+ (NSString *)dateStringFromNow {
    NSDate *d = [NSDate date];
    return [d dateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)dateStringFromNowWithFormat:(NSString *)format {
    NSDate *d = [NSDate date];
    return [d dateStringWithFormat:format];
}

+ (NSDate *)dateWithString:(NSString *)dateString {
    NSDate *date = [self dateWithString:dateString format:@"yyyy-MM-dd HH:mm:ss"];
    if(!date){
        date = [self dateWithString:dateString format:@"yyyy-MM-dd"];
    }
    return date;
}

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format {
    if(![dateString isNotEmptyString]){
        return nil;
    }
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:format];
    NSDate *d = [formatter dateFromString:dateString];
    return d;
}


#pragma mark - custom date

- (NSDate *)dateWithYearOffset:(NSInteger)offset {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:CALENDAR_UNIT fromDate:self];
    [components setYear:components.year + offset];
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateWithMonthOffset:(NSInteger)offset {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:CALENDAR_UNIT fromDate:self];
    [components setMonth:components.month + offset];
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateWithDayOffset:(NSInteger)offset {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:CALENDAR_UNIT fromDate:self];
    [components setDay:components.day + offset];
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateWithHourOffset:(NSInteger)offset {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:CALENDAR_UNIT fromDate:self];
    [components setHour:components.hour + offset];
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateWithMinuteOffset:(NSInteger)offset {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:CALENDAR_UNIT fromDate:self];
    [components setMinute:components.minute + offset];
    return [calendar dateFromComponents:components];
}

- (NSDate *)dateWithSecondOffset:(NSInteger)offset {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:CALENDAR_UNIT fromDate:self];
    [components setSecond:components.second + offset];
    return [calendar dateFromComponents:components];
}

+ (NSDate *)dateWithYearOffsetFromNow:(NSInteger)offset {
    NSDate *d = [NSDate date];
    return [d dateWithYearOffset:offset];
}

+ (NSDate *)dateWithMonthOffsetFromNow:(NSInteger)offset {
    NSDate *d = [NSDate date];
    return [d dateWithMonthOffset:offset];
}

+ (NSDate *)dateWithDayOffsetFromNow:(NSInteger)offset {
    NSDate *d = [NSDate date];
    return [d dateWithDayOffset:offset];
}

+ (NSDate *)dateWithHourOffsetFromNow:(NSInteger)offset {
    NSDate *d = [NSDate date];
    return [d dateWithHourOffset:offset];
}

+ (NSDate *)dateWithMinuteOffsetFromNow:(NSInteger)offset {
    NSDate *d = [NSDate date];
    return [d dateWithMinuteOffset:offset];
}

+ (NSDate *)dateWithSecondOffsetFromNow:(NSInteger)offset {
    NSDate *d = [NSDate date];
    return [d dateWithSecondOffset:offset];
}


@end
