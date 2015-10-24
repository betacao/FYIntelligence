//
//  FYGDXHViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/15.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYGDXHViewController.h"
#import "FYPickerView.h"
#import "FYDatePickerView.h"

@interface FYGDXHViewController ()<FYPickerViewDelegate ,FYDatePickerViewDelegate>

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

@implementation FYGDXHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"管道循环";
}
- (IBAction)positionButtonClick:(UIButton *)sender {
    FYPickerView *pickView = [[FYPickerView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight)unit:@""];
    [pickView loadDataArray:@[@"25°C", @"26°C", @"27°C", @"28°C", @"29°C", @"30°C", @"31°C", @"32°C", @"33°C", @"34°C", @"35°C", @"36°C", @"37°C", @"38°C", @"39°C", @"40°C", @"41°C", @"42°C", @"43°C", @"44°C", @"45°C", @"46°C", @"47°C", @"48°C", @"49°C", @"50°C"]];
    pickView.responseObject = sender;
    pickView.delegate = self;
    [self.view.window addSubview:pickView];
}

- (IBAction)timeButtonClick:(UIButton *)sender
{
    FYDatePickerView *pickView = [[FYDatePickerView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight)];
    pickView.responseObject = sender;
    pickView.delegate = self;
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

- (IBAction)sendMessage:(id)sender
{
    NSString *isOn1 = self.switch1.isOn ? @"1" : @"0";
    NSString *hour11 = [self.timeButton1.titleLabel.text substringToIndex:[self.timeButton1.titleLabel.text rangeOfString:@":"].location];
    NSString *minute11 = [self.timeButton1.titleLabel.text substringFromIndex:[self.timeButton1.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *hour12 = [self.timeButton4.titleLabel.text substringToIndex:[self.timeButton4.titleLabel.text rangeOfString:@":"].location];
    NSString *minute12 = [self.timeButton4.titleLabel.text substringFromIndex:[self.timeButton4.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *tem1 = [self.positionButton1.titleLabel.text substringToIndex:2];

    NSString *isOn2 = self.switch2.isOn ? @"1" : @"0";
    NSString *hour21 = [self.timeButton2.titleLabel.text substringToIndex:[self.timeButton2.titleLabel.text rangeOfString:@":"].location];
    NSString *minute21 = [self.timeButton2.titleLabel.text substringFromIndex:[self.timeButton2.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *hour22 = [self.timeButton5.titleLabel.text substringToIndex:[self.timeButton5.titleLabel.text rangeOfString:@":"].location];
    NSString *minute22 = [self.timeButton5.titleLabel.text substringFromIndex:[self.timeButton5.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *tem2 = [self.positionButton2.titleLabel.text substringToIndex:2];

    NSString *isOn3 = self.switch3.isOn ? @"1" : @"0";
    NSString *hour31 = [self.timeButton3.titleLabel.text substringToIndex:[self.timeButton3.titleLabel.text rangeOfString:@":"].location];
    NSString *minute31 = [self.timeButton3.titleLabel.text substringFromIndex:[self.timeButton3.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *hour32 = [self.timeButton6.titleLabel.text substringToIndex:[self.timeButton6.titleLabel.text rangeOfString:@":"].location];
    NSString *minute32 = [self.timeButton6.titleLabel.text substringFromIndex:[self.timeButton6.titleLabel.text rangeOfString:@":"].location + 1];
    NSString *tem3 = [self.positionButton3.titleLabel.text substringToIndex:2];

    NSString *string = [NSString stringWithFormat:kGDXHCmd, isOn1, hour11, minute11, hour12, minute12, tem1, isOn2, hour21, minute21, hour22, minute22, tem2, isOn3, hour31, minute31, hour32, minute32,tem3];
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
