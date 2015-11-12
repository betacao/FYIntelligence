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
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
@property (weak, nonatomic) IBOutlet UIButton *fourthButton;
@property (strong, nonatomic) UIImage *image0;
@property (strong, nonatomic) UIImage *image1;
@property (strong, nonatomic) UIImage *image2;
@property (strong, nonatomic) UIImage *image3;
@property (strong, nonatomic) UIImage *image4;
@property (strong, nonatomic) UIImage *image5;
@property (strong, nonatomic) UIImage *image6;
@property (strong, nonatomic) UIImage *image7;
@property (strong, nonatomic) UIImage *image8;
@property (strong, nonatomic) UIImage *image9;
@property (strong, nonatomic) UIImage *image10;
@property (strong, nonatomic) UIImage *image11;
@property (strong, nonatomic) UIImage *image12;
@property (strong, nonatomic) UIImage *image13;



@end

@implementation FYDeviceManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"飞羽智能";
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = [UIImage imageNamed:@"right_about"];
    [rightButton setImage:normalImage forState:UIControlStateNormal];
    [rightButton sizeToFit];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

    self.paramButton.layer.masksToBounds = YES;
    self.paramButton.layer.cornerRadius = 2.0f;
    [self.paramButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"DEB887"]]forState:UIControlStateNormal];
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getInfo];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.mainImageView.image = self.image0;
    [[FYUDPNetWork shareNetEngine] stopMainData];
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

- (UIImage *)image0
{
    if (!_image0) {
        _image0 = [UIImage imageNamed:@"aaction_gdhs_hx0"];
    }
    return _image0;
}
- (UIImage *)image1
{
    if (!_image1) {
        _image1 = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"aaction_gdhs_hx0"], [UIImage imageNamed:@"aaction_gdhs_hx1"], [UIImage imageNamed:@"aaction_gdhs_hx4"], [UIImage imageNamed:@"aaction_gdhs_hx8"], [UIImage imageNamed:@"aaction_gdhs_hx12"]] duration:4.0f];
    }
    return _image1;
}
- (UIImage *)image2
{
    if (!_image2) {
        _image2 = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"aaction_wcxh_hx0"], [UIImage imageNamed:@"aaction_wcxh_hx5"], [UIImage imageNamed:@"aaction_wcxh_hx10"], [UIImage imageNamed:@"aaction_wcxh_hx15"], [UIImage imageNamed:@"aaction_wcxh_hx20"], [UIImage imageNamed:@"aaction_wcxh_hx25"]] duration:4.0f];
    }
    return _image2;
}
- (UIImage *)image3
{
    if (!_image3) {
        _image3 = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"aaction_wcxh_hs0"], [UIImage imageNamed:@"aaction_wcxh_hs1"], [UIImage imageNamed:@"aaction_wcxh_hs2"], [UIImage imageNamed:@"aaction_wcxh_hs3"]] duration:4.0f];
    }
    return _image3;
}
- (UIImage *)image4
{
    if (!_image4) {
        _image4 = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"aaction_jiare_hx0"], [UIImage imageNamed:@"aaction_jiare_hx1"], [UIImage imageNamed:@"aaction_jiare_hx2"], [UIImage imageNamed:@"aaction_jiare_hx3"], [UIImage imageNamed:@"aaction_jiare_hx4"], [UIImage imageNamed:@"aaction_jiare_hx5"]] duration:4.0f];
    }
    return _image4;
}
- (UIImage *)image5
{
    if (!_image5) {
        _image5 = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"aaction_jiare_hs0"], [UIImage imageNamed:@"aaction_jiare_hs1"], [UIImage imageNamed:@"aaction_jiare_hs2"], [UIImage imageNamed:@"aaction_jiare_hs3"]] duration:4.0f];
    }
    return _image5;
}
- (UIImage *)image6
{
    if (!_image6) {

    }
    return _image6;
}
- (UIImage *)image7
{
    if (!_image7) {
        _image7 = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"aaction_jiare_hs_wcxh0"], [UIImage imageNamed:@"aaction_jiare_hs_wcxh1"], [UIImage imageNamed:@"aaction_jiare_hs_wcxh2"], [UIImage imageNamed:@"aaction_jiare_hs_wcxh3"]] duration:4.0f];
    }
    return _image7;
}
- (UIImage *)image8
{
    if (!_image8) {
        _image8 = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"aaction_ss_hx0"], [UIImage imageNamed:@"aaction_ss_hx1"], [UIImage imageNamed:@"aaction_ss_hx2"], [UIImage imageNamed:@"aaction_ss_hx3"], [UIImage imageNamed:@"aaction_ss_hx4"], [UIImage imageNamed:@"aaction_ss_hx5"], [UIImage imageNamed:@"aaction_ss_hx6"]] duration:4.0f];
    }
    return _image8;
}
- (UIImage *)image9
{
    if (!_image9) {
        _image9 = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"aaction_ss_hs0"], [UIImage imageNamed:@"aaction_ss_hs1"], [UIImage imageNamed:@"aaction_ss_hs2"], [UIImage imageNamed:@"aaction_ss_hs3"]] duration:4.0f];
    }
    return _image9;
}
- (UIImage *)image10
{
    if (!_image10) {

    }
    return _image10;
}
- (UIImage *)image11
{
    if (!_image11) {

    }
    return _image11;
}
- (UIImage *)image12
{
    if (!_image12) {
        _image12 = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"aaction_jiare_ss0"], [UIImage imageNamed:@"aaction_jiare_ss1"], [UIImage imageNamed:@"aaction_jiare_ss2"], [UIImage imageNamed:@"aaction_jiare_ss3"]] duration:4.0f];
    }
    return _image12;
}
- (UIImage *)image13
{
    if (!_image13) {
        _image13 = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"aaction_jiare_hs_ss0"], [UIImage imageNamed:@"aaction_jiare_hs_ss1"], [UIImage imageNamed:@"aaction_jiare_hs_ss2"], [UIImage imageNamed:@"aaction_jiare_hs_ss3"]] duration:4.0f];
    }
    return _image13;
}

