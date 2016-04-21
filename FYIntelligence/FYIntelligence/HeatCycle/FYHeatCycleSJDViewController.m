//
//  FYHeatCycleSJDViewController.m
//  FYIntelligence
//
//  Created by changxicao on 16/1/9.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "FYHeatCycleSJDViewController.h"
#import "FYPickerView.h"
#import "FYDatePickerView.h"

@interface FYHeatCycleSJDViewController ()<FYPickerViewDelegate ,FYDatePickerViewDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UISwitch *switch2;
@property (weak, nonatomic) IBOutlet UISwitch *switch3;
@property (weak, nonatomic) IBOutlet UIButton *timeButton1;
@property (weak, nonatomic) IBOutlet UIButton *timeButton2;
@property (weak, nonatomic) IBOutlet UIButton *timeButton3;
@property (weak, nonatomic) IBOutlet UIButton *positionButton1;
@property (weak, nonatomic) IBOutlet UIButton *positionButton2;
@property (weak, nonatomic) IBOutlet UIButton *positionButton3;

@end

@implementation FYHeatCycleSJDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"时间段";
    self.bgImageView.image = [UIImage imageNamed:@"rsxh_bj"];
    [self getInfo];
}

- (IBAction)timeButtonClick:(UIButton *)sender
{
    FYDatePickerView *pickView = [[FYDatePickerView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight)];
    pickView.responseObject = sender;
    pickView.delegate = self;
    NSString *title = sender.titleLabel.text;
    pickView.selectString = title;
    NSString *hour = [[title substringToIndex:[title rangeOfString:@":"].location] stringByAppendingString:@"时"];
    NSString *mintue = [[title substringFromIndex:[title rangeOfString:@":"].location + 1] stringByAppendingString:@"分"];
    NSInteger hourIndex = [pickView.hoursArray indexOfObject:hour];
    NSInteger mintueIndex = [pickView.minutesArray indexOfObject:mintue];
    [pickView selectIndexs:@[@(hourIndex), @(mintueIndex)] forComponents:@[@(0), @(1)]];

    [self.view.window addSubview:pickView];
}

- (void)getInfo
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *responseString = [[FYUDPNetWork sharedNetWork] sendMessage:@"read_rsjd_config" type:1];
        if ([responseString containsString:@"OFF"]||[responseString containsString:@"ERROR"]) {
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern: @"\\w+" options:0 error:nil];
            NSMutableArray *results = [NSMutableArray array];
            [regularExpression enumerateMatchesInString:responseString options:0 range:NSMakeRange(0, responseString.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
                [results addObject:result];
            }];
            NSComparator cmptr = ^(NSTextCheckingResult *obj1, NSTextCheckingResult *obj2){
                if (obj1.range.location > obj2.range.location) {
                    return (NSComparisonResult)NSOrderedDescending;
                } else if (obj1.range.location < obj2.range.location) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedSame;
            };
            NSArray *MResult = [results sortedArrayUsingComparator:cmptr];

            NSString *isOn1 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:0]).range];
            [self.switch1 setOn: [isOn1 isEqualToString:@"01"] ? YES : NO];
            NSString *hour11 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:1]).range];
            NSString *minute11 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:2]).range];
            [self.timeButton1 setTitle:[NSString stringWithFormat:@"%@:%@",hour11, minute11] forState:UIControlStateNormal];
            NSString *hour12 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:3]).range];
            NSString *minute12 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:4]).range];
            [self.positionButton1 setTitle:[NSString stringWithFormat:@"%@:%@",hour12, minute12] forState:UIControlStateNormal];

            NSString *isOn2 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:5]).range];
            [self.switch2 setOn: [isOn2 isEqualToString:@"01"] ? YES : NO];
            NSString *hour21 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:6]).range];
            NSString *minute21 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:7]).range];
            [self.timeButton2 setTitle:[NSString stringWithFormat:@"%@:%@",hour21, minute21] forState:UIControlStateNormal];
            NSString *hour22 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:8]).range];
            NSString *minute22 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:9]).range];
            [self.positionButton2 setTitle:[NSString stringWithFormat:@"%@:%@",hour22, minute22] forState:UIControlStateNormal];

            NSString *isOn3 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:10]).range];
            [self.switch3 setOn: [isOn3 isEqualToString:@"01"] ? YES : NO];
            NSString *hour31 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:11]).range];
            NSString *minute31 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:12]).range];
            [self.timeButton3 setTitle:[NSString stringWithFormat:@"%@:%@",hour31, minute31] forState:UIControlStateNormal];
            NSString *hour32 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:13]).range];
            NSString *minute32 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:14]).range];
            [self.positionButton3 setTitle:[NSString stringWithFormat:@"%@:%@",hour32, minute32] forState:UIControlStateNormal];
        });
    });
}

- (void)object:(UIButton *)button didSelectItem:(NSString *)itemString
{
    [button setTitle:itemString forState:UIControlStateNormal];
}

- (void)object:(UIButton *)button didSelectDate:(NSString *)date
{
    [button setTitle:date forState:UIControlStateNormal];
}

- (IBAction)sendMessage:(id)sender
{
    NSString *isOn1 = self.switch1.isOn ? @"01" : @"00";
    NSString *hour11 = [self.timeButton1.titleLabel.text substringToIndex:[self.timeButton1.titleLabel.text rangeOfString:@":"].location];
    NSString *minute11 = [self.timeButton1.titleLabel.text substringFromIndex:[self.timeButton1.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *hour12 = [self.positionButton1.titleLabel.text substringToIndex:[self.positionButton1.titleLabel.text rangeOfString:@":"].location];
    NSString *minute12 = [self.positionButton1.titleLabel.text substringFromIndex:[self.positionButton1.titleLabel.text rangeOfString:@":"].location + 1];

    NSString *isOn2 = self.switch2.isOn ? @"01" : @"00";
    NSString *hour21 = [self.timeButton2.titleLabel.text substringToIndex:[self.timeButton2.titleLabel.text rangeOfString:@":"].location];
    NSString *minute21 = [self.timeButton2.titleLabel.text substringFromIndex:[self.timeButton2.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *hour22 = [self.positionButton2.titleLabel.text substringToIndex:[self.positionButton2.titleLabel.text rangeOfString:@":"].location];
    NSString *minute22 = [self.positionButton2.titleLabel.text substringFromIndex:[self.positionButton2.titleLabel.text rangeOfString:@":"].location + 1];

    NSString *isOn3 = self.switch3.isOn ? @"01" : @"00";
    NSString *hour31 = [self.timeButton3.titleLabel.text substringToIndex:[self.timeButton3.titleLabel.text rangeOfString:@":"].location];
    NSString *minute31 = [self.timeButton3.titleLabel.text substringFromIndex:[self.timeButton3.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *hour32 = [self.positionButton3.titleLabel.text substringToIndex:[self.positionButton3.titleLabel.text rangeOfString:@":"].location];
    NSString *minute32 = [self.positionButton3.titleLabel.text substringFromIndex:[self.positionButton3.titleLabel.text rangeOfString:@":"].location + 1];

    NSString *string = [NSString stringWithFormat:@"rconfig_sjd$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@", isOn1, hour11, minute11, hour12, minute12, isOn2, hour21, minute21, hour22, minute22, isOn3, hour31, minute31, hour32, minute32];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[FYUDPNetWork sharedNetWork] sendMessage:string type:1];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
