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

@interface FYDSSSViewController ()
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
- (IBAction)positionButton1Click:(UIButton *)sender {
    FYPickerView *pickView = [[FYPickerView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight)];
    [pickView loadDataArray:@[@"50%", @"80%", @"100%"]];
    [self.view.window addSubview:pickView];
}

- (IBAction)timeButton1Click:(UIButton *)sender
{
    FYDatePickerView *pickView = [[FYDatePickerView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight)];
//    [pickView loadDataArray:@[@"50%", @"80%", @"100%"]];
    [self.view.window addSubview:pickView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
