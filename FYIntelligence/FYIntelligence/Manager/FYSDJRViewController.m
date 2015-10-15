//
//  FYSDJRViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/15.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYSDJRViewController.h"

@interface FYSDJRViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation FYSDJRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手动加热";
    self.dataArray = @[@"40", @"45", @"50", @"55", @"60", @"65", @"70", @"75"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
