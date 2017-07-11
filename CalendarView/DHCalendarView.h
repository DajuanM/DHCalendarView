//
//  DHCalendarContentView.h
//  DHCalendarDemo
//
//  Created by swartz006 on 2017/6/20.
//  Copyright © 2017年 swartz006. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHCalendarPageView.h"
#import "DHDateTool.h"
#define WeekViewH 44.0

typedef void (^ItemClickedBlock) (NSDate *date);
typedef void (^CurrentDateClock) (NSDate *date);
@interface DHCalendarView : UIView
@property (nonatomic, strong) UIScrollView      *scrollView;
@property (nonatomic ,assign) float             rowHeight;
@property (nonatomic, assign) DHCalendarModel   model;
@property (nonatomic ,strong) ItemClickedBlock  itemClickedBlock;
@property (nonatomic ,strong) CurrentDateClock  currentDateClock;
@property (nonatomic ,strong) NSDate            *selectedDate;
@property (nonatomic, strong) NSDate            *currentDate;
- (void)refreshWithAnimation:(BOOL)animation;
@end
