//
//  FYYSBJViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/15.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYYSBJViewController.h"

@interface FYYSBJViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UISwitch *switch2;
@property (weak, nonatomic) IBOutlet UISwitch *switch3;

@property (weak, nonatomic) IBOutlet UIPickerView *postionPickView;
@property (weak, nonatomic) IBOutlet UIPickerView *temPickView;
@property (strong, nonatomic) NSArray *positionArray;
@property (strong, nonatomic) NSArray *temArray;
@property (strong, nonatomic) NSString *firstValue;
@property (strong, nonatomic) NSString *secondValue;

@end

@implementation FYYSBJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.positionArray = @[@"20", @"50", @"80"];
    self.temArray = @[@"35℃", @"40℃", @"45℃", @"50℃"];
    self.title = @"预设报警";
    self.firstValue = [self.positionArray firstObject];
    self.secondValue = [self.temArray firstObject];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if([pickerView isEqual:self.temPickView]){
        return self.temArray.count;
    } else{
        return self.positionArray.count;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if([pickerView isEqual:self.temPickView]){
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:[self.temArray objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return string;
    } else{
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:[self.positionArray objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return string;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if([pickerView isEqual:self.temPickView]){
        NSString *value = [self.temArray objectAtIndex:row];
        self.secondValue = [value substringToIndex:[value rangeOfString:@"℃"].location];

    } else{
        self.firstValue = [self.positionArray objectAtIndex:row];
    }
}

- (IBAction)sendMessage:(id)sender
{
    NSString *isOn1 = self.switch1.isOn ? @"1": @"0";
    NSString *isOn2 = self.switch2.isOn ? @"1": @"0";
    NSString *isOn3 = self.switch3.isOn ? @"1": @"0";
    NSString *string = [NSString stringWithFormat:kYSBJCmd, isOn1,self.firstValue,isOn2,self.secondValue,isOn3];
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
    // Dispose of any resources that can be recreated.
}

@end
