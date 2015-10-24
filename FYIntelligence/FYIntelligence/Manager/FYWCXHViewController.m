//
//  FYWCXHViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/15.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYWCXHViewController.h"

@interface FYWCXHViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *startPickView;
@property (weak, nonatomic) IBOutlet UIPickerView *endPickView;
@property (weak, nonatomic) IBOutlet UIPickerView *protectPickView;
@property (strong, nonatomic) NSArray *startArray;
@property (strong, nonatomic) NSArray *endArray;
@property (strong, nonatomic) NSArray *protectArray;

@property (strong, nonatomic) NSString *firstValue;
@property (strong, nonatomic) NSString *secondValue;
@property (strong, nonatomic) NSString *thirdValue;

@end

@implementation FYWCXHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startArray = @[@"7°C", @"8°C", @"9°C", @"10°C", @"11°C", @"12°C", @"13°C", @"14°C", @"15°C"];
    self.endArray = @[@"2°C", @"3°C", @"4°C", @"5°C"];
    self.protectArray = @[@"50°C", @"55°C", @"60°C", @"65°C", @"70°C", @"75°C", @"80°C", @"85°C", @"90°C"];
    self.title = @"集热器温差循环";
    self.firstValue = [self.startArray firstObject];
    self.secondValue = [self.endArray firstObject];
    self.thirdValue = [self.protectArray firstObject];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if([pickerView isEqual:self.startPickView]){
        return self.startArray.count;
    } else if([pickerView isEqual:self.endPickView]){
        return self.endArray.count;
    } else{
        return self.protectArray.count;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if([pickerView isEqual:self.startPickView]){
        NSString *value = [self.startArray objectAtIndex:row];
        self.firstValue = [value substringToIndex:[value rangeOfString:@"°C"].location];
    } else if([pickerView isEqual:self.endPickView]){
        NSString *value = [self.endArray objectAtIndex:row];
        self.secondValue = [value substringToIndex:[value rangeOfString:@"°C"].location];
    } else{
        NSString *value = [self.protectArray objectAtIndex:row];
        self.thirdValue = [value substringToIndex:[value rangeOfString:@"°C"].location];
    }
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if([pickerView isEqual:self.startPickView]){
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:[self.startArray objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return string;
    } else if([pickerView isEqual:self.endPickView]){
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:[self.endArray objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return string;
    } else{
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:[self.protectArray objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return string;
    }
}


- (IBAction)sendMessage:(id)sender
{
    NSString *string = [NSString stringWithFormat:kWCXHCmd, self.firstValue, self.secondValue, self.thirdValue];
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
