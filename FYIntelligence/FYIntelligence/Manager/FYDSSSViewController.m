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
}
- (IBAction)positionButtonClick:(UIButton *)sender {
    FYPickerView *pickView = [[FYPickerView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight) unit:@"水位"];
    [pickView loadDataArray:@[@"50", @"80", @"100"]];
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
