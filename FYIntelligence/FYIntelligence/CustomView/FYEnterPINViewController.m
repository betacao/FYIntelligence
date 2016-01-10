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
@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;
@property (weak, nonatomic) IBOutlet UIView *lineView3;
@property (strong, nonatomic) UITextField *nextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (assign, nonatomic) BOOL hasAll;

@end

@implementation FYEnterPINViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0.0f, 0.0f, kScreenWidth, kScreenHeight);
    self.view.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
    self.bgView.backgroundColor = [UIColor colorWithHexString:@"345654" alpha:0.9];
    self.nextButton.layer.masksToBounds = YES;
    self.nextButton.layer.cornerRadius = 3.0f;
    self.nextButton.layer.borderWidth = 0.5f;
    self.nextButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGFloat width = CGRectGetWidth(self.bgView.frame);
    CGFloat fieldWidth = CGRectGetWidth(self.textField1.frame);
    CGFloat margin = (width - 4.0f * fieldWidth) / 5.0f;

    CGRect frame = self.textField1.frame;
    frame.origin.x = margin;
    self.textField1.frame = frame;

    frame = self.textField2.frame;
    frame.origin.x = CGRectGetMaxX(self.textField1.frame) + margin;
    self.textField2.frame = frame;

    frame = self.textField3.frame;
    frame.origin.x = CGRectGetMaxX(self.textField2.frame) + margin;;
    self.textField3.frame = frame;

    frame = self.textField4.frame;
    frame.origin.x = CGRectGetMaxX(self.textField3.frame) + margin;;
    self.textField4.frame = frame;

    frame = self.lineView1.frame;
    frame.origin.x = CGRectGetMaxX(self.textField1.frame) + 4.0f;
    frame.size.width = margin - 8.0f;
    self.lineView1.frame = frame;

    frame = self.lineView2.frame;
    frame.origin.x = CGRectGetMaxX(self.textField2.frame) + 4.0f;
    frame.size.width = margin - 8.0f;
    self.lineView2.frame = frame;

    frame = self.lineView3.frame;
    frame.origin.x = CGRectGetMaxX(self.textField3.frame) + 4.0f;
    frame.size.width = margin - 8.0f;
    self.lineView3.frame = frame;

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

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
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(self.textField1.text.length > 0 && self.textField2.text.length > 0 && self.textField3.text.length > 0 && self.textField4.text.length > 0){
        [self.textField1 resignFirstResponder];
        [self.textField2 resignFirstResponder];
        [self.textField3 resignFirstResponder];
        [self.textField4 resignFirstResponder];
//        [self performSelector:@selector(enterAllPIN) withObject:nil afterDelay:0.5f];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakSelf.nextField isEqual:weakSelf.textField1]) {
            [textField resignFirstResponder];
        } else{
            [weakSelf.nextField becomeFirstResponder];
        }
    });
    if (textField.text.length > 0) {
        return NO;
    }
    return YES;
}

- (IBAction)clickNextButton:(id)sender
{
    [self enterAllPIN];
}

- (void)enterAllPIN
{
    if(!self.hasAll){
        self.hasAll = YES;
        if(self.delegate && [self.delegate respondsToSelector:@selector(didEnterAllPIN:index:)]){
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            NSString *pin = [NSString stringWithFormat:@"%@%@%@%@",self.textField1.text,self.textField2.text,self.textField3.text,self.textField4.text];
            [self.delegate didEnterAllPIN:pin index:self.index];
        }
    }
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
