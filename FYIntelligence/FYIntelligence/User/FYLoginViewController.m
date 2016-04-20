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
#import "FYForgrtPWDViewController.h"
#import "APService.h"

@interface FYLoginViewController ()
@property (weak, nonatomic) IBOutlet UIView *inputBgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *rememberPwdButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *fogetButton;

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

    [self.rememberPwdButton setEnlargeEdge:30.0f];

    UIImage *normalImage = [UIImage imageNamed:@"btn_login_normal"];
    UIImage *pressImage = [UIImage imageNamed:@"btn_login_press"];
    [self.loginButton setBackgroundImage:[normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[pressImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];
    BOOL isRememberUser = [[NSUserDefaults standardUserDefaults] boolForKey:kRememberUserName];
    if(isRememberUser){
        kAppDelegate.isRemember = YES;
        [self.rememberPwdButton setImage:[UIImage imageNamed:@"selectButton"] forState:UIControlStateNormal];
    } else{
        kAppDelegate.isRemember = NO;
        [self.rememberPwdButton setImage:[UIImage imageNamed:@"blankButton"] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kUserName];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kPassWord];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    kAppDelegate.userID = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
    self.userField.text = kAppDelegate.userID;
    NSString *pwd = [[NSUserDefaults standardUserDefaults] objectForKey:kPassWord];
    self.pwdField.text = pwd;
    kAppDelegate.userPWD = pwd;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)backButtonClick:(UIButton *)button
{
    [self dismissViewControllerAnimated:NO completion:^{
        exit(0);
    }];
}

- (IBAction)clickRememberButton:(UIButton *)sender {
    kAppDelegate.isRemember = !kAppDelegate.isRemember;
    if(kAppDelegate.isRemember){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kRememberUserName];
        [self.rememberPwdButton setImage:[UIImage imageNamed:@"selectButton"] forState:UIControlStateNormal];
    } else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kRememberUserName];
        [self.rememberPwdButton setImage:[UIImage imageNamed:@"blankButton"] forState:UIControlStateNormal];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)clickLoginButton:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    NSString *userName = self.userField.text;
    NSString *pwd = self.pwdField.text;
    if(userName.length == 0){
        return;
    }
    if(pwd.length == 0){
        return;
    }
    kAppDelegate.userID = userName;
    kAppDelegate.userPWD = pwd;
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:kUserName];
    [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:kPassWord];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[FYTCPNetWork shareNetEngine] sendRequest:[NSString stringWithFormat:@"%@%@#%@#",kLoginAddress,userName,pwd] complete:^(NSDictionary *dic) {
        NSString *string = [dic objectForKey:kResponseString];
        if([string rangeOfString:@"SUCCESS"].location != NSNotFound){
            FYListViewController *controller = [[FYListViewController alloc] initWithNibName:@"FYListViewController" bundle:nil];
            if(controller){
                [weakSelf.navigationController pushViewController:controller animated:YES];
            }
            [APService setAlias:userName callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
        } else{
            [FYProgressHUD showMessageWithText:@"登录失败"];
        }
    }];
}

- (IBAction)clickRegisterButton:(id)sender {
    FYRegisterViewController *controller = [[FYRegisterViewController alloc] initWithNibName:@"FYRegisterViewController" bundle:nil];
    if(controller){
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (IBAction)clickForgetButton:(id)sender {
    FYForgrtPWDViewController *controller = [[FYForgrtPWDViewController alloc] initWithNibName:@"FYForgrtPWDViewController" bundle:nil];
    if(controller){
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =
    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
     [self logSet:tags], alias];
    NSLog(@"TagsAlias回调:%@", callbackString);
}

- (NSString *)logSet:(NSSet *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
