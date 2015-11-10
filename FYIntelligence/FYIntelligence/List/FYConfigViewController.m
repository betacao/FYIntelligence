//
//  FYConfigViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/11/7.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYConfigViewController.h"

@interface FYConfigViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftNextButton;
@property (weak, nonatomic) IBOutlet UIButton *rightNextButton;

@property (weak, nonatomic) IBOutlet UITextField *leftPwdField;
@property (weak, nonatomic) IBOutlet UITextField *leftSSidField;
@property (weak, nonatomic) IBOutlet UITextField *leftWifField;
@property (weak, nonatomic) IBOutlet UITextField *rightPwdField;
@end

@implementation FYConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
    self.bgView.backgroundColor = [UIColor colorWithHexString:@"345654" alpha:0.9f];
    self.leftNextButton.layer.cornerRadius = 8.0f;
    self.leftNextButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.leftNextButton.layer.borderWidth = 0.5f;
    self.rightNextButton.layer.cornerRadius = 8.0f;
    self.rightNextButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.rightNextButton.layer.borderWidth = 0.5f;

    [self.leftButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
    [self.rightButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateSelected];
    self.leftButton.selected = YES;

    [self.leftPwdField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.leftSSidField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.leftWifField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.rightPwdField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftClick:(id)sender
{
    self.leftButton.selected = YES;
    self.rightButton.selected = NO;
    self.leftView.hidden = NO;
    self.rightView.hidden = YES;
}

- (IBAction)rightClick:(id)sender
{
    self.leftButton.selected = NO;
    self.rightButton.selected = YES;
    self.leftView.hidden = YES;
    self.rightView.hidden = NO;
}

- (IBAction)leftNextClick:(id)sender
{
    NSString *string = [NSString stringWithFormat:kConfigDeviceCmd,self.leftSSidField.text, self.leftWifField.text];
    NSString *requset = [NSString stringWithFormat:kNeedPINString,self.deviceID,self.leftPwdField.text,kAppDelegate.userName,@(kAppDelegate.globleNumber),string];
    [[FYUDPNetWork shareNetEngine] sendRequest:requset complete:^(BOOL finish, NSString *responseString) {

    }];
}

- (IBAction)rightNextClick:(id)sender
{
    NSString *request = [NSString stringWithFormat:kDeleteDeviceCmd,self.deviceID, self.rightPwdField.text, kAppDelegate.userName];
    [[FYTCPNetWork shareNetEngine] sendRequest:request complete:^(NSDictionary *dic) {

    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}
@end
