//
//  NSDate+DLDateExtension.m
//  段子内涵图
//
//  Created by 李卫 on 2017/3/6.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import "NSDate+DLDateExtension.h"

@implementation NSDate (DLDateExtension)

- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    //日历
    NSCalendar *calender = [NSCalendar currentCalendar];
    //比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calender components:unit fromDate:from toDate:self options:0];
}

- (BOOL)isThisYear
{
    //日历
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSInteger nowYear = [calender component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calender component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYear;
    
}
- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    return [nowString isEqualToString:selfString];
    
}
- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    NSDateComponents *cmps = [calender components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}
@end
