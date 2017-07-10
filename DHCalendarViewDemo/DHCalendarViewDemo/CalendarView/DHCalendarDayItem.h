//
//  DHCalendarDayItem.h
//  DHCalendarDemo
//
//  Created by swartz006 on 2017/6/20.
//  Copyright © 2017年 swartz006. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHCalendarPageView.h"

typedef void (^ItemClickedBlock) (NSDate *date);

@interface DHCalendarDayItem : UIView
@property (nonatomic, strong) UIImageView       *imgView;
@property (nonatomic, strong) UILabel           *titleLabel;
@property (nonatomic ,strong) UIButton          *button;
@property (nonatomic, strong) UIView            *lineView;
@property (nonatomic ,strong) NSDate            *date;
@property (nonatomic, strong) NSDate            *calendarDate;
@property (nonatomic, assign) BOOL              isSelected;
@property (nonatomic ,strong) ItemClickedBlock  itemClickedBlock;
@property (nonatomic, assign) DHCalendarModel   model;
@end
