//
//  FYSDSSViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/14.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYSDSSViewController.h"

@interface FYSDSSViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation FYSDSSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手动上水";
    self.dataArray = @[@"50", @"80", @"100"];
    [self.pickerView selectRow:self.dataArray.count / 2 inComponent:0 animated:NO];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:[self.dataArray objectAtIndex:row] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    return string;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (row) {
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
