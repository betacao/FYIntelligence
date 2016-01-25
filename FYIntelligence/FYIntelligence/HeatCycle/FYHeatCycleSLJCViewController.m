//
//  FYHeatCycleSLJCViewController.m
//  FYIntelligence
//
//  Created by changxicao on 16/1/9.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "FYHeatCycleSLJCViewController.h"

@interface FYHeatCycleSLJCViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSArray *dataArray1;
@property (strong, nonatomic) NSArray *dataArray2;
@property (strong, nonatomic) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) NSString *selectedValue;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;

@end

@implementation FYHeatCycleSLJCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"水流检测";
    self.bgImageView.image = [UIImage imageNamed:@"rsxh_bj"];
    self.dataArray1 = @[@"01", @"02", @"03", @"04", @"05"];
    self.dataArray2 = @[@"01", @"02", @"03", @"04", @"05"];
    self.dataArray = self.dataArray1;
    [self.pickerView selectRow:self.dataArray.count / 2 inComponent:0 animated:NO];
    self.selectedValue = [self.dataArray objectAtIndex:self.dataArray.count / 2];

    self.bottomMargin.constant = 100.0f * YFACTOR;
    [self getInfo];
    [self.leftButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] andSize:self.leftButton.frame.size] forState:UIControlStateSelected];

    [self.rightButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] andSize:self.leftButton.frame.size] forState:UIControlStateSelected];
    [self.leftButton setSelected:YES];
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
    self.selectedValue = [self.dataArray objectAtIndex:row];
}


- (void)getInfo
{
    NSString *request = [NSString stringWithFormat:kNeedPINString,kAppDelegate.deviceID,kAppDelegate.pinNumber,kAppDelegate.userName,@(kAppDelegate.globleNumber),@"read_rsljc_config"];
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
            if ([value isEqualToString:@"00"]) {
                self.dataArray = self.dataArray1;
                [self.leftButton setSelected:YES];
                [self.rightButton setSelected:NO];
            } else{
                self.dataArray = self.dataArray2;
                [self.leftButton setSelected:NO];
                [self.rightButton setSelected:YES];
            }
            [self.pickerView reloadAllComponents];
            value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:1]).range];
            if ([self.dataArray indexOfObject:value] != NSNotFound) {
                NSInteger index = [self.dataArray indexOfObject:value];
                self.selectedValue = value;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.pickerView selectRow:index inComponent:0 animated:NO];
                });
            }
        }
    }];
}

- (IBAction)sendMessage:(id)sender
{
    NSString *string = @"";
    if ([self.dataArray isEqual:self.dataArray1]) {
        string = [NSString stringWithFormat:@"rconfig_sljc$0$%@", self.selectedValue];
    } else{
        string = [NSString stringWithFormat:@"rconfig_sljc$1$%@", self.selectedValue];
    }
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
- (IBAction)leftButtonClick:(UIButton *)sender
{
    [self.leftButton setSelected:YES];
    [self.rightButton setSelected:NO];
    self.dataArray = self.dataArray1;
    [self.pickerView reloadAllComponents];
}

- (IBAction)rightButtonClick:(UIButton *)sender
{
    [self.leftButton setSelected:NO];
    [self.rightButton setSelected:YES];
    self.dataArray = self.dataArray2;
    [self.pickerView reloadAllComponents];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end