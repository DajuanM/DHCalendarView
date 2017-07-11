//
//  DHCalendarContentView.m
//  DHCalendarDemo
//
//  Created by swartz006 on 2017/6/20.
//  Copyright © 2017年 swartz006. All rights reserved.
//

#import "DHCalendarView.h"
#import "DHCalendarPageView.h"


#define Width self.bounds.size.width
#define Height self.bounds.size.height

@interface DHCalendarView ()<UIScrollViewDelegate>{
    
}
@property (nonatomic, strong) UIView            *weekView;
@property (nonatomic, strong) NSMutableArray    *calendarArr;
@property (nonatomic ,strong) NSArray           *weekArr;

@end

@implementation DHCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.model = DHCalendarWeekModel;
        self.rowHeight = (frame.size.height - WeekViewH)/6;
        [self initUI];
        [self refreshWithAnimation:NO];
    }
    return self;
}

- (void)initUI {
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.weekView];
    [self addSubview:self.scrollView];
}

- (void)refreshWithAnimation:(BOOL)animation {
    if (self.model == DHCalendarDayModel) {
        self.weekArr = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
        [self refresh:self.currentDate];
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, self.rowHeight * [DHDateTool line:self.selectedDate])];
        if (animation) {
            [UIView animateWithDuration:0.3 animations:^{
                self.frame = CGRectMake(0, self.frame.origin.y, Width, self.rowHeight*6+WeekViewH);
                [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, 0)];
            }completion:^(BOOL finished) {
            }];
        }else{
            self.frame = CGRectMake(0, self.frame.origin.y, Width, self.rowHeight*6+WeekViewH);
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, 0)];
        }
        
    }else{
        self.currentDate = self.selectedDate;
        self.weekArr = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
        if (animation) {
            [UIView animateWithDuration:0.3 animations:^{
                [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, self.rowHeight * [DHDateTool line:self.selectedDate])];
                self.frame = CGRectMake(0, self.frame.origin.y, Width, self.rowHeight + WeekViewH+10);
            }completion:^(BOOL finished) {
                [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, 0)];
                [self refresh:self.selectedDate];
            }];
        }else{
            self.frame = CGRectMake(0, self.frame.origin.y, Width, self.rowHeight + WeekViewH+10);
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, 0)];
            [self refresh:self.selectedDate];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int index = scrollView.contentOffset.x / Width;
    //还在当前页 不做任何操作
    if (index == 1) {
        return;
    }
    self.currentDate = ((DHCalendarPageView *)self.calendarArr[index]).date;
    
    if (self.model == DHCalendarDayModel) {
        NSInteger currentDay = [DHDateTool day:self.currentDate];
        NSInteger dis = currentDay - 1;
        self.selectedDate = [DHDateTool dateWithdate:self.currentDate offsetDay:-dis];
    }else {
        NSInteger week = [DHDateTool week:self.currentDate];
        NSInteger dis = week - 1;
        self.selectedDate = [DHDateTool dateWithdate:self.currentDate offsetDay:-dis];
        //
        if (week == 0) {
            self.selectedDate = [DHDateTool dateWithdate:self.currentDate offsetDay:-6];
        }
    }
    if (self.itemClickedBlock) {
        self.itemClickedBlock(self.selectedDate);
    }
    [self refresh:self.currentDate];
    if (scrollView.contentOffset.x != Width) {
        [scrollView setContentOffset:CGPointMake(Width, 0)];
    }
}

- (void)refresh:(NSDate *)date {
    for (DHCalendarPageView *view in self.calendarArr) {
        view.model = self.model;
    }
    
    DHCalendarPageView *calendarView = self.calendarArr[0];
    DHCalendarPageView *calendarView1 = self.calendarArr[1];
    DHCalendarPageView *calendarView2 = self.calendarArr[2];
    
    if (self.model == DHCalendarDayModel) {
        calendarView.date = [DHDateTool lastMonth:date];
        calendarView1.date = date;
        calendarView2.date = [DHDateTool nextMonth:date];
    }else {
        calendarView.date = [DHDateTool dateWithdate:date offsetDay:-7];
        calendarView1.date = date;
        calendarView2.date = [DHDateTool dateWithdate:date offsetDay:7];
    }
    
    calendarView.selectedDate = self.selectedDate;
    calendarView1.selectedDate = self.selectedDate;
    calendarView2.selectedDate = self.selectedDate;
    
    [calendarView refreshUI];
    [calendarView1 refreshUI];
    [calendarView2 refreshUI];
    
    [self refreshWeekView];
    if (self.currentDateClock) {
        self.currentDateClock(calendarView1.date);
    }
}

- (void)refreshWeekView {
    for (int i=0; i<self.weekArr.count; i++) {
        UILabel *label = [self.weekView viewWithTag:100 + i];
        label.text = self.weekArr[i];
    }
}

#pragma mark - getter
- (UIView *)weekView {
    if (!_weekView) {
        float width = 30.0;
        float separatW = (self.bounds.size.width - width * 7) / 8;
        _weekView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, WeekViewH)];
        for (int i=0; i<self.weekArr.count; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((i+1)*separatW+i*width, 0, width, WeekViewH)];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:13];
            label.text = self.weekArr[i];
            label.tag = 100 + i;
            [_weekView addSubview:label];
        }
    }
    return _weekView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, WeekViewH, Width, Height-WeekViewH)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(Width * 3, Height-WeekViewH);
        _scrollView.layer.masksToBounds = YES;
        [_scrollView setContentOffset:CGPointMake(Width, 0)];
        for (int i=0; i<3; i++) {
            DHCalendarPageView *calendarView = [[DHCalendarPageView alloc] initWithFrame:CGRectMake(i * _scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
            calendarView.date = [NSDate date];
            calendarView.model = self.model;
            [calendarView refreshUI];
            __weak typeof(self) weakSelf = self;
            calendarView.itemClickedBlock = ^(NSDate *date) {
                weakSelf.selectedDate = date;
                if (weakSelf.itemClickedBlock) {
                    weakSelf.itemClickedBlock(date);
                }
                if (weakSelf.currentDateClock) {
                    weakSelf.currentDateClock(date);
                }
                
                [weakSelf refreshWeekView];
            };
            [self.calendarArr addObject:calendarView];
            [_scrollView addSubview:calendarView];
        }
        [self refresh:[NSDate date]];
    }
    return _scrollView;
}

- (NSMutableArray *)calendarArr {
    if (!_calendarArr) {
        _calendarArr = [NSMutableArray arrayWithCapacity:3];
    }
    return _calendarArr;
}

- (NSArray *)weekArr {
    if (!_weekArr) {
        _weekArr = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    }
    return _weekArr;
}

- (NSDate *)selectedDate {
    if (!_selectedDate) {
        _selectedDate = [NSDate date];
    }
    return _selectedDate;
}

- (NSDate *)currentDate {
    if (!_currentDate) {
        _currentDate = [NSDate date];
    }
    return _currentDate;
}

@end
