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

@property (weak, nonatomic) IBOutlet UIImageView *leftView;
@property (weak, nonatomic) IBOutlet UIImageView *middleView;
@property (weak, nonatomic) IBOutlet UIImageView *rightView;
@property (weak, nonatomic) IBOutlet UIButton *paramButton;
@property (weak, nonatomic) IBOutlet UIButton *userAddButton;
@property (weak, nonatomic) IBOutlet UIButton *userWarmButton;
@property (weak, nonatomic) IBOutlet UIButton *temCircleButton;
@property (weak, nonatomic) IBOutlet UIButton *waterCircleButton;
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
@property (weak, nonatomic) IBOutlet UIButton *fourthButton;
@property (strong, nonatomic) NSArray *array0;
@property (strong, nonatomic) NSArray *array1;
@property (strong, nonatomic) NSArray *array2;
@property (strong, nonatomic) NSArray *array3;
@property (strong, nonatomic) NSArray *array4;
@property (strong, nonatomic) NSArray *array5;
@property (strong, nonatomic) NSArray *array6;
@property (strong, nonatomic) NSArray *array7;
@property (strong, nonatomic) NSArray *array8;
@property (strong, nonatomic) NSArray *array9;
@property (strong, nonatomic) NSArray *array10;
@property (strong, nonatomic) NSArray *array11;
@property (strong, nonatomic) NSArray *array12;
@property (strong, nonatomic) NSArray *array13;



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
    self.leftView.image = [UIImage imageNamed:@"left"];
    self.middleView.image = [UIImage imageNamed:@"middle_100"];
    self.rightView.image = [UIImage imageNamed:@"right"];
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

