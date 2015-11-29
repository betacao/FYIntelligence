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
    self.temArray = @[@"35°C", @"40°C", @"45°C", @"50°C"];
    self.title = @"预设报警";
    self.firstValue = [self.positionArray firstObject];
    self.secondValue = [self.temArray firstObject];
    [self getInfo];
    self.postionPickView.clipsToBounds = YES;
    self.temPickView.clipsToBounds = YES;
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

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if([pickerView isEqual:self.temPickView]){
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:28.0f];
        label.textColor = [UIColor whiteColor];
        label.text = [self.temArray objectAtIndex:row];
        [label sizeToFit];
        return label;
    } else{
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:28.0f];
        label.textColor = [UIColor whiteColor];
        label.text = [self.positionArray objectAtIndex:row];
        [label sizeToFit];
        return label;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0f * XFACTOR;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if([pickerView isEqual:self.temPickView]){
        NSString *value = [self.temArray objectAtIndex:row];
        self.secondValue = [value substringToIndex:[value rangeOfString:@"°C"].location];

    } else{
        self.firstValue = [self.positionArray objectAtIndex:row];
    }
}

- (void)getInfo
{
    NSString *request = [NSString stringWithFormat:kNeedPINString,kAppDelegate.deviceID,kAppDelegate.pinNumber,kAppDelegate.userName,@(kAppDelegate.globleNumber),kGETYSBJCmd];
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

            NSString *value1 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:1]).range];
            if ([self.positionArray indexOfObject:value1] != NSNotFound) {
                [self.postionPickView selectRow:[self.positionArray indexOfObject:value1] inComponent:0 animated:NO];
            }

            NSString *isOn2 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:2]).range];
            [self.switch2 setOn: [isOn2 isEqualToString:@"01"] ? YES : NO];

            NSString *value2 = [[responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:3]).range] stringByAppendingString:@"°C"];
            NSInteger index = [self.temArray indexOfObject:value2] != NSNotFound ? [self.temArray indexOfObject:value2] : 0;
            [self.temPickView selectRow:index inComponent:0 animated:NO];

            NSString *isOn3 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:4]).range];
            [self.switch3 setOn: [isOn3 isEqualToString:@"01"] ? YES : NO];
        }else{
            [FYProgressHUD showMessageWithText:@"获取初始值失败"];
        }
    }];
}

- (IBAction)sendMessage:(id)sender
{
    NSString *isOn1 = self.switch1.isOn ? @"01": @"00";
    NSString *isOn2 = self.switch2.isOn ? @"01": @"00";
    NSString *isOn3 = self.switch3.isOn ? @"01": @"00";
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
