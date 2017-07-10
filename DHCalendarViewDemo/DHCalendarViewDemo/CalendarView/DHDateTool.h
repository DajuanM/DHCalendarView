//
//  DHDateTool.h
//  DHCalendarDemo
//
//  Created by aiden on 2017/6/20.
//  Copyright © 2017年 swartz006. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHDateTool : NSObject
+ (NSInteger)line:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date;
/**
 两个时间是否相等
 */
+ (BOOL)isEqual:(NSDate *)date with:(NSDate *)date;
/**
 通过年月日创建NSDate
 */
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/**
 通过相差的天数获得NSDate
 */
+ (NSDate *)dateWithdate:(NSDate *)date offsetDay:(NSInteger)offset;
/**
 当前天
 */
+ (NSInteger)day:(NSDate *)date;

/**
 当前月
 */
+ (NSInteger)month:(NSDate *)date;
/**
 当前年
 */
+ (NSInteger)year:(NSDate *)date;

/**
 当前星期日
 */
+ (NSInteger)week:(NSDate *)date;
/**
 第一个工作日
 */
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date index:(NSInteger)index;
/**
 总共天数
 */
+ (NSInteger)totaldaysInMonth:(NSDate *)date;
/**
 上一月
 */
+ (NSDate *)lastMonth:(NSDate *)date;
/**
 下一月
 */
+ (NSDate*)nextMonth:(NSDate *)date;
/**
 上一天
 */
+ (NSDate *)lastDay:(NSDate *)date;
/**
 下一天
 */
+ (NSDate*)nextDay:(NSDate *)date;
@end
