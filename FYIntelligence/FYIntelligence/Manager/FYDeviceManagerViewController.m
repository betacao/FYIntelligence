//
//  FYDeviceManagerViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/12.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYDeviceManagerViewController.h"
#import "FYParamSettingViewController.h"

@interface FYDeviceManagerViewController ()
@property (weak, nonatomic) IBOutlet UIButton *paramButton;
@property (weak, nonatomic) IBOutlet UIButton *userAddButton;
@property (weak, nonatomic) IBOutlet UIButton *userWarmButton;
@property (weak, nonatomic) IBOutlet UIButton *temCircleButton;
@property (weak, nonatomic) IBOutlet UIButton *waterCircleButton;

@end

@implementation FYDeviceManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"飞羽智能";

    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = [UIImage imageNamed:@"right_about"];
    [rightButton setImage:normalImage forState:UIControlStateNormal];
    [rightButton sizeToFit];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

    self.paramButton.layer.masksToBounds = YES;
    self.paramButton.layer.cornerRadius = 2.0f;

    self.userAddButton.layer.masksToBounds = YES;
    self.userAddButton.layer.cornerRadius = 2.0f;

    self.userWarmButton.layer.masksToBounds = YES;
    self.userWarmButton.layer.cornerRadius = 2.0f;

    self.temCircleButton.layer.masksToBounds = YES;
    self.temCircleButton.layer.cornerRadius = 2.0f;

    self.waterCircleButton.layer.masksToBounds = YES;
    self.waterCircleButton.layer.cornerRadius = 2.0f;
}

- (void)backButtonClick:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickParamButton:(UIButton *)button
{
    FYParamSettingViewController *controller = [[FYParamSettingViewController alloc] initWithNibName:@"FYParamSettingViewController" bundle:nil];
    FYBaseNavigationViewController *nav = [[FYBaseNavigationViewController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
