//
//  FYDeviceManagerViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/12.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYDeviceManagerViewController.h"
#import "FYParamSettingViewController.h"
#import "FYAboutViewController.h"

@interface FYDeviceManagerViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@property (weak, nonatomic) IBOutlet UIButton *paramButton;
@property (weak, nonatomic) IBOutlet UIButton *userAddButton;
@property (weak, nonatomic) IBOutlet UIButton *userWarmButton;
@property (weak, nonatomic) IBOutlet UIButton *temCircleButton;
@property (weak, nonatomic) IBOutlet UIButton *waterCircleButton;
@property (strong, nonatomic) NSString *userName;

@end

@implementation FYDeviceManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"飞羽智能";
    self.userName = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = [UIImage imageNamed:@"right_about"];
    [rightButton setImage:normalImage forState:UIControlStateNormal];
    [rightButton sizeToFit];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

    self.paramButton.layer.masksToBounds = YES;
    self.paramButton.layer.cornerRadius = 2.0f;
    [self.paramButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"F0E68C"]]forState:UIControlStateNormal];
    [self.paramButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]forState:UIControlStateHighlighted];

    self.userAddButton.layer.masksToBounds = YES;
    self.userAddButton.layer.cornerRadius = 2.0f;
    [self.userAddButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"8C7EEB"]]forState:UIControlStateNormal];
    [self.userAddButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]forState:UIControlStateHighlighted];

    self.userWarmButton.layer.masksToBounds = YES;
    self.userWarmButton.layer.cornerRadius = 2.0f;
    [self.userWarmButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"FF4500"]]forState:UIControlStateNormal];
    [self.userWarmButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]forState:UIControlStateHighlighted];

    self.temCircleButton.layer.masksToBounds = YES;
    self.temCircleButton.layer.cornerRadius = 2.0f;
    [self.temCircleButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"C0C0C0"]]forState:UIControlStateNormal];
    [self.temCircleButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]forState:UIControlStateHighlighted];

    self.waterCircleButton.layer.masksToBounds = YES;
    self.waterCircleButton.layer.cornerRadius = 2.0f;
    [self.waterCircleButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"8FBC8F"]]forState:UIControlStateNormal];
    [self.waterCircleButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]forState:UIControlStateHighlighted];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.mainImageView.image = [UIImage imageNamed:@"mainShow"];
}

- (void)backButtonClick:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightButtonClick:(UIButton *)button
{
    FYAboutViewController *controller = [[FYAboutViewController alloc] initWithNibName:@"FYAboutViewController" bundle:nil];
    FYBaseNavigationViewController *nav = [[FYBaseNavigationViewController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)clickParamButton:(UIButton *)button
{
    FYParamSettingViewController *controller = [[FYParamSettingViewController alloc] initWithNibName:@"FYParamSettingViewController" bundle:nil];
    FYBaseNavigationViewController *nav = [[FYBaseNavigationViewController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)clickAddWater:(UIButton *)sender
{
    //手动上水
    UIImage *image0 = [UIImage imageNamed:@"aaction_ss_hx0"];
    UIImage *image1 = [UIImage imageNamed:@"aaction_ss_hx1"];
    UIImage *image2 = [UIImage imageNamed:@"aaction_ss_hx2"];
    UIImage *image3 = [UIImage imageNamed:@"aaction_ss_hx3"];
    UIImage *image4 = [UIImage imageNamed:@"aaction_ss_hx4"];
    UIImage *image5 = [UIImage imageNamed:@"aaction_ss_hx5"];
    UIImage *image6 = [UIImage imageNamed:@"aaction_ss_hx6"];
    UIImage *image = [UIImage animatedImageWithImages:@[image0, image1, image2, image3, image4, image5, image6] duration:6.0f];
    self.mainImageView.image = image;
    NSString *globleString = [NSString stringWithFormat:@"%ld",(long)kAppDelegate.globleNumber];
    NSString *request = [NSString stringWithFormat:kNoPINString,self.deviceID,self.userName,globleString,@"cmd_sdss"];
    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        if(finish){

        } else{
            NSString *requset = [NSString stringWithFormat:kNoPINClearCmd,self.deviceID,self.userName];
            [[FYTCPNetWork shareNetEngine] sendRequest:requset complete:^(NSDictionary *dic) {

            }];
        }
    }];
    
    
}

- (IBAction)clickUserWarm:(UIButton *)sender
{
    //手动加热
    UIImage *image0 = [UIImage imageNamed:@"aaction_jiare_hx0"];
    UIImage *image1 = [UIImage imageNamed:@"aaction_jiare_hx1"];
    UIImage *image2 = [UIImage imageNamed:@"aaction_jiare_hx2"];
    UIImage *image3 = [UIImage imageNamed:@"aaction_jiare_hx3"];
    UIImage *image4 = [UIImage imageNamed:@"aaction_jiare_hx4"];
    UIImage *image5 = [UIImage imageNamed:@"aaction_jiare_hx5"];
    UIImage *image = [UIImage animatedImageWithImages:@[image0, image1, image2, image3, image4, image5] duration:6.0f];
    self.mainImageView.image = image;
    NSString *globleString = [NSString stringWithFormat:@"%ld",(long)kAppDelegate.globleNumber];
    NSString *request = [NSString stringWithFormat:kNoPINString,self.deviceID,self.userName,globleString,@"cmd_sdjr"];
    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        if(finish){

        } else{
            NSString *requset = [NSString stringWithFormat:kNoPINClearCmd,self.deviceID,self.userName];
            [[FYTCPNetWork shareNetEngine] sendRequest:requset complete:^(NSDictionary *dic) {

            }];
        }
    }];
}

