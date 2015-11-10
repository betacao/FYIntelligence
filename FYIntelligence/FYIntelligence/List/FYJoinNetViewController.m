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
#import "ESP_NetUtil.h"
#import "ESPTouchDelegate.h"

#define HEIGHT_KEYBOARD 216
#define HEIGHT_TEXT_FIELD 30
#define HEIGHT_SPACE (6+HEIGHT_TEXT_FIELD)


@interface EspTouchDelegateImpl : NSObject<ESPTouchDelegate>

@end

@implementation EspTouchDelegateImpl

-(void) dismissAlert:(UIAlertView *)alertView
{
    [alertView dismissWithClickedButtonIndex:[alertView cancelButtonIndex] animated:YES];
}

-(void) showAlertWithResult: (ESPTouchResult *) result
{
    NSString *title = nil;
    NSString *message = [NSString stringWithFormat:@"%@ is connected to the wifi" , result.bssid];
    NSTimeInterval dismissSeconds = 3.5;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alertView show];
    [self performSelector:@selector(dismissAlert:) withObject:alertView afterDelay:dismissSeconds];
}

-(void) onEsptouchResultAddedWithResult: (ESPTouchResult *) result
{
    NSLog(@"EspTouchDelegateImpl onEsptouchResultAddedWithResult bssid: %@", result.bssid);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showAlertWithResult:result];
    });
}

@end



@interface FYJoinNetViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *inputBgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (atomic, strong) ESPTouchTask *esptouchTask;
@property (nonatomic, assign) BOOL isConfirmState;
@property (nonatomic, strong) NSCondition *condition;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) EspTouchDelegateImpl *esptouchDelegate;

@end

@implementation FYJoinNetViewController


- (IBAction)tapConfirmCancelBtn:(UIButton *)sender
{
    [self tapConfirmForResults];
}

- (void) tapConfirmForResults
{
    // do confirm
    if (self.isConfirmState)
    {
        [FYProgressHUD showLoadingWithMessage:@"请稍等..."];
        [self enableCancelBtn];
        NSLog(@"ESPViewController do confirm action...");
        dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            NSLog(@"ESPViewController do the execute work...");
            // execute the task
            NSArray *esptouchResultArray = [self executeForResults];
            // show the result to the user in UI Main Thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [FYProgressHUD hideHud];
                [self enableConfirmBtn];

                ESPTouchResult *firstResult = [esptouchResultArray objectAtIndex:0];
                // check whether the task is cancelled and no results received
                if (!firstResult.isCancelled)
                {
                    NSMutableString *mutableStr = [[NSMutableString alloc]init];
                    NSUInteger count = 0;
                    // max results to be displayed, if it is more than maxDisplayCount,
                    // just show the count of redundant ones
                    const int maxDisplayCount = 5;
                    if ([firstResult isSuc])
                    {

                        for (int i = 0; i < [esptouchResultArray count]; ++i)
                        {
                            ESPTouchResult *resultInArray = [esptouchResultArray objectAtIndex:i];
                            [mutableStr appendString:[resultInArray description]];
                            [mutableStr appendString:@"\n"];
                            count++;
                            if (count >= maxDisplayCount)
                            {
                                break;
                            }
                        }

                        if (count < [esptouchResultArray count])
                        {
                            [mutableStr appendString:[NSString stringWithFormat:@"\nthere's %lu more result(s) without showing\n",(unsigned long)([esptouchResultArray count] - count)]];
                        }
                        [[[UIAlertView alloc]initWithTitle:@"Execute Result" message:mutableStr delegate:nil cancelButtonTitle:@"I know" otherButtonTitles:nil]show];
                    }

                    else
                    {
                        [[[UIAlertView alloc]initWithTitle:@"Execute Result" message:@"Esptouch fail" delegate:nil cancelButtonTitle:@"I know" otherButtonTitles:nil]show];
                    }
                }

            });
        });
    }
    // do cancel
    else
    {
        [FYProgressHUD hideHud];
        [self enableConfirmBtn];
        NSLog(@"ESPViewController do cancel action...");
        [self cancel];
    }
}

