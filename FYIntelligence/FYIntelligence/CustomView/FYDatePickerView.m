//
//  FYDatePickerView.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/14.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYDatePickerView.h"

@interface FYDatePickerView ()
@property (strong, nonatomic) UIDatePicker *datePicker;
@end

@implementation FYDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f * XFACTOR, 200.0f * YFACTOR)];
        [view addSubview:self.datePicker];
        view.backgroundColor = [UIColor colorWithWhite:0.5f alpha:0.5f];
        view.center = self.center;
        [self addSubview:view];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_press"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(didSelectDate:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"确认" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [button sizeToFit];
        CGRect frame = button.frame;
        frame.origin.x = (200.0f * XFACTOR - CGRectGetWidth(frame)) / 2.0f;
        frame.origin.y = 160.0f * YFACTOR;
        button.frame = frame;
        [view addSubview:button];

        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
    }
    return self;
}

- (UIDatePicker *)datePicker
{
    if(!_datePicker){
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f * XFACTOR, 150.0f * YFACTOR)];
        _datePicker.datePickerMode = UIDatePickerModeTime;
        _datePicker.minuteInterval = 10;
    }
    return _datePicker;
}

- (void)didSelectDate:(UIButton *)button
{

}
@end
