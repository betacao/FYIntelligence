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

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

}

- (void)keyboardDidShow:(NSNotification *)notif
{
    [UIView animateWithDuration:0.25f animations:^{
        CGRect frame = self.bgView.frame;
        frame.origin.y = 50.0f;
        self.bgView.frame = frame;
    }];
}

- (void)keyboardDidHide:(NSNotification *)notif
{
    CGRect frame = self.bgView.frame;
    frame.origin.y = 100.0f;
    self.bgView.frame = frame;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    kAppDelegate.pinCode = [self.leftPwdField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *responseString = [[FYUDPNetWork sharedNetWork] sendMessage:string type:1];
        if ([responseString containsString:@"SUCCESS"]) {
            [FYProgressHUD showMessageWithText:@"设置成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeSelf];
            });
        }
    });
}

- (IBAction)rightNextClick:(id)sender
{
    NSString *request = [NSString stringWithFormat:kDeleteDeviceCmd,self.deviceID, self.rightPwdField.text, kAppDelegate.userID];
    [[FYTCPNetWork shareNetEngine] sendRequest:request complete:^(NSDictionary *dic) {
        [FYProgressHUD showMessageWithText:@"设置成功"];
        [self performSelector:@selector(removeSelf) withObject:nil afterDelay:0.1f];
        if (self.delegate && [self.delegate respondsToSelector:@selector(didDeleteDevice:)]) {
            [self.delegate didDeleteDevice:self.deviceID];
        }
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self removeSelf];
}

- (void)removeSelf
{
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
