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
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UITextField *comfirmPwdField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation FYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"用户注册";
    self.inputBgView.layer.masksToBounds = YES;
    self.inputBgView.layer.cornerRadius = 2.0f;

    [self.userField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.pwdField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.comfirmPwdField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    CGRect frame = self.lineView.frame;
    frame.size.height = 0.5f;
    self.lineView.frame = frame;

    frame = self.lineView1.frame;
    frame.size.height = 0.5f;
    self.lineView1.frame = frame;

    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.cornerRadius = 2.0f;

    UIImage *normalImage = [UIImage imageNamed:@"btn_login_normal"];
    UIImage *pressImage = [UIImage imageNamed:@"btn_login_press"];
    [self.registerButton setBackgroundImage:[normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.registerButton setBackgroundImage:[pressImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];
}


- (IBAction)registerUserInfo:(id)sender
{
    if (![self.comfirmPwdField.text isEqualToString:self.pwdField.text]) {
        return;
    }
    NSString *userName = self.userField.text;
    NSString *pwd = self.pwdField.text;
    NSString *request = [NSString stringWithFormat:kRegisterCmd,userName, pwd];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