- (IBAction)clickTemCircle:(UIButton *)sender
{
    //温差循环
    UIImage *image0 = [UIImage imageNamed:@"aaction_wcxh_hx0"];
    UIImage *image1 = [UIImage imageNamed:@"aaction_wcxh_hx5"];
    UIImage *image2 = [UIImage imageNamed:@"aaction_wcxh_hx10"];
    UIImage *image3 = [UIImage imageNamed:@"aaction_wcxh_hx15"];
    UIImage *image4 = [UIImage imageNamed:@"aaction_wcxh_hx20"];
    UIImage *image5 = [UIImage imageNamed:@"aaction_wcxh_hx25"];
    UIImage *image = [UIImage animatedImageWithImages:@[image0, image1, image2, image3, image4, image5] duration:6.0f];
    self.mainImageView.image = image;
    NSString *globleString = [NSString stringWithFormat:@"%ld",(long)kAppDelegate.globleNumber];
    NSString *request = [NSString stringWithFormat:kNoPINString,self.deviceID,self.userName,globleString,@"cmd_wcxh"];
    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        if(finish){

        } else{
            NSString *requset = [NSString stringWithFormat:kNoPINClearCmd,self.deviceID,self.userName];
            [[FYTCPNetWork shareNetEngine] sendRequest:requset complete:^(NSDictionary *dic) {

            }];
        }
    }];
}

- (IBAction)clickWaterCircle:(UIButton *)sender
{
    //管道回水
    UIImage *image0 = [UIImage imageNamed:@"aaction_gdhs_hx0"];
    UIImage *image1 = [UIImage imageNamed:@"aaction_gdhs_hx1"];
    UIImage *image2 = [UIImage imageNamed:@"aaction_gdhs_hx4"];
    UIImage *image3 = [UIImage imageNamed:@"aaction_gdhs_hx8"];
    UIImage *image4 = [UIImage imageNamed:@"aaction_gdhs_hx12"];
    UIImage *image = [UIImage animatedImageWithImages:@[image0, image1, image2, image3, image4] duration:6.0f];
    self.mainImageView.image = image;
    NSString *globleString = [NSString stringWithFormat:@"%ld",(long)kAppDelegate.globleNumber];
    NSString *request = [NSString stringWithFormat:kNoPINString,self.deviceID,self.userName,globleString,@"cmd_gdhs"];
    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        if(finish){

        } else{
            NSString *requset = [NSString stringWithFormat:kNoPINClearCmd,self.deviceID,self.userName];
            [[FYTCPNetWork shareNetEngine] sendRequest:requset complete:^(NSDictionary *dic) {

            }];
        }

    }];
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
