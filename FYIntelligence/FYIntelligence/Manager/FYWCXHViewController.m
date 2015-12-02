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
    self.startArray = @[@"07°C", @"08°C", @"09°C", @"10°C", @"11°C", @"12°C", @"13°C", @"14°C", @"15°C"];
    self.endArray = @[@"02°C", @"03°C", @"04°C", @"05°C"];
    self.protectArray = @[@"50°C", @"55°C", @"60°C", @"65°C", @"70°C", @"75°C", @"80°C", @"85°C", @"90°C"];
    self.title = @"集热器温差循环";
    self.firstValue = [[self.startArray firstObject] substringToIndex:2];
    self.secondValue = [[self.endArray firstObject] substringToIndex:2];
    self.thirdValue = [[self.protectArray firstObject] substringToIndex:2];
    [self getInfo];
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

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0f * XFACTOR;
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

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if([pickerView isEqual:self.startPickView]){
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:28.0f];
        label.textColor = [UIColor whiteColor];
        label.text = [self.startArray objectAtIndex:row];
        [label sizeToFit];
        return label;
    } else if([pickerView isEqual:self.endPickView]){
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:28.0f];
        label.textColor = [UIColor whiteColor];
        label.text = [self.endArray objectAtIndex:row];
        [label sizeToFit];
        return label;
    } else{
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:28.0f];
        label.textColor = [UIColor whiteColor];
        label.text = [self.protectArray objectAtIndex:row];
        [label sizeToFit];
        return label;
    }
}

- (void)getInfo
{
    NSString *request = [NSString stringWithFormat:kNeedPINString,kAppDelegate.deviceID,kAppDelegate.pinNumber,kAppDelegate.userName,@(kAppDelegate.globleNumber),kGETWCXHCmd];
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

            NSString *value1 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:0]).range];
            self.firstValue = value1;
            NSString *value2 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:1]).range];
            self.secondValue = value2;
            NSString *value3 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:2]).range];
            self.thirdValue = value3;
            if ([self.startArray indexOfObject:[value1 stringByAppendingString:@"°C"]] != NSNotFound) {
                [self.startPickView selectRow:[self.startArray indexOfObject:[value1 stringByAppendingString:@"°C"]] inComponent:0 animated:NO];
            }
            if ([self.endArray indexOfObject:[value2 stringByAppendingString:@"°C"]] != NSNotFound) {
                [self.endPickView selectRow:[self.endArray indexOfObject:[value2 stringByAppendingString:@"°C"]] inComponent:0 animated:NO];
            }
            if ([self.protectArray indexOfObject:[value3 stringByAppendingString:@"°C"]] != NSNotFound) {
                [self.protectPickView selectRow:[self.protectArray indexOfObject:[value3 stringByAppendingString:@"°C"]] inComponent:0 animated:NO];
            }
        }else{
            [FYProgressHUD showMessageWithText:@"获取初始值失败"];
        }
    }];
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
