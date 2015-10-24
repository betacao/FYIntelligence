//
//  FYFDBHViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/15.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYFDBHViewController.h"

@interface FYFDBHViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *postionPickView;
@property (weak, nonatomic) IBOutlet UIPickerView *temPickView;
@property (strong, nonatomic) NSArray *positionArray;
@property (strong, nonatomic) NSArray *temArray;
@property (strong, nonatomic) NSString *startValue;
@property (strong, nonatomic) NSString *endValue;

@end

@implementation FYFDBHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.positionArray = @[@"1", @"2", @"3", @"4", @"5"];
    self.temArray = @[@"6", @"7", @"8", @"9", @"10"];
    self.startValue = [self.positionArray firstObject];
    self.endValue = [self.positionArray firstObject];
    self.title = @"防冻保护";
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
        self.endValue = [self.temArray objectAtIndex:row];
    } else{
        self.startValue = [self.positionArray objectAtIndex:row];
    }
}

- (IBAction)sendMessage:(id)sender
{
    NSString *string = [NSString stringWithFormat:kFDBHCmd, self.startValue, self.endValue];
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

