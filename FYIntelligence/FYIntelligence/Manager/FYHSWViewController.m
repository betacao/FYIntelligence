//
//  FYHSWViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/15.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYHSWViewController.h"

@interface FYHSWViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UISwitch *switchControl;
@property (strong, nonatomic) NSString *selectedValue;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation FYHSWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"恒水位";
    self.dataArray = @[@"50", @"80", @"100"];
    [self.pickerView selectRow:self.dataArray.count / 2 inComponent:0 animated:NO];
    self.selectedValue = [self.dataArray objectAtIndex:self.dataArray.count / 2];
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedValue = [self.dataArray objectAtIndex:row];
    [self changeImage:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0f * XFACTOR;
}

- (void)getInfo
{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *responseString = [[FYUDPNetWork sharedNetWork] sendMessage:kGETHSWCmd type:1];
        if ([responseString containsString:@"OFF"]||[responseString containsString:@"ERROR"]) {
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
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
            [self.switchControl setOn:[value isEqualToString:@"01"] ? YES : NO];
            value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:1]).range];
            if ([self.dataArray indexOfObject:value] != NSNotFound) {
                NSInteger index = [self.dataArray indexOfObject:value];
                self.selectedValue = value;
                [self.pickerView selectRow:index inComponent:0 animated:NO];
                [self changeImage:index];
            }
        });
    });

    

}

- (IBAction)sendMessage:(id)sender
{
    NSString *string = [NSString stringWithFormat:kHSWCmd,self.switchControl.isOn ? @"01" : @"00", self.selectedValue];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[FYUDPNetWork sharedNetWork] sendMessage:string type:1];
    });

}

- (void)changeImage:(NSInteger)index
{
    switch (index) {
        case 0:{
            self.imageView.image = [UIImage imageNamed:@"shuiwei_50"];
        }
            break;
        case 1:{
            self.imageView.image = [UIImage imageNamed:@"shuiwei_80"];
        }
            break;
        default:{
            self.imageView.image = [UIImage imageNamed:@"sxshow"];
        }
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
