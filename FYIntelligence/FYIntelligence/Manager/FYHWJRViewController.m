//
//  FYHWJRViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/15.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYHWJRViewController.h"
#import "FYPickerView.h"
#import "FYDatePickerView.h"

@interface FYHWJRViewController ()<FYPickerViewDelegate ,FYDatePickerViewDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UISwitch *switch2;
@property (weak, nonatomic) IBOutlet UISwitch *switch3;
@property (weak, nonatomic) IBOutlet UIButton *timeButton1;
@property (weak, nonatomic) IBOutlet UIButton *timeButton2;
@property (weak, nonatomic) IBOutlet UIButton *timeButton3;
@property (weak, nonatomic) IBOutlet UIButton *timeButton4;
@property (weak, nonatomic) IBOutlet UIButton *timeButton5;
@property (weak, nonatomic) IBOutlet UIButton *timeButton6;
@property (weak, nonatomic) IBOutlet UIButton *positionButton1;
@property (weak, nonatomic) IBOutlet UIButton *positionButton2;
@property (weak, nonatomic) IBOutlet UIButton *positionButton3;

@end

@implementation FYHWJRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"恒温加热";
    [self getInfo];
}
- (IBAction)positionButtonClick:(UIButton *)sender {
    FYPickerView *pickView = [[FYPickerView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight) unit:@""];

    NSArray *array = @[@"41°C", @"42°C", @"43°C", @"44°C", @"45°C", @"46°C", @"47°C", @"48°C", @"49°C", @"50°C", @"51°C", @"52°C", @"53°C", @"54°C", @"55°C", @"56°C", @"57°C", @"58°C", @"59°C", @"60°C", @"61°C", @"62°C", @"63°C", @"64°C", @"65°C", @"66°C", @"67°C", @"68°C", @"69°C", @"70°C"];
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
    NSString *request = [NSString stringWithFormat:kNeedPINString,kAppDelegate.deviceID,kAppDelegate.pinNumber,kAppDelegate.userName,@(kAppDelegate.globleNumber),kGETHWJRCmd];
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
            [self.switch1 setOn: [isOn1 isEqualToString:@"01"] ? YES : NO];
            NSString *hour11 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:1]).range];
            NSString *minute11 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:2]).range];
            [self.timeButton1 setTitle:[NSString stringWithFormat:@"%@:%@",hour11, minute11] forState:UIControlStateNormal];
            NSString *hour12 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:3]).range];
            NSString *minute12 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:4]).range];
            [self.timeButton4 setTitle:[NSString stringWithFormat:@"%@:%@",hour12, minute12] forState:UIControlStateNormal];
            NSString *tem1 = [[responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:5]).range] stringByAppendingString:@"°C"];
            [self.positionButton1 setTitle:tem1 forState:UIControlStateNormal];

            NSString *isOn2 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:6]).range];
            [self.switch2 setOn: [isOn2 isEqualToString:@"01"] ? YES : NO];
            NSString *hour21 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:7]).range];
            NSString *minute21 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:8]).range];
            [self.timeButton2 setTitle:[NSString stringWithFormat:@"%@:%@",hour21, minute21] forState:UIControlStateNormal];

            NSString *hour22 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:9]).range];
            NSString *minute22 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:10]).range];
            [self.timeButton5 setTitle:[NSString stringWithFormat:@"%@:%@",hour22, minute22] forState:UIControlStateNormal];

            NSString *tem2 = [[responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:11]).range] stringByAppendingString:@"°C"];
            [self.positionButton2 setTitle:tem2 forState:UIControlStateNormal];

            NSString *isOn3 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:12]).range];
            [self.switch3 setOn: [isOn3 isEqualToString:@"01"] ? YES : NO];
            NSString *hour31 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:13]).range];
            NSString *minute31 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:14]).range];
            [self.timeButton3 setTitle:[NSString stringWithFormat:@"%@:%@",hour31, minute31] forState:UIControlStateNormal];


            NSString *hour32 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:15]).range];
            NSString *minute32 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:16]).range];
            [self.timeButton6 setTitle:[NSString stringWithFormat:@"%@:%@",hour32, minute32] forState:UIControlStateNormal];

            NSString *tem3 = [[responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:17]).range] stringByAppendingString:@"°C"];
            [self.positionButton3 setTitle:tem3 forState:UIControlStateNormal];
        }
    }];
}


- (IBAction)sendMessage:(id)sender
{
    NSString *isOn1 = self.switch1.isOn ? @"01" : @"00";
    NSString *hour11 = [self.timeButton1.titleLabel.text substringToIndex:[self.timeButton1.titleLabel.text rangeOfString:@":"].location];
    NSString *minute11 = [self.timeButton1.titleLabel.text substringFromIndex:[self.timeButton1.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *hour12 = [self.timeButton4.titleLabel.text substringToIndex:[self.timeButton4.titleLabel.text rangeOfString:@":"].location];
    NSString *minute12 = [self.timeButton4.titleLabel.text substringFromIndex:[self.timeButton4.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *tem1 = [self.positionButton1.titleLabel.text substringToIndex:2];

    NSString *isOn2 = self.switch2.isOn ? @"01" : @"00";
    NSString *hour21 = [self.timeButton2.titleLabel.text substringToIndex:[self.timeButton2.titleLabel.text rangeOfString:@":"].location];
    NSString *minute21 = [self.timeButton2.titleLabel.text substringFromIndex:[self.timeButton2.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *hour22 = [self.timeButton5.titleLabel.text substringToIndex:[self.timeButton5.titleLabel.text rangeOfString:@":"].location];
    NSString *minute22 = [self.timeButton5.titleLabel.text substringFromIndex:[self.timeButton5.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *tem2 = [self.positionButton2.titleLabel.text substringToIndex:2];

    NSString *isOn3 = self.switch3.isOn ? @"01" : @"00";
    NSString *hour31 = [self.timeButton3.titleLabel.text substringToIndex:[self.timeButton3.titleLabel.text rangeOfString:@":"].location];
    NSString *minute31 = [self.timeButton3.titleLabel.text substringFromIndex:[self.timeButton3.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *hour32 = [self.timeButton6.titleLabel.text substringToIndex:[self.timeButton6.titleLabel.text rangeOfString:@":"].location];
    NSString *minute32 = [self.timeButton6.titleLabel.text substringFromIndex:[self.timeButton6.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *tem3 = [self.positionButton3.titleLabel.text substringToIndex:2];

    NSString *string = [NSString stringWithFormat:kHWJRCmd, isOn1, hour11, minute11, hour12, minute12, tem1, isOn2, hour21, minute21, hour22, minute22, tem2, isOn3, hour31, minute31, hour32, minute32,tem3];
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
