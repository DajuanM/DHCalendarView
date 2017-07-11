//
//  DHCalendarDayItem.m
//  DHCalendarDemo
//
//  Created by swartz006 on 2017/6/20.
//  Copyright © 2017年 swartz006. All rights reserved.
//

#import "DHCalendarDayItem.h"
#import "DHDateTool.h"
#define IconW 30.0
//颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation DHCalendarDayItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imgView];
        [self addSubview:self.titleLabel];
//        [self addSubview:self.lineView];
        self.date = [NSDate date];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemClicked)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    self.titleLabel.text = [NSString stringWithFormat:@"%ld", [DHDateTool day:date]];
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (isSelected) {
        self.titleLabel.textColor = UIColorFromRGB(0x00BECE);
        self.imgView.hidden = NO;
    }else {
        if ([DHDateTool month:self.date] == [DHDateTool month:self.calendarDate]) {
            self.titleLabel.textColor = UIColorFromRGB(0x999999);
        }else {
            self.titleLabel.textColor = UIColorFromRGB(0xeeeeee);
        }
        self.imgView.hidden = YES;
        if ([DHDateTool isEqual:self.date with:[NSDate date]]) {
            self.titleLabel.textColor = UIColorFromRGB(0x00BECE);
        }
    }
    
}

- (void)itemClicked {
    self.itemClickedBlock(self.date);
}

#pragma mark getter 
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.bounds.size.width-IconW)/2, (self.bounds.size.height-IconW)/2, IconW, IconW)];
        _imgView.layer.cornerRadius = IconW/2;
        _imgView.layer.masksToBounds = YES;
        _imgView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _imgView.hidden = YES;
    }
    return _imgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = UIColorFromRGB(0x999999);
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width-IconW)/2, self.bounds.size.height-1, IconW, 1)];
        _lineView.backgroundColor = [UIColor redColor];
        _lineView.hidden = YES;
    }
    return _lineView;
}
@end