- (NSArray *)array0
{
    if (!_array0) {
        _array0 = @[[UIImage imageNamed:@"left"],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"middle_100"], [UIImage imageNamed:@"middle_80"], [UIImage imageNamed:@"middle_50"], [UIImage imageNamed:@"middle_20"], [UIImage imageNamed:@"middle_00"]] duration:4.0f],
                    [UIImage imageNamed:@"right"]];
    }
    return _array0;
}
- (NSArray *)array1
{
    if (!_array1) {
        _array1 = @[[UIImage imageNamed:@"left"],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"middle_100"], [UIImage imageNamed:@"middle_80"], [UIImage imageNamed:@"middle_50"], [UIImage imageNamed:@"middle_20"], [UIImage imageNamed:@"middle_00"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"gdhs_hx1"], [UIImage imageNamed:@"gdhs_hx4"], [UIImage imageNamed:@"gdhs_hx8"], [UIImage imageNamed:@"gdhs_hx12"]] duration:4.0f]];
    }
    return _array1;
}
- (NSArray *)array2
{
    if (!_array2) {
        _array2 = @[[UIImage
                     animatedImageWithImages:@[[UIImage imageNamed:@"wcxh_hx0"], [UIImage imageNamed:@"wcxh_hx5"], [UIImage imageNamed:@"wcxh_hx10"], [UIImage imageNamed:@"wcxh_hx15"], [UIImage imageNamed:@"wcxh_hx20"], [UIImage imageNamed:@"wcxh_hx25"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"middle_100"], [UIImage imageNamed:@"middle_80"], [UIImage imageNamed:@"middle_50"], [UIImage imageNamed:@"middle_20"], [UIImage imageNamed:@"middle_00"]] duration:4.0f],
                    [UIImage imageNamed:@"right"]];
    }
    return _array2;
}
- (NSArray *)array4
{
    if (!_array4) {
        _array4 = @[[UIImage imageNamed:@"left"],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_middle_100"], [UIImage imageNamed:@"jiare_middle_80"], [UIImage imageNamed:@"jiare_middle_50"], [UIImage imageNamed:@"jiare_middle_20"], [UIImage imageNamed:@"jiare_middle_00"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_hx0"], [UIImage imageNamed:@"jiare_hx1"], [UIImage imageNamed:@"jiare_hx2"], [UIImage imageNamed:@"jiare_hx3"], [UIImage imageNamed:@"jiare_hx4"], [UIImage imageNamed:@"jiare_hx5"]] duration:4.0f]];
    }
    return _array4;
}
- (NSArray *)array8
{
    if (!_array8) {
        _array8 = @[[UIImage
                     animatedImageWithImages:@[[UIImage imageNamed:@"ss_hx0"], [UIImage imageNamed:@"ss_hx1"], [UIImage imageNamed:@"ss_hx2"], [UIImage imageNamed:@"ss_hx3"], [UIImage imageNamed:@"ss_hx4"], [UIImage imageNamed:@"ss_hx5"], [UIImage imageNamed:@"ss_hx6"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"middle_100"], [UIImage imageNamed:@"middle_80"], [UIImage imageNamed:@"middle_50"], [UIImage imageNamed:@"middle_20"], [UIImage imageNamed:@"middle_00"]] duration:4.0f],
                    [UIImage imageNamed:@"right"]];
    }
    return _array8;
}
- (NSArray *)array5
{
    if (!_array5) {
        _array5 = @[[UIImage imageNamed:@"left"],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_middle_100"], [UIImage imageNamed:@"jiare_middle_80"], [UIImage imageNamed:@"jiare_middle_50"], [UIImage imageNamed:@"jiare_middle_20"], [UIImage imageNamed:@"jiare_middle_00"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_hs0"], [UIImage imageNamed:@"jiare_hs1"], [UIImage imageNamed:@"jiare_hs2"], [UIImage imageNamed:@"jiare_hs3"]] duration:4.0f]];
    }
    return _array5;
}
- (NSArray *)array9
{
    if (!_array9) {
        _array9 = @[[UIImage
                     animatedImageWithImages:@[[UIImage imageNamed:@"ss_hx0"], [UIImage imageNamed:@"ss_hx1"], [UIImage imageNamed:@"ss_hx2"], [UIImage imageNamed:@"ss_hx3"], [UIImage imageNamed:@"ss_hx4"], [UIImage imageNamed:@"ss_hx5"], [UIImage imageNamed:@"ss_hx6"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"middle_100"], [UIImage imageNamed:@"middle_80"], [UIImage imageNamed:@"middle_50"], [UIImage imageNamed:@"middle_20"], [UIImage imageNamed:@"middle_00"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"gdhs_hx1"], [UIImage imageNamed:@"gdhs_hx4"], [UIImage imageNamed:@"gdhs_hx8"], [UIImage imageNamed:@"gdhs_hx12"]] duration:4.0f]];
    }
    return _array9;
}
- (NSArray *)array3
{
    if (!_array3) {
        _array3 = @[[UIImage
                     animatedImageWithImages:@[[UIImage imageNamed:@"wcxh_hx0"], [UIImage imageNamed:@"wcxh_hx5"], [UIImage imageNamed:@"wcxh_hx10"], [UIImage imageNamed:@"wcxh_hx15"], [UIImage imageNamed:@"wcxh_hx20"], [UIImage imageNamed:@"wcxh_hx25"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"middle_100"], [UIImage imageNamed:@"middle_80"], [UIImage imageNamed:@"middle_50"], [UIImage imageNamed:@"middle_20"], [UIImage imageNamed:@"middle_00"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"gdhs_hx1"], [UIImage imageNamed:@"gdhs_hx4"], [UIImage imageNamed:@"gdhs_hx8"], [UIImage imageNamed:@"gdhs_hx12"]] duration:4.0f]];
    }
    return _array3;
}
- (NSArray *)array6
{
    if (!_array6) {
        _array6 = @[[UIImage
                     animatedImageWithImages:@[[UIImage imageNamed:@"wcxh_hx0"], [UIImage imageNamed:@"wcxh_hx5"], [UIImage imageNamed:@"wcxh_hx10"], [UIImage imageNamed:@"wcxh_hx15"], [UIImage imageNamed:@"wcxh_hx20"], [UIImage imageNamed:@"wcxh_hx25"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_middle_100"], [UIImage imageNamed:@"jiare_middle_80"], [UIImage imageNamed:@"jiare_middle_50"], [UIImage imageNamed:@"jiare_middle_20"], [UIImage imageNamed:@"jiare_middle_00"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_hx0"], [UIImage imageNamed:@"jiare_hx1"], [UIImage imageNamed:@"jiare_hx2"], [UIImage imageNamed:@"jiare_hx3"], [UIImage imageNamed:@"jiare_hx4"], [UIImage imageNamed:@"jiare_hx5"]] duration:4.0f]];
    }
    return _array6;
}
- (NSArray *)array12
{
    if (!_array12) {
        _array12 = @[[UIImage
                      animatedImageWithImages:@[[UIImage imageNamed:@"ss_hx0"], [UIImage imageNamed:@"ss_hx1"], [UIImage imageNamed:@"ss_hx2"], [UIImage imageNamed:@"ss_hx3"], [UIImage imageNamed:@"ss_hx4"], [UIImage imageNamed:@"ss_hx5"], [UIImage imageNamed:@"ss_hx6"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_middle_100"], [UIImage imageNamed:@"jiare_middle_80"], [UIImage imageNamed:@"jiare_middle_50"], [UIImage imageNamed:@"jiare_middle_20"], [UIImage imageNamed:@"jiare_middle_00"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_hx0"], [UIImage imageNamed:@"jiare_hx1"], [UIImage imageNamed:@"jiare_hx2"], [UIImage imageNamed:@"jiare_hx3"], [UIImage imageNamed:@"jiare_hx4"], [UIImage imageNamed:@"jiare_hx5"]] duration:4.0f]];
    }
    return _array12;
}
- (NSArray *)array13
{
    if (!_array13) {
        _array13 = @[[UIImage
                      animatedImageWithImages:@[[UIImage imageNamed:@"ss_hx0"], [UIImage imageNamed:@"ss_hx1"], [UIImage imageNamed:@"ss_hx2"], [UIImage imageNamed:@"ss_hx3"], [UIImage imageNamed:@"ss_hx4"], [UIImage imageNamed:@"ss_hx5"], [UIImage imageNamed:@"ss_hx6"]] duration:4.0f],
                     [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_middle_100"], [UIImage imageNamed:@"jiare_middle_80"], [UIImage imageNamed:@"jiare_middle_50"], [UIImage imageNamed:@"jiare_middle_20"], [UIImage imageNamed:@"jiare_middle_00"]] duration:4.0f],
                     [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_hs0"], [UIImage imageNamed:@"jiare_hs1"], [UIImage imageNamed:@"jiare_hs2"], [UIImage imageNamed:@"jiare_hs3"]] duration:4.0f]];
    }
    return _array13;
}
- (NSArray *)array7
{
    if (!_array7) {
        _array7 = @[[UIImage
                     animatedImageWithImages:@[[UIImage imageNamed:@"wcxh_hx0"], [UIImage imageNamed:@"wcxh_hx5"], [UIImage imageNamed:@"wcxh_hx10"], [UIImage imageNamed:@"wcxh_hx15"], [UIImage imageNamed:@"wcxh_hx20"], [UIImage imageNamed:@"wcxh_hx25"]] duration:4.0f],
                     [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_middle_100"], [UIImage imageNamed:@"jiare_middle_80"], [UIImage imageNamed:@"jiare_middle_50"], [UIImage imageNamed:@"jiare_middle_20"], [UIImage imageNamed:@"jiare_middle_00"]] duration:4.0f],
                     [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_hs0"], [UIImage imageNamed:@"jiare_hs1"], [UIImage imageNamed:@"jiare_hs2"], [UIImage imageNamed:@"jiare_hs3"]] duration:4.0f]];
    }
    return _array7;
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
            value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:1]).range];
            if ([value isEqualToString:@"111"]) {
                value = @"未连接";
            } else if ([value isEqualToString:@"112"]){
                value = @"短路";
            } else{
                value = [value stringByAppendingString:@"°C"];
            }
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
            self.leftView.image = [self.array0 objectAtIndex:0];
            self.middleView.image = [self.array0 objectAtIndex:1];
            self.rightView.image = [self.array0 objectAtIndex:2];
        }
            break;
        case 1:
        {
            self.leftView.image = [self.array1 objectAtIndex:0];
            self.middleView.image = [self.array1 objectAtIndex:1];
            self.rightView.image = [self.array1 objectAtIndex:2];
        }
            break;
        case 2:
        {
            self.leftView.image = [self.array2 objectAtIndex:0];
            self.middleView.image = [self.array2 objectAtIndex:1];
            self.rightView.image = [self.array2 objectAtIndex:2];
        }
            break;
        case 3:
        {
            self.leftView.image = [self.array3 objectAtIndex:0];
            self.middleView.image = [self.array3 objectAtIndex:1];
            self.rightView.image = [self.array3 objectAtIndex:2];
        }
            break;
        case 4:
        {
            self.leftView.image = [self.array4 objectAtIndex:0];
            self.middleView.image = [self.array4 objectAtIndex:1];
            self.rightView.image = [self.array4 objectAtIndex:2];
        }
            break;
        case 5:
        {
            self.leftView.image = [self.array5 objectAtIndex:0];
            self.middleView.image = [self.array5 objectAtIndex:1];
            self.rightView.image = [self.array5 objectAtIndex:2];
        }
            break;
        case 6:
        {
            self.leftView.image = [self.array6 objectAtIndex:0];
            self.middleView.image = [self.array6 objectAtIndex:1];
            self.rightView.image = [self.array6 objectAtIndex:2];
        }
            break;
        case 7:
        {
            self.leftView.image = [self.array7 objectAtIndex:0];
            self.middleView.image = [self.array7 objectAtIndex:1];
            self.rightView.image = [self.array7 objectAtIndex:2];
        }
            break;
        case 8:
        {
            self.leftView.image = [self.array8 objectAtIndex:0];
            self.middleView.image = [self.array8 objectAtIndex:1];
            self.rightView.image = [self.array8 objectAtIndex:2];
        }
            break;
        case 9:
        {
            self.leftView.image = [self.array9 objectAtIndex:0];
            self.middleView.image = [self.array9 objectAtIndex:1];
            self.rightView.image = [self.array9 objectAtIndex:2];
        }
            break;
        case 10:
        {
            self.leftView.image = [self.array10 objectAtIndex:0];
            self.middleView.image = [self.array10 objectAtIndex:1];
            self.rightView.image = [self.array10 objectAtIndex:2];
        }
            break;
        case 11:
        {
            self.leftView.image = [self.array11 objectAtIndex:0];
            self.middleView.image = [self.array11 objectAtIndex:1];
            self.rightView.image = [self.array11 objectAtIndex:2];
        }
            break;
        case 12:
        {
            self.leftView.image = [self.array12 objectAtIndex:0];
            self.middleView.image = [self.array12 objectAtIndex:1];
            self.rightView.image = [self.array12 objectAtIndex:2];
        }
            break;

        default:
        {
            self.leftView.image = [self.array13 objectAtIndex:0];
            self.middleView.image = [self.array13 objectAtIndex:1];
            self.rightView.image = [self.array13 objectAtIndex:2];
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
