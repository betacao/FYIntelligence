//
//  FYDatePickerView.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/14.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYDatePickerView.h"

@interface FYDatePickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *hoursArray;
@property (strong, nonatomic) NSArray *minutesArray;
@property (strong, nonatomic) NSString *selectString;

@end

@implementation FYDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f * XFACTOR, 200.0f * YFACTOR)];
        [view addSubview:self.pickerView];
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

        self.selectString = @"00:00";
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
    }
    return self;
}

- (NSArray *)hoursArray
{
    if(!_hoursArray){
        _hoursArray = @[@"00时", @"01时", @"02时", @"03时", @"04时", @"05时", @"06时", @"07时", @"08时", @"09时", @"10时", @"11时", @"12时", @"13时", @"14时", @"15时", @"16时", @"17时", @"18时", @"19时", @"20时", @"21时", @"22时", @"23时"];
    }
    return _hoursArray;
}

- (NSArray *)minutesArray
{
    if(!_minutesArray){
        _minutesArray = @[@"00分", @"10分", @"20分", @"30分", @"40分", @"50分"];
    }
    return _minutesArray;
}

- (UIPickerView *)pickerView
{
    if(!_pickerView){
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f * XFACTOR, 150.0f * YFACTOR)];
        _pickerView.delegate = self;
    }
    return _pickerView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0){
        return self.hoursArray.count;
    } else{
        return self.minutesArray.count;
    }
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0){
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:[self.hoursArray objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1.0f alpha:1.0f]}];
        return string;
    } else{
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:[self.minutesArray objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1.0f alpha:1.0f]}];
        return string;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *hour = @"";
    NSString *minute = @"";
    if(component == 0){
        hour = [self.hoursArray objectAtIndex:row];
        hour = [hour substringToIndex:2];
        minute = [self.minutesArray objectAtIndex:[pickerView selectedRowInComponent:1]];
        minute = [minute substringToIndex:2];
        self.selectString = [NSString stringWithFormat:@"%@:%@",hour, minute];
    } else{
        minute = [self.minutesArray objectAtIndex:row];
        minute = [minute substringToIndex:2];
        hour = [self.hoursArray objectAtIndex:[pickerView selectedRowInComponent:0]];
        hour = [hour substringToIndex:2];
        self.selectString = [NSString stringWithFormat:@"%@:%@",hour, minute];
    }
}
- (void)didSelectDate:(UIButton *)button
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(object:didSelectDate:)]){
        [self.delegate object:self.responseObject didSelectDate:self.selectString];
        [self removeFromSuperview];
    }
}
@end