#pragma mark - the example of how to cancel the executing task

- (void) cancel
{
    [self.condition lock];
    if (self.esptouchTask != nil)
    {
        [self.esptouchTask interrupt];
    }
    [self.condition unlock];
}

#pragma mark - the example of how to use executeForResults
- (NSArray *) executeForResults
{
    [self.condition lock];
    NSString *apSsid = self.userField.text;
    NSString *apPwd = self.pwdField.text;
    NSString *apBssid = self.bssid;
    self.esptouchTask =
    [[ESPTouchTask alloc]initWithApSsid:apSsid andApBssid:apBssid andApPwd:apPwd andIsSsidHiden:NO];
    // set delegate
    [self.esptouchTask setEsptouchDelegate:self.esptouchDelegate];
    [self.condition unlock];
    NSArray * esptouchResults = [self.esptouchTask executeForResults:1];
    NSLog(@"ESPViewController executeForResult() result is: %@",esptouchResults);
    return esptouchResults;
}


#pragma mark - the example of how to use executeForResult

- (ESPTouchResult *) executeForResult
{
    [self.condition lock];
    NSString *apSsid = self.userField.text;
    NSString *apPwd = self.pwdField.text;
    NSString *apBssid = self.bssid;
    self.esptouchTask =
    [[ESPTouchTask alloc]initWithApSsid:apSsid andApBssid:apBssid andApPwd:apPwd andIsSsidHiden:NO];
    // set delegate
    [self.esptouchTask setEsptouchDelegate:self.esptouchDelegate];
    [self.condition unlock];
    ESPTouchResult * esptouchResult = [self.esptouchTask executeForResult];
    NSLog(@"ESPViewController executeForResult() result is: %@",esptouchResult);
    return esptouchResult;
}


// enable confirm button
- (void)enableConfirmBtn
{
    self.isConfirmState = YES;
    [self.loginButton setTitle:@"Confirm" forState:UIControlStateNormal];
}

// enable cancel button
- (void)enableCancelBtn
{
    self.isConfirmState = NO;
    [self.loginButton setTitle:@"Cancel" forState:UIControlStateNormal];
}


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
    self.pwdField.delegate = self;
    self.pwdField.keyboardType = UIKeyboardTypeASCIICapable;
    self.condition = [[NSCondition alloc]init];
    self.esptouchDelegate = [[EspTouchDelegateImpl alloc]init];
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
    NSString *ssid = [[dctySSID objectForKey:@"SSID"] uppercaseString];
    completion(ssid);
    
}


#pragma mark - the follow codes are just to make soft-keyboard disappear at necessary time

// when out of pwd textview, resign the keyboard
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.pwdField isExclusiveTouch])
    {
        [self.pwdField resignFirstResponder];
    }
}

#pragma mark -  the follow three methods are used to make soft-keyboard disappear when user finishing editing

// when textField begin editing, soft-keyboard apeear, do the callback
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y - (self.view.frame.size.height - (HEIGHT_KEYBOARD+HEIGHT_SPACE));

    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];

    if(offset > 0)
    {
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    }

    [UIView commitAnimations];
}

// when user tap Enter or Return, disappear the keyboard
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// when finish editing, make view restore origin state
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void) addButtonToKeyboard {
    // create custom button
    if (self.doneButton == nil) {
        self.doneButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 163, 106, 53)];
    }
    else {
        [self.doneButton setHidden:NO];
    }

    [self.doneButton addTarget:self action:@selector(doneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView* keyboard = nil;
    for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        // keyboard found, add the button
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2) {
            if([[keyboard description] hasPrefix:@"<UIPeripheralHost"] == YES)
                [keyboard addSubview:self.doneButton];
        } else {
            if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES)
                [keyboard addSubview:self.doneButton];
        }
    }
}

- (void) doneButtonClicked:(id)Sender {
    //Write your code whatever you want to do on done button tap
    //Removing keyboard or something else
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
