//
//  NSDate+DLDateExtension.h
//  段子内涵图
//
//  Created by 李卫 on 2017/3/6.
//  Copyright © 2017年 李卫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DLDateExtension)

/*
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/*
 * 是否为今年
 */
- (BOOL)isThisYear;

/*
 * 是否为今天
 */
- (BOOL)isToday;

/*
 * 是否为昨天
 */
- (BOOL)isYesterday;

@end
