//
//  FYHeatCycleHSWDViewController.m
//  FYIntelligence
//
//  Created by changxicao on 16/1/9.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "FYHeatCycleHSWDViewController.h"

@interface FYHeatCycleHSWDViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *postionPickView;
@property (strong, nonatomic) NSArray *positionArray;
@property (strong, nonatomic) NSString *startValue;

@end

@implementation FYHeatCycleHSWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.positionArray = @[@"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55"];
    self.startValue = [self.positionArray firstObject];
    self.title = @"设定温度";
    self.bgImageView.image = [UIImage imageNamed:@"rsxh_bj"];
    [self getInfo];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.positionArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0f * XFACTOR;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{

    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:28.0f];
    label.textColor = [UIColor whiteColor];
    label.text = [self.positionArray objectAtIndex:row];
    [label sizeToFit];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.startValue = [self.positionArray objectAtIndex:row];
}

- (void)getInfo
{
    NSString *request = [NSString stringWithFormat:kNeedPINString,kAppDelegate.deviceID,kAppDelegate.pinNumber,kAppDelegate.userName,@(kAppDelegate.globleNumber),@"read_rhswd_config"];
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
            if ([self.positionArray indexOfObject:value1] != NSNotFound) {
                [self.postionPickView selectRow:[self.positionArray indexOfObject:value1] inComponent:0 animated:NO];
                self.startValue = value1;
            }
        }
    }];
}

- (IBAction)sendMessage:(id)sender
{
    NSString *string = [NSString stringWithFormat:@"config_rhswd$%@$%@", self.startValue, @"03"];
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
