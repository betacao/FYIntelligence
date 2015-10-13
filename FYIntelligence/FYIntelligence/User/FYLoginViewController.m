//
//  FYRootViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/9.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYLoginViewController.h"
#import "FYRegisterViewController.h"
#import "FYListViewController.h"

@interface FYLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *inputBgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *rememberPwdButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *fogetButton;
@property (assign, nonatomic) BOOL isRemember;

@end

@implementation FYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.inputBgView.layer.masksToBounds = YES;
    self.inputBgView.layer.cornerRadius = 2.0f;

    [self.userField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.pwdField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    CGRect frame = self.lineView.frame;
    frame.size.height = 0.5f;
    self.lineView.frame = frame;

    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 2.0f;

    UIImage *normalImage = [UIImage imageNamed:@"btn_login_normal"];
    UIImage *pressImage = [UIImage imageNamed:@"btn_login_press"];
    [self.loginButton setBackgroundImage:[normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[pressImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (IBAction)clickRememberButton:(UIButton *)sender {
    if(self.isRemember){
        [self.rememberPwdButton setImage:[UIImage imageNamed:@"blankButton"] forState:UIControlStateNormal];
    } else{
        [self.rememberPwdButton setImage:[UIImage imageNamed:@"selectButton"] forState:UIControlStateNormal];
    }
    self.isRemember = !self.isRemember;
}

- (IBAction)clickLoginButton:(UIButton *)sender {
    FYListViewController *controller = [[FYListViewController alloc] initWithNibName:@"FYListViewController" bundle:nil];
    if(controller){
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (IBAction)clickRegisterButton:(id)sender {
    FYRegisterViewController *controller = [[FYRegisterViewController alloc] initWithNibName:@"FYRegisterViewController" bundle:nil];
    if(controller){
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (IBAction)clickForgetButton:(id)sender {
    FYRegisterViewController *controller = [[FYRegisterViewController alloc] initWithNibName:@"FYRegisterViewController" bundle:nil];
    if(controller){
        [self.navigationController pushViewController:controller animated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
