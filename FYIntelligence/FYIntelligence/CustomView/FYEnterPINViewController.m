//
//  FYEnterPINViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/11.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYEnterPINViewController.h"

@interface FYEnterPINViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UITextField *textField3;
@property (weak, nonatomic) IBOutlet UITextField *textField4;
@property (strong, nonatomic) UITextField *nextField;

@end

@implementation FYEnterPINViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
    self.bgView.backgroundColor = [UIColor colorWithWhite:0.8f alpha:0.5f];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField isEqual:self.textField1]){
        self.nextField = self.textField2;
    } else if([textField isEqual:self.textField2]){
        self.nextField = self.textField3;
    } else if([textField isEqual:self.textField3]){
        self.nextField = self.textField4;
    } else if([textField isEqual:self.textField4]){
        self.nextField = self.textField1;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.nextField becomeFirstResponder];
    });
    if(textField.text.length > 0){
        return NO;
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
