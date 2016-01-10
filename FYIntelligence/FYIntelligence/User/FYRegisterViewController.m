//
//  FYRegisterViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/11.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYRegisterViewController.h"

@interface FYRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *inputBgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UITextField *comfirmPwdField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation FYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"用户注册";
    self.inputBgView.layer.masksToBounds = YES;
    self.inputBgView.layer.cornerRadius = 2.0f;

    [self.userField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.pwdField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.codeField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.comfirmPwdField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    CGRect frame = self.lineView.frame;
    frame.size.height = 0.5f;
    self.lineView.frame = frame;

    frame = self.lineView1.frame;
    frame.size.height = 0.5f;
    self.lineView1.frame = frame;

    frame = self.lineView2.frame;
    frame.size.height = 0.5f;
    self.lineView2.frame = frame;

    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.cornerRadius = 2.0f;

    UIImage *normalImage = [UIImage imageNamed:@"btn_login_normal"];
    UIImage *pressImage = [UIImage imageNamed:@"btn_login_press"];
    [self.registerButton setBackgroundImage:[normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.registerButton setBackgroundImage:[pressImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];


    self.sendButton.layer.masksToBounds = YES;
    self.sendButton.layer.cornerRadius = 3.0f;
    self.sendButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.sendButton.layer.borderWidth = 1.0f;
}


- (IBAction)registerUserInfo:(id)sender
{
    if (self.userField.text.length == 0) {
        [FYProgressHUD showMessageWithText:@"手机号码不能为空"];
        return;
    }
    if (self.pwdField.text.length == 0) {
        [FYProgressHUD showMessageWithText:@"密码不能为空"];
        return;
    }
    if (self.comfirmPwdField.text.length == 0) {
        [FYProgressHUD showMessageWithText:@"请输入确认密码"];
        return;
    }
    if (self.codeField.text.length == 0) {
        [FYProgressHUD showMessageWithText:@"验证码不能为空"];
        return;
    }
    if (![self.comfirmPwdField.text isEqualToString:self.pwdField.text]) {
        [FYProgressHUD showMessageWithText:@"两次密码不同"];
        return;
    }
    NSString *userName = self.userField.text;
    NSString *pwd = self.pwdField.text;
    NSString *code = self.codeField.text;
    NSString *request = [NSString stringWithFormat:kRegisterCmd,userName, pwd, code];
    [[FYTCPNetWork shareNetEngine] sendRequest:request complete:^(NSDictionary *dic) {
        NSString *responseString = [dic objectForKey:kResponseString];
        NSLog(@"%@",responseString);
        if([responseString rangeOfString:@"SUCCESS"].location != NSNotFound){
            __weak typeof(self)weakSelf = self;
            [FYProgressHUD showMessageWithText:@"注册成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            });
        } else{
            [FYProgressHUD showMessageWithText:@"注册失败"];
        }
    }];
}

- (IBAction)sendMessage:(UIButton *)button
{
    if (self.userField.text.length == 0) {
        [FYProgressHUD showMessageWithText:@"手机号码不能为空"];
        return;
    }
    NSString *userName = self.userField.text;
    NSString *request = [NSString stringWithFormat:kGetCodeCmd,userName];
    [[FYTCPNetWork shareNetEngine] sendRequest:request complete:^(NSDictionary *dic) {
        NSString *responseString = [dic objectForKey:kResponseString];
        NSLog(@"%@",responseString);
        if([responseString rangeOfString:@"SUCCESS"].location != NSNotFound){
            [FYProgressHUD showMessageWithText:@"获取验证码成功"];
        } else{
            [FYProgressHUD showMessageWithText:@"获取验证码失败"];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
