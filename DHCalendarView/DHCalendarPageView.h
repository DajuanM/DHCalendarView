//
//  DHCalendarView.h
//  DHCalendarDemo
//
//  Created by swartz006 on 2017/6/20.
//  Copyright © 2017年 swartz006. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DHCalendarModel) {
    DHCalendarDayModel,
    DHCalendarWeekModel
};

typedef void (^ItemClickedBlock) (NSDate *date);

@interface DHCalendarPageView : UIView
@property (nonatomic, strong) NSDate            *date;
@property (nonatomic, assign) DHCalendarModel   model;
@property (nonatomic ,strong) ItemClickedBlock  itemClickedBlock;
@property (nonatomic ,strong) NSDate            *selectedDate;
//- (void)initUI;
- (void)refreshUI;
@end