- (void)getInfo
{
    [[FYUDPNetWork shareNetEngine] requestMainData:^(BOOL finish, NSString *responseString) {
        if(finish){
            NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern: @"\\w+" options:0 error:nil];
            NSMutableArray *results = [NSMutableArray array];
            [regularExpression enumerateMatchesInString:responseString options:0 range:NSMakeRange(0, responseString.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
                [results addObject:result];
            }];
            NSComparator cmptr = ^(NSTextCheckingResult *obj1, NSTextCheckingResult *obj2){
                if (obj1.range.location > obj2.range.location) {
                    return (NSComparisonResult)NSOrderedDescending;
                } else if (obj1.range.location < obj2.range.location) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedSame;
            };
            NSArray *MResult = [results sortedArrayUsingComparator:cmptr];
            NSString *value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:0]).range];
            [self changeImage:[value integerValue]];
            value = [[responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:1]).range] stringByAppendingString:@"°C"];
            [self.firstButton setTitle:value forState:UIControlStateNormal];
            value = [[responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:2]).range] stringByAppendingString:@"°C"];
            [self.secondButton setTitle:value forState:UIControlStateNormal];
            value = [[responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:3]).range] stringByAppendingString:@"°C"];
            [self.thirdButton setTitle:value forState:UIControlStateNormal];
            value = [[responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:4]).range] stringByAppendingString:@"°C"];;
            [self.fourthButton setTitle:value forState:UIControlStateNormal];

        }
    }];
}

- (void)changeImage:(NSInteger)number
{
    switch (number) {
        case 0:
        {
            self.mainImageView.image = self.image0;
        }
            break;
        case 1:
        {
            self.mainImageView.image = self.image1;
        }
            break;
        case 2:
        {
            self.mainImageView.image = self.image2;
        }
            break;
        case 3:
        {
            self.mainImageView.image = self.image3;
        }
            break;
        case 4:
        {
            self.mainImageView.image = self.image4;
        }
            break;
        case 5:
        {
            self.mainImageView.image = self.image5;
        }
            break;
        case 6:
        {
            self.mainImageView.image = self.image6;
        }
            break;
        case 7:
        {
            self.mainImageView.image = self.image7;
        }
            break;
        case 8:
        {
            self.mainImageView.image = self.image8;
        }
            break;
        case 9:
        {
            self.mainImageView.image = self.image9;
        }
            break;
        case 10:
        {
            self.mainImageView.image = self.image10;
        }
            break;
        case 11:
        {
            self.mainImageView.image = self.image11;
        }
            break;
        case 12:
        {
            self.mainImageView.image = self.image12;
        }
            break;

        default:
        {
            self.mainImageView.image = self.image13;
        }
            break;
    }
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
    NSString *globleString = [NSString stringWithFormat:@"%ld",(long)kAppDelegate.globleNumber];
    NSString *request = [NSString stringWithFormat:kNoPINString,kAppDelegate.deviceID,kAppDelegate.userName,globleString,@"cmd_sdss"];
    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        if(finish){

        } else{
            NSString *requset = [NSString stringWithFormat:kNoPINClearCmd,kAppDelegate.deviceID,kAppDelegate.userName];
            [[FYTCPNetWork shareNetEngine] sendRequest:requset complete:^(NSDictionary *dic) {

            }];
        }
    }];
    
    
}

- (IBAction)clickUserWarm:(UIButton *)sender
{
    //手动加热
    NSString *globleString = [NSString stringWithFormat:@"%ld",(long)kAppDelegate.globleNumber];
    NSString *request = [NSString stringWithFormat:kNoPINString,kAppDelegate.deviceID,kAppDelegate.userName,globleString,@"cmd_sdjr"];
    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        if(finish){

        } else{
            NSString *requset = [NSString stringWithFormat:kNoPINClearCmd,kAppDelegate.deviceID,kAppDelegate.userName];
            [[FYTCPNetWork shareNetEngine] sendRequest:requset complete:^(NSDictionary *dic) {

            }];
        }
    }];
}

- (IBAction)clickTemCircle:(UIButton *)sender
{
    //温差循环
    NSString *globleString = [NSString stringWithFormat:@"%ld",(long)kAppDelegate.globleNumber];
    NSString *request = [NSString stringWithFormat:kNoPINString,kAppDelegate.deviceID,kAppDelegate.userName,globleString,@"cmd_wcxh"];
    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        if(finish){

        } else{
            NSString *requset = [NSString stringWithFormat:kNoPINClearCmd,kAppDelegate.deviceID,kAppDelegate.userName];
            [[FYTCPNetWork shareNetEngine] sendRequest:requset complete:^(NSDictionary *dic) {

            }];
        }
    }];
}

- (IBAction)clickWaterCircle:(UIButton *)sender
{
    //管道回水
    NSString *globleString = [NSString stringWithFormat:@"%ld",(long)kAppDelegate.globleNumber];
    NSString *request = [NSString stringWithFormat:kNoPINString,kAppDelegate.deviceID,kAppDelegate.userName,globleString,@"cmd_gdhs"];
    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        if(finish){

        } else{
            NSString *requset = [NSString stringWithFormat:kNoPINClearCmd,kAppDelegate.deviceID,kAppDelegate.userName];
            [[FYTCPNetWork shareNetEngine] sendRequest:requset complete:^(NSDictionary *dic) {

            }];
        }

    }];
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
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
