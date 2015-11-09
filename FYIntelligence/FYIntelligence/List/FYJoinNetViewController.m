//
//  FYJoinNetViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/11.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYJoinNetViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "ESPTouchTask.h"
#import "ESPTouchResult.h"
#define HEIGHT_KEYBOARD 216
#define HEIGHT_TEXT_FIELD 30
#define HEIGHT_SPACE (6+HEIGHT_TEXT_FIELD)

@interface FYJoinNetViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *inputBgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
// to cancel ESPTouchTask when
@property (atomic, strong) ESPTouchTask *esptouchTask;
// the state of the confirm/cancel button
@property (nonatomic, assign) BOOL isConfirmState;


@end

@implementation FYJoinNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备入网";

    self.inputBgView.layer.masksToBounds = YES;
    self.inputBgView.layer.cornerRadius = 2.0f;

    [self.userField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.pwdField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.pwdField.delegate = self;
    self.pwdField.keyboardType = UIKeyboardTypeASCIICapable;

    CGRect frame = self.lineView.frame;
    frame.size.height = 0.5f;
    self.lineView.frame = frame;

    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 2.0f;

    UIImage *normalImage = [UIImage imageNamed:@"btn_login_normal"];
    UIImage *pressImage = [UIImage imageNamed:@"btn_login_press"];
    [self.loginButton setBackgroundImage:[normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[pressImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];

    self.isConfirmState = NO;
    [self enableConfirmBtn];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakSelf getDeviceSSID:^(NSString *ssid) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.userField.text = ssid;
            });
        }];
    });
}

- (void)backButtonClick:(UIButton *)button
{
    NSArray *array = self.navigationController.viewControllers;
    UIViewController *controller = [array objectAtIndex:1];
    [self.navigationController popToViewController:controller animated:YES];
}
- (void)getDeviceSSID:(void(^)(NSString *ssid))completion
{
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) {
            break;
        }
    }
    NSDictionary *dctySSID = (NSDictionary *)info;
    NSString *ssid = [[dctySSID objectForKey:@"SSID"] lowercaseString];
    completion(ssid);
    
}

- (IBAction)confirm:(id)sender
{
    if (self.isConfirmState){
        [FYProgressHUD showLoadingWithMessage:@"请稍等..."];
        [self enableCancelBtn];
        NSLog(@"do confirm action...");
        dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            NSLog(@"do the execute work...");
            ESPTouchResult *esptouchResult = [self executeForResult];
            dispatch_async(dispatch_get_main_queue(), ^{
                [FYProgressHUD hideHud];
                [self enableConfirmBtn];
                if (!esptouchResult.isCancelled){
                    kAppDelegate.ESPDescription = [esptouchResult description];
                    [[[UIAlertView alloc] initWithTitle:@"Execute Result" message:[esptouchResult description] delegate:nil cancelButtonTitle:@"I know" otherButtonTitles: nil] show];
                }
            });
        });
    } else{
        [FYProgressHUD hideHud];
        [self enableConfirmBtn];
        NSLog(@"do cancel action...");
        [self cancel];
    }
}
- (void) cancel
{
    if (self.esptouchTask != nil){
        [self.esptouchTask interrupt];
    }
}



- (void)enableConfirmBtn
{
    self.isConfirmState = YES;
    [self.loginButton setTitle:@"确认" forState:UIControlStateNormal];
}

- (void)enableCancelBtn
{
    self.isConfirmState = NO;
    [self.loginButton setTitle:@"取消" forState:UIControlStateNormal];
}

- (BOOL) execute
{
    NSString *apSsid = self.userField.text;
    NSString *apPwd = self.pwdField.text;
    self.esptouchTask = [[ESPTouchTask alloc]initWithApSsid:apSsid andApPwd:apPwd];
    BOOL result = [self.esptouchTask execute];
    NSLog(@"execute() result is: %@",result?@"YES":@"NO");
    return result;
}

- (ESPTouchResult *) executeForResult
{
    NSString *apSsid = self.userField.text;
    NSString *apPwd = self.pwdField.text;
    self.esptouchTask = [[ESPTouchTask alloc]initWithApSsid:apSsid andApPwd:apPwd];
    ESPTouchResult * esptouchResult = [self.esptouchTask executeForResult];
    NSLog(@"executeForResult() result is: %@",esptouchResult);
    return esptouchResult;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.pwdField isExclusiveTouch]){
        [self.pwdField resignFirstResponder];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    NSInteger offset = frame.origin.y - (self.view.frame.size.height - (HEIGHT_KEYBOARD+HEIGHT_SPACE));
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    if(offset > 0){
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    }
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
