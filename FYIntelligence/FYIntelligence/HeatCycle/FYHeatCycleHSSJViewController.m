//
//  FYHeatCycleHSSJViewController.m
//  FYIntelligence
//
//  Created by changxicao on 16/1/9.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "FYHeatCycleHSSJViewController.h"


@interface FYHeatCycleHSSJViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) NSString *selectedValue;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;

@end

@implementation FYHeatCycleHSSJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"回水时间";
    self.bgImageView.image = [UIImage imageNamed:@"rsxh_bj"];
    self.dataArray = @[@"30",@"40",@"50",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"];
    [self selectRow:self.dataArray.count / 2 value:[self.dataArray objectAtIndex:self.dataArray.count / 2]];
    [self getInfo];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:28.0f];
    label.textColor = [UIColor whiteColor];
    label.text = [self.dataArray objectAtIndex:row];
    [label sizeToFit];
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0f * XFACTOR;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self selectRow:row value:[self.dataArray objectAtIndex:row]];
}


- (void)getInfo
{
    NSString *request = [NSString stringWithFormat:kNeedPINString,kAppDelegate.deviceID,kAppDelegate.pinNumber,kAppDelegate.userName,@(kAppDelegate.globleNumber),@"read_rhssj_config"];
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

            NSString *value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:0]).range];
            NSString *mintue = [NSString stringWithFormat:@"%ld", (long)([value floatValue] / 60.0f)];
            if ([self.dataArray indexOfObject:value] != NSNotFound) {
                NSInteger index = [self.dataArray indexOfObject:value];
                [self selectRow:index value:value];
            } else if ([self.dataArray indexOfObject:mintue] != NSNotFound){
                NSInteger index = [self.dataArray indexOfObject:mintue];
                [self selectRow:index value:mintue];
            }
        }
    }];
}

- (void)selectRow:(NSInteger)index value:(NSString *)value
{
    [self.pickerView selectRow:index inComponent:0 animated:NO];
    if (index <= 2) {
        self.unitLabel.text = @"秒";
        self.selectedValue = value;
    } else{
        self.unitLabel.text = @"分钟";
        self.selectedValue = [NSString stringWithFormat:@"%ld", (long)[value integerValue] * 60];
    }

    self.selectedValue = value;
}

- (IBAction)sendMessage:(id)sender
{
    NSString *string = [NSString stringWithFormat:@"rconfig_hssj$%@", self.selectedValue];
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
