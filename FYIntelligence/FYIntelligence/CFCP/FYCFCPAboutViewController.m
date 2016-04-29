//
//  FYCFCPAbooutViewController.m
//  FYIntelligence
//
//  Created by changxicao on 16/4/21.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "FYCFCPAboutViewController.h"
#import "FYCFCPSettingViewController.h"
#import "FYEnterPINViewController.h"

@interface FYCFCPAboutViewController ()<FYEnterPINDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *webField;
@property (weak, nonatomic) IBOutlet UITextField *versionField;
@property (weak, nonatomic) IBOutlet UITextField *settingField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation FYCFCPAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.imageView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);

    self.phoneField.sd_layout
    .leftSpaceToView(self.view, MarginFactor(36.0f))
    .topSpaceToView(self.view, MarginFactor(225.0f))
    .widthIs(MarginFactor(300.0f))
    .heightIs(MarginFactor(30.0f));

    self.webField.sd_layout
    .leftEqualToView(self.phoneField)
    .topSpaceToView(self.phoneField, MarginFactor(32.0f))
    .widthIs(MarginFactor(300.0f))
    .heightIs(MarginFactor(30.0f));

    self.versionField.sd_layout
    .leftEqualToView(self.phoneField)
    .topSpaceToView(self.webField, MarginFactor(32.0f))
    .widthIs(MarginFactor(300.0f))
    .heightIs(MarginFactor(30.0f));

    self.settingField.sd_layout
    .leftEqualToView(self.phoneField)
    .topSpaceToView(self.versionField, MarginFactor(32.0f))
    .widthIs(MarginFactor(300.0f))
    .heightIs(MarginFactor(30.0f));

    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0f, MarginFactor(120.0f), MarginFactor(30.0f))];
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0f, MarginFactor(120.0f), MarginFactor(30.0f))];
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0f, MarginFactor(120.0f), MarginFactor(30.0f))];
    UIView *leftView4 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0f, MarginFactor(120.0f), MarginFactor(30.0f))];
    self.phoneField.leftView = leftView1;
    self.webField.leftView = leftView2;
    self.versionField.leftView = leftView3;
    self.settingField.leftView = leftView4;
    self.phoneField.leftViewMode = UITextFieldViewModeAlways;
    self.webField.leftViewMode = UITextFieldViewModeAlways;
    self.versionField.leftViewMode = UITextFieldViewModeAlways;
    self.settingField.leftViewMode = UITextFieldViewModeAlways;

    self.phoneField.font = self.webField.font = self.versionField.font = self.settingField.font = BoldFontFactor(15.0f);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.settingField]) {

        FYEnterPINViewController *controller = [[FYEnterPINViewController alloc] initWithNibName:@"FYEnterPINViewController" bundle:nil];
        controller.delegate = self;
        [self.parentViewController addChildViewController:controller];
        [self.parentViewController.view addSubview:controller.view];
    } else if ([textField isEqual:self.phoneField]) {

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4006686046"]];

    } else if ([textField isEqual:self.webField]) {

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.rc2004.com"]];
    }
    return NO;
}



- (void)didEnterAllPIN:(NSString *)pinNumber index:(NSInteger)index
{
    kAppDelegate.pinCode = pinNumber;

    FYCFCPSettingViewController *controller = [[FYCFCPSettingViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
