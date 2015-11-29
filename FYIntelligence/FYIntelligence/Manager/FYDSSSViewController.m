//
//  FYDSSSViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/14.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYDSSSViewController.h"
#import "FYPickerView.h"
#import "FYDatePickerView.h"

@interface FYDSSSViewController ()<FYPickerViewDelegate ,FYDatePickerViewDelegate>

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

@implementation FYDSSSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定时上水";
    [self getInfo];
}

- (IBAction)positionButtonClick:(UIButton *)sender {
    FYPickerView *pickView = [[FYPickerView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight) unit:@"水位"];
    NSArray *array = @[@"50", @"80", @"100"];
    [pickView loadDataArray:array];
    pickView.responseObject = sender;
    pickView.delegate = self;
    NSString *title = sender.titleLabel.text;
    NSInteger index = [array indexOfObject:title];
    [pickView selectIndex:index];
    [self.view.window addSubview:pickView];
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

- (void)object:(UIButton *)button didSelectItem:(NSString *)itemString
{
    [button setTitle:itemString forState:UIControlStateNormal];
}

- (void)object:(UIButton *)button didSelectDate:(NSString *)date
{
    [button setTitle:date forState:UIControlStateNormal];
}


- (void)getInfo
{
    NSString *request = [NSString stringWithFormat:kNeedPINString,kAppDelegate.deviceID,kAppDelegate.pinNumber,kAppDelegate.userName,@(kAppDelegate.globleNumber),kGETDSSSCmd];
    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        if(finish){
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
            [self.switch1 setOn: [isOn1 isEqualToString:@"1"] ? YES : NO];
            NSString *hour1 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:1]).range];
            NSString *minute1 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:2]).range];
            [self.timeButton1 setTitle:[NSString stringWithFormat:@"%@:%@",hour1, minute1] forState:UIControlStateNormal];
            NSString *tem1 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:3]).range];
            [self.positionButton1 setTitle:tem1 forState:UIControlStateNormal];

            NSString *isOn2 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:4]).range];
            [self.switch2 setOn: [isOn2 isEqualToString:@"1"] ? YES : NO];
            NSString *hour2 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:5]).range];
            NSString *minute2 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:6]).range];
            [self.timeButton2 setTitle:[NSString stringWithFormat:@"%@:%@",hour2, minute2] forState:UIControlStateNormal];
            NSString *tem2 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:7]).range];
            [self.positionButton2 setTitle:tem2 forState:UIControlStateNormal];

            NSString *isOn3 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:8]).range];
            [self.switch3 setOn: [isOn3 isEqualToString:@"1"] ? YES : NO];
            NSString *hour3 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:9]).range];
            NSString *minute3 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:10]).range];
            [self.timeButton3 setTitle:[NSString stringWithFormat:@"%@:%@",hour3, minute3] forState:UIControlStateNormal];
            NSString *tem3 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:11]).range];
            [self.positionButton3 setTitle:tem3 forState:UIControlStateNormal];
        }else{
            [FYProgressHUD showMessageWithText:@"获取初始值失败"];
        }
    }];
}

- (IBAction)sendMessage:(id)sender
{
    NSString *isOn1 = self.switch1.isOn ? @"1" : @"0";
    NSString *hour1 = [self.timeButton1.titleLabel.text substringToIndex:[self.timeButton1.titleLabel.text rangeOfString:@":"].location];
    NSString *minute1 = [self.timeButton1.titleLabel.text substringFromIndex:[self.timeButton1.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *tem1 = [self.positionButton1.titleLabel.text substringToIndex:2];

    NSString *isOn2 = self.switch2.isOn ? @"1" : @"0";
    NSString *hour2 = [self.timeButton2.titleLabel.text substringToIndex:[self.timeButton2.titleLabel.text rangeOfString:@":"].location];
    NSString *minute2 = [self.timeButton2.titleLabel.text substringFromIndex:[self.timeButton2.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *tem2 = [self.positionButton2.titleLabel.text substringToIndex:2];

    NSString *isOn3 = self.switch3.isOn ? @"1" : @"0";
    NSString *hour3 = [self.timeButton3.titleLabel.text substringToIndex:[self.timeButton3.titleLabel.text rangeOfString:@":"].location];
    NSString *minute3 = [self.timeButton3.titleLabel.text substringFromIndex:[self.timeButton3.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *tem3 = [self.positionButton3.titleLabel.text substringToIndex:2];

    NSString *string = [NSString stringWithFormat:kDSSSCmd, isOn1, hour1, minute1, tem1, isOn2, hour2, minute2, tem2, isOn3, hour3, minute3, tem3];
    NSString *UDPRequest = [NSString stringWithFormat:kNeedPINString,kAppDelegate.deviceID,kAppDelegate.pinNumber,kAppDelegate.userName,@(kAppDelegate.globleNumber),string];
    [[FYUDPNetWork shareNetEngine] sendRequest:UDPRequest complete:^(BOOL finish, NSString *responseString) {
        if(finish){

        } else{
            NSString *TCPRequest = [NSString stringWithFormat:kAppDelegate.deviceID, kNeedPINClearCmd,kAppDelegate.userName,kAppDelegate.pinNumber];
            [[FYTCPNetWork shareNetEngine] sendRequest:TCPRequest complete:^(NSDictionary *dic) {

            }];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
