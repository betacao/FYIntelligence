//
//  FYDSJRViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/15.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYDSJRViewController.h"
#import "FYPickerView.h"
#import "FYDatePickerView.h"

@interface FYDSJRViewController ()<FYPickerViewDelegate ,FYDatePickerViewDelegate>

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

@implementation FYDSJRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定时加热";
}
- (IBAction)positionButtonClick:(UIButton *)sender {
    FYPickerView *pickView = [[FYPickerView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight) unit:@""];
    [pickView loadDataArray:@[@"40°C", @"45°C", @"50°C", @"55°C", @"60°C", @"65°C", @"70°C"]];
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
    NSString *hour1 = [self.timeButton1.titleLabel.text substringToIndex:[self.timeButton1.titleLabel.text rangeOfString:@":"].location];
    NSString *minute1 = [self.timeButton1.titleLabel.text substringFromIndex:[self.timeButton1.titleLabel.text rangeOfString:@":"].location];
    NSString *tem1 = [self.positionButton1.titleLabel.text substringToIndex:2];

    NSString *isOn2 = self.switch2.isOn ? @"1" : @"0";
    NSString *hour2 = [self.timeButton2.titleLabel.text substringToIndex:[self.timeButton2.titleLabel.text rangeOfString:@":"].location];
    NSString *minute2 = [self.timeButton2.titleLabel.text substringFromIndex:[self.timeButton2.titleLabel.text rangeOfString:@":"].location];
    NSString *tem2 = [self.positionButton2.titleLabel.text substringToIndex:2];

    NSString *isOn3 = self.switch3.isOn ? @"1" : @"0";
    NSString *hour3 = [self.timeButton3.titleLabel.text substringToIndex:[self.timeButton3.titleLabel.text rangeOfString:@":"].location];
    NSString *minute3 = [self.timeButton3.titleLabel.text substringFromIndex:[self.timeButton3.titleLabel.text rangeOfString:@":"].location];
    NSString *tem3 = [self.positionButton3.titleLabel.text substringToIndex:2];

    NSString *UDPRequest = [NSString stringWithFormat:kDSJRCmd, isOn1, hour1, minute1, tem1, isOn2, hour2, minute2, tem2, isOn3, hour3, minute3, tem3];
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
