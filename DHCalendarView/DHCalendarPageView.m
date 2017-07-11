//
//  DHCalendarView.m
//  DHCalendarDemo
//
//  Created by swartz006 on 2017/6/20.
//  Copyright © 2017年 swartz006. All rights reserved.
//

#import "DHCalendarPageView.h"
#import "DHCalendarDayItem.h"
#import "DHDateTool.h"

#define BtnW 30.0
#define SeparatW (self.bounds.size.width - BtnW * 7) / 8
#define SeparatH (self.bounds.size.height-10 - BtnW * 6) / 6

@interface DHCalendarPageView ()

@end

@implementation DHCalendarPageView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)initUI {
    for (UIView *sview in self.subviews) {
        [sview removeFromSuperview];
    }
    if (self.model == DHCalendarDayModel) {
        for (int i=0; i<42; i++) {
            DHCalendarDayItem *item = [[DHCalendarDayItem alloc] initWithFrame:CGRectMake((i%7+1)*SeparatW+i%7*BtnW, i / 7 * (BtnW + SeparatH), BtnW, BtnW)];
            item.calendarDate = self.date;
            item.model = self.model;
            item.tag = i + 100;
            [self addSubview:item];
        }
        
    }else {
        for (int i=0; i<7; i++) {
            DHCalendarDayItem *item = [[DHCalendarDayItem alloc] initWithFrame:CGRectMake((i%7+1)*SeparatW+i%7*BtnW, i / 7 * (BtnW + SeparatH), BtnW, BtnW)];
            item.calendarDate = self.date;
            item.model = self.model;
            item.tag = i + 100;
            [self addSubview:item];
        }
    }
}

/**
 初始化UI
 */
- (void)refreshUI {
    if (self.date == nil) {
        self.date = [NSDate date];
    }
    for (UIView *sview in self.subviews) {
        [sview removeFromSuperview];
    }
    NSInteger firstWeekDay = [DHDateTool firstWeekdayInThisMonth:self.date index:1];
    NSInteger currentDay = [DHDateTool day:self.date];
    NSInteger weekday = [DHDateTool week:self.date];
    __weak typeof(self) weakSelf = self;
    if (self.model == DHCalendarDayModel) {
        for (int i=0; i<42; i++) {
            DHCalendarDayItem *item = [self viewWithTag:i+100];
            if (item == nil) {
                item = [[DHCalendarDayItem alloc] initWithFrame:CGRectMake((i%7+1)*SeparatW+i%7*BtnW, i / 7 * (BtnW + SeparatH), BtnW, BtnW)];
                item.tag = i + 100;
                [self addSubview:item];
            }
            
            item.calendarDate = self.date;
            item.date = [DHDateTool dateWithdate:self.date offsetDay:i - firstWeekDay - currentDay + 1];
            item.itemClickedBlock = ^(NSDate *date) {
                weakSelf.selectedDate = date;
                weakSelf.itemClickedBlock(date);
                [weakSelf refreshUI];
            };
            item.model = self.model;
            item.isSelected = [DHDateTool isEqual:item.date with:self.selectedDate];
            [self addSubview:item];
        }
    }else {
        for (int i=0; i<7; i++) {
            DHCalendarDayItem *item = [self viewWithTag:i+100];
            if (item == nil) {
                item = [[DHCalendarDayItem alloc] initWithFrame:CGRectMake((i%7+1)*SeparatW+i%7*BtnW, i / 7 * (BtnW + SeparatH), BtnW, BtnW)];
            }
            item.calendarDate = self.date;
            item.date = [DHDateTool dateWithdate:self.date offsetDay:i - weekday + 1];
            if (weekday == 0) {
                item.date = [DHDateTool dateWithdate:self.date offsetDay:-6+i];
            }
            item.itemClickedBlock = ^(NSDate *date) {
                weakSelf.selectedDate = date;
                weakSelf.itemClickedBlock(date);
                [weakSelf refreshUI];
            };
            item.model = self.model;
            item.isSelected = [DHDateTool isEqual:item.date with:self.selectedDate];
            [self addSubview:item];
        }
    }
}

@end
