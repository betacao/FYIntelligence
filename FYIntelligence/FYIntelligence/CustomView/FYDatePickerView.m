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

@end

@implementation FYDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f * XFACTOR, 200.0f * YFACTOR)];
        [view addSubview:self.pickerView];
        view.backgroundColor = [UIColor colorWithHexString:@"345654" alpha:0.9f];
        view.center = self.center;
        [self addSubview:view];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor colorWithHexString:@"FFD700"];
        [button addTarget:self action:@selector(didSelectDate:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"确认" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        CGRect frame = button.frame;
        frame.size.width = 60.0f * XFACTOR;
        frame.size.height = 30.0f * XFACTOR;
        frame.origin.x = (200.0f * XFACTOR - CGRectGetWidth(frame)) / 2.0f;
        frame.origin.y = 160.0f * XFACTOR;
        button.frame = frame;
        [view addSubview:button];
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

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if(component == 0){
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:28.0f];
        label.textColor = [UIColor whiteColor];
        label.text = [self.hoursArray objectAtIndex:row];
        [label sizeToFit];
        return label;
    } else{
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:28.0f];
        label.textColor = [UIColor whiteColor];
        label.text = [self.minutesArray objectAtIndex:row];
        [label sizeToFit];
        return label;
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

- (void)selectIndexs:(NSArray *)indexs forComponents:(NSArray *)components
{
    for (NSInteger i = 0;i < indexs.count; i++){
        NSInteger row = [[indexs objectAtIndex:i] integerValue];
        NSInteger component = [[components objectAtIndex:i] integerValue];
        [self.pickerView selectRow:row != NSNotFound ? row : 0 inComponent:component animated:NO];
    }
}
@end
