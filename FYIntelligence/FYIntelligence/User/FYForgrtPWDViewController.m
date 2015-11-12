//
//  FYForgrtPWDViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/17.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYForgrtPWDViewController.h"

@interface FYForgrtPWDViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userField;
@end

@implementation FYForgrtPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(id)sender
{
    if (self.userField.text.length == 0) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    NSString *request = [NSString stringWithFormat:kResetPwdCmd,self.userField.text];
    [[FYTCPNetWork shareNetEngine] sendRequest:request complete:^(NSDictionary *dic) {
        if ([[dic objectForKey:kResponseString] rangeOfString:@"SUCCESS"].location != NSNotFound) {
            [FYProgressHUD showMessageWithText:@"短信发送成功"];
            [weakSelf.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@(YES) afterDelay:1.2f];
        } else{
            [FYProgressHUD showMessageWithText:@"短信发送失败"];
        }
    }];
}
@end
