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

@end

@implementation FYWCXHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startArray = @[@"7℃", @"8℃", @"9℃", @"10℃", @"11℃", @"12℃", @"13℃", @"14℃", @"15℃"];
    self.endArray = @[@"2℃", @"3℃", @"4℃", @"5℃"];
    self.protectArray = @[@"50℃", @"55℃", @"60℃", @"65℃", @"70℃", @"75℃", @"80℃", @"85℃", @"90℃"];
    self.title = @"集热器温差循环";
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
