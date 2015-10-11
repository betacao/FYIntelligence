//
//  FYJoinNetViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/11.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYJoinNetViewController.h"

@interface FYJoinNetViewController ()

@property (weak, nonatomic) IBOutlet UIView *inputBgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation FYJoinNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备入网";

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
