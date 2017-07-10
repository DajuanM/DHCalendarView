//
//  ViewController.m
//  DHCalendarViewDemo
//
//  Created by swartz006 on 2017/7/10.
//  Copyright © 2017年 swartz006. All rights reserved.
//

#import "ViewController.h"
#import "DHCalendarView.h"

@interface ViewController ()
@property (nonatomic, strong) DHCalendarView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.calendarView = [[DHCalendarView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 300)];
    self.calendarView.model = DHCalendarDayModel;
    [self.view addSubview:self.calendarView];
    [self.calendarView refreshWithAnimation:YES];
    
    self.calendarView.itemClickedBlock = ^(NSDate *date) {
        
    };
    
    self.calendarView.currentDateClock = ^(NSDate *date) {
        
    };
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(150, 450, 100, 50);
    [button setTitle:@"周模式/月模式" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClicked {
    self.calendarView.model = (self.calendarView.model == DHCalendarWeekModel) ? DHCalendarDayModel : DHCalendarWeekModel;
    [self.calendarView refreshWithAnimation:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
