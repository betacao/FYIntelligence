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
@property (assign, nonatomic) NSInteger controlId;


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
    [self getInfo];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.leftView.hidden = YES;
    self.middleView.hidden = YES;
    self.rightView.hidden = YES;
    self.paramButton.hidden = YES;
    self.userAddButton.hidden = YES;
    self.userWarmButton.hidden = YES;
    self.temCircleButton.hidden = YES;
    self.waterCircleButton.hidden = YES;
    self.firstButton.hidden = YES;
    self.secondButton.hidden = YES;
    self.thirdButton.hidden = YES;
    self.fourthButton.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initUI];
    [[FYUDPNetWork shareNetEngine] resumeMainData];
}

- (void)initUI
{
    self.leftView.hidden = NO;
    self.middleView.hidden = NO;
    self.rightView.hidden = NO;
    self.paramButton.hidden = NO;
    self.userAddButton.hidden = NO;
    self.userWarmButton.hidden = NO;
    self.temCircleButton.hidden = NO;
    self.waterCircleButton.hidden = NO;
    self.firstButton.hidden = NO;
    self.secondButton.hidden = NO;
    self.thirdButton.hidden = NO;
    self.fourthButton.hidden = NO;


    CGRect frame = self.leftView.frame;
    frame.origin.x = 0.0f;
    frame.origin.y = 0.0f;
    frame.size.height = kScreenHeight;
    frame.size.width = kScreenWidth / 35.0f * 14.0f;
    self.leftView.frame = frame;

    frame = self.middleView.frame;
    frame.origin.x = CGRectGetMaxX(self.leftView.frame);
    frame.origin.y = 0.0f;
    frame.size.height = kScreenHeight;
    frame.size.width = kScreenWidth / 35.0f * 6.0f;
    self.middleView.frame = frame;

    frame = self.rightView.frame;
    frame.origin.x = CGRectGetMaxX(self.middleView.frame);
    frame.origin.y = 0.0f;
    frame.size.height = kScreenHeight;
    frame.size.width = kScreenWidth / 35.0f * 15.0f;
    self.rightView.frame = frame;

}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[FYUDPNetWork shareNetEngine] stopMainData];
    [FYProgressHUD hideHud];
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
                    [UIImage imageNamed:@"right"]];
    }
    return _array0;
}
- (NSArray *)array1
{
    if (!_array1) {
        _array1 = @[[UIImage imageNamed:@"left"],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"gdhs_hx0"], [UIImage imageNamed:@"gdhs_hx1"], [UIImage imageNamed:@"gdhs_hx2"], [UIImage imageNamed:@"gdhs_hx3"]] duration:4.0f]];
    }
    return _array1;
}
- (NSArray *)array2
{
    if (!_array2) {
        _array2 = @[[UIImage
                     animatedImageWithImages:@[[UIImage imageNamed:@"wcxh_hx0"], [UIImage imageNamed:@"wcxh_hx1"], [UIImage imageNamed:@"wcxh_hx2"], [UIImage imageNamed:@"wcxh_hx3"], [UIImage imageNamed:@"wcxh_hx4"], [UIImage imageNamed:@"wcxh_hx5"]] duration:4.0f],
                    [UIImage imageNamed:@"right"]];
    }
    return _array2;
}
- (NSArray *)array4
{
    if (!_array4) {
        _array4 = @[[UIImage imageNamed:@"left"],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_hx0"], [UIImage imageNamed:@"jiare_hx1"], [UIImage imageNamed:@"jiare_hx2"], [UIImage imageNamed:@"jiare_hx3"], [UIImage imageNamed:@"jiare_hx4"], [UIImage imageNamed:@"jiare_hx5"]] duration:4.0f]];
    }
    return _array4;
}
- (NSArray *)array8
{
    if (!_array8) {
        _array8 = @[[UIImage
                     animatedImageWithImages:@[[UIImage imageNamed:@"ss_hx0"], [UIImage imageNamed:@"ss_hx1"], [UIImage imageNamed:@"ss_hx2"], [UIImage imageNamed:@"ss_hx3"], [UIImage imageNamed:@"ss_hx4"], [UIImage imageNamed:@"ss_hx5"], [UIImage imageNamed:@"ss_hx6"]] duration:4.0f],
                    [UIImage imageNamed:@"right"]];
    }
    return _array8;
}
- (NSArray *)array5
{
    if (!_array5) {
        _array5 = @[[UIImage imageNamed:@"left"],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_hs0"], [UIImage imageNamed:@"jiare_hs1"], [UIImage imageNamed:@"jiare_hs2"], [UIImage imageNamed:@"jiare_hs3"], [UIImage imageNamed:@"jiare_hs4"]] duration:4.0f]];
    }
    return _array5;
}
- (NSArray *)array9
{
    if (!_array9) {
        _array9 = @[[UIImage
                     animatedImageWithImages:@[[UIImage imageNamed:@"ss_hx0"], [UIImage imageNamed:@"ss_hx1"], [UIImage imageNamed:@"ss_hx2"], [UIImage imageNamed:@"ss_hx3"], [UIImage imageNamed:@"ss_hx4"], [UIImage imageNamed:@"ss_hx5"], [UIImage imageNamed:@"ss_hx6"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"gdhs_hx0"], [UIImage imageNamed:@"gdhs_hx1"], [UIImage imageNamed:@"gdhs_hx2"], [UIImage imageNamed:@"gdhs_hx3"]] duration:4.0f]];
    }
    return _array9;
}
- (NSArray *)array3
{
    if (!_array3) {
        _array3 = @[[UIImage
                     animatedImageWithImages:@[[UIImage imageNamed:@"wcxh_hx0"], [UIImage imageNamed:@"wcxh_hx1"], [UIImage imageNamed:@"wcxh_hx2"], [UIImage imageNamed:@"wcxh_hx3"], [UIImage imageNamed:@"wcxh_hx4"], [UIImage imageNamed:@"wcxh_hx5"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"gdhs_hx0"], [UIImage imageNamed:@"gdhs_hx1"], [UIImage imageNamed:@"gdhs_hx2"], [UIImage imageNamed:@"gdhs_hx3"]] duration:4.0f]];
    }
    return _array3;
}
- (NSArray *)array6
{
    if (!_array6) {
        _array6 = @[[UIImage
                     animatedImageWithImages:@[[UIImage imageNamed:@"wcxh_hx0"], [UIImage imageNamed:@"wcxh_hx1"], [UIImage imageNamed:@"wcxh_hx2"], [UIImage imageNamed:@"wcxh_hx3"], [UIImage imageNamed:@"wcxh_hx4"], [UIImage imageNamed:@"wcxh_hx5"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_hx0"], [UIImage imageNamed:@"jiare_hx1"], [UIImage imageNamed:@"jiare_hx2"], [UIImage imageNamed:@"jiare_hx3"], [UIImage imageNamed:@"jiare_hx4"], [UIImage imageNamed:@"jiare_hx5"]] duration:4.0f]];
    }
    return _array6;
}
- (NSArray *)array12
{
    if (!_array12) {
        _array12 = @[[UIImage
                      animatedImageWithImages:@[[UIImage imageNamed:@"ss_hx0"], [UIImage imageNamed:@"ss_hx1"], [UIImage imageNamed:@"ss_hx2"], [UIImage imageNamed:@"ss_hx3"], [UIImage imageNamed:@"ss_hx4"], [UIImage imageNamed:@"ss_hx5"], [UIImage imageNamed:@"ss_hx6"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_hx0"], [UIImage imageNamed:@"jiare_hx1"], [UIImage imageNamed:@"jiare_hx2"], [UIImage imageNamed:@"jiare_hx3"], [UIImage imageNamed:@"jiare_hx4"], [UIImage imageNamed:@"jiare_hx5"]] duration:4.0f]];
    }
    return _array12;
}
- (NSArray *)array13
{
    if (!_array13) {
        _array13 = @[[UIImage
                      animatedImageWithImages:@[[UIImage imageNamed:@"ss_hx0"], [UIImage imageNamed:@"ss_hx1"], [UIImage imageNamed:@"ss_hx2"], [UIImage imageNamed:@"ss_hx3"], [UIImage imageNamed:@"ss_hx4"], [UIImage imageNamed:@"ss_hx5"], [UIImage imageNamed:@"ss_hx6"]] duration:4.0f],
                     [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_hs0"], [UIImage imageNamed:@"jiare_hs1"], [UIImage imageNamed:@"jiare_hs2"], [UIImage imageNamed:@"jiare_hs3"], [UIImage imageNamed:@"jiare_hs4"]] duration:4.0f]];
    }
    return _array13;
}
- (NSArray *)array7
{
    if (!_array7) {
        _array7 = @[[UIImage
                     animatedImageWithImages:@[[UIImage imageNamed:@"wcxh_hx0"], [UIImage imageNamed:@"wcxh_hx1"], [UIImage imageNamed:@"wcxh_hx2"], [UIImage imageNamed:@"wcxh_hx3"], [UIImage imageNamed:@"wcxh_hx4"], [UIImage imageNamed:@"wcxh_hx5"]] duration:4.0f],
                     [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_hs0"], [UIImage imageNamed:@"jiare_hs1"], [UIImage imageNamed:@"jiare_hs2"], [UIImage imageNamed:@"jiare_hs3"], [UIImage imageNamed:@"jiare_hs4"]] duration:4.0f]];
    }
    return _array7;
}

- (void)getInfo
{
    __weak typeof(self) weakSelf = self;
    [[FYUDPNetWork shareNetEngine] startRequestMainData:^(BOOL finish, NSString *responseString) {
        if(finish){
            [weakSelf AnalyticalData:responseString];
        }
    }];
}
- (void)AnalyticalData:(NSString *)responseString
{
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
    NSString *value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:1]).range];
    if ([value isEqualToString:@"111"]) {
        value = @"未连接";
    } else if ([value isEqualToString:@"112"]){
        value = @"短路";
    } else{
        value = [value stringByAppendingString:@"°C"];
    }
    [self.firstButton setTitle:value forState:UIControlStateNormal];
    value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:2]).range];
    if ([value isEqualToString:@"111"]) {
        value = @"未连接";
    } else if ([value isEqualToString:@"112"]){
        value = @"短路";
    } else{
        value = [value stringByAppendingString:@"°C"];
    }
    [self.secondButton setTitle:value forState:UIControlStateNormal];
    value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:3]).range];
    if ([value isEqualToString:@"111"]) {
        value = @"未连接";
    } else if ([value isEqualToString:@"112"]){
        value = @"短路";
    } else{
        value = [value stringByAppendingString:@"°C"];
    }
    [self.thirdButton setTitle:value forState:UIControlStateNormal];
    value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:4]).range];
    if ([value isEqualToString:@"111"]) {
        value = @"未连接";
    } else if ([value isEqualToString:@"112"]){
        value = @"短路";
    } else{
        value = [value stringByAppendingString:@"°C"];
    }
    [self.fourthButton setTitle:value forState:UIControlStateNormal];

    NSString *type = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:0]).range];
    NSString *level = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:5]).range];
    self.controlId = [type integerValue];
    [self changeImage:type level:level];
}

- (UIImage *)normalChangeMiddleAnimation:(NSString *)level
{
    UIImage *image = nil;
    if ([level isEqualToString:@"00"]){
        image = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"middle_00_0"], [UIImage imageNamed:@"middle_00_1"]] duration:1.0f];
    } else if ([level isEqualToString:@"20"]){
        image = [UIImage imageNamed:@"middle_20"];
    } else if ([level isEqualToString:@"50"]){
        image = [UIImage imageNamed:@"middle_50"];
    } else if ([level isEqualToString:@"80"]){
        image = [UIImage imageNamed:@"middle_80"];
    } else if ([level isEqualToString:@"100"]){
        image = [UIImage imageNamed:@"middle_100"];
    } else{
        image = [UIImage imageNamed:@"middle_err"];
    }
    return image;
}

- (UIImage *)warmChangeMiddleAnimation:(NSString *)level
{
    UIImage *image = nil;
    if ([level isEqualToString:@"00"]){
        image = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"jiare_middle_00_0"], [UIImage imageNamed:@"jiare_middle_00_1"]] duration:1.0f];
    } else if ([level isEqualToString:@"20"]){
        image = [UIImage imageNamed:@"jiare_middle_20"];
    } else if ([level isEqualToString:@"50"]){
        image = [UIImage imageNamed:@"jiare_middle_50"];
    } else if ([level isEqualToString:@"80"]){
        image = [UIImage imageNamed:@"jiare_middle_80"];
    } else if ([level isEqualToString:@"100"]){
        image = [UIImage imageNamed:@"jiare_middle_100"];
    } else{
        image = [UIImage imageNamed:@"jiare_middle_err"];
    }
    return image;
}

- (void)changeImage:(NSString *)type level:(NSString *)level
{
    switch ([type integerValue]) {
        case 0:
        {
            self.leftView.image = [self.array0 objectAtIndex:0];
            self.middleView.image = [self normalChangeMiddleAnimation:level];
            self.rightView.image = [self.array0 objectAtIndex:1];
        }
            break;
        case 1:
        {
            self.leftView.image = [self.array1 objectAtIndex:0];
            self.middleView.image = [self normalChangeMiddleAnimation:level];
            self.rightView.image = [self.array1 objectAtIndex:1];
        }
            break;
        case 2:
        {
            self.leftView.image = [self.array2 objectAtIndex:0];
            self.middleView.image = [self normalChangeMiddleAnimation:level];
            self.rightView.image = [self.array2 objectAtIndex:1];
        }
            break;
        case 3:
        {
            self.leftView.image = [self.array3 objectAtIndex:0];
            self.middleView.image = [self normalChangeMiddleAnimation:level];
            self.rightView.image = [self.array3 objectAtIndex:1];
        }
            break;
        case 4:
        {
            self.leftView.image = [self.array4 objectAtIndex:0];
            self.middleView.image = [self warmChangeMiddleAnimation:level];
            self.rightView.image = [self.array4 objectAtIndex:1];
        }
            break;
        case 5:
        {
            self.leftView.image = [self.array5 objectAtIndex:0];
            self.middleView.image = [self warmChangeMiddleAnimation:level];
            self.rightView.image = [self.array5 objectAtIndex:1];
        }
            break;
        case 6:
        {
            self.leftView.image = [self.array6 objectAtIndex:0];
            self.middleView.image = [self warmChangeMiddleAnimation:level];
            self.rightView.image = [self.array6 objectAtIndex:1];
        }
            break;
        case 7:
        {
            self.leftView.image = [self.array7 objectAtIndex:0];
            self.middleView.image = [self warmChangeMiddleAnimation:level];
            self.rightView.image = [self.array7 objectAtIndex:1];
        }
            break;
        case 8:
        {
            self.leftView.image = [self.array8 objectAtIndex:0];
            self.middleView.image = [self normalChangeMiddleAnimation:level];
            self.rightView.image = [self.array8 objectAtIndex:1];
        }
            break;
        case 9:
        {
            self.leftView.image = [self.array9 objectAtIndex:0];
            self.middleView.image = [self normalChangeMiddleAnimation:level];
            self.rightView.image = [self.array9 objectAtIndex:1];
        }
            break;
        case 10:
        {
            self.leftView.image = [self.array10 objectAtIndex:0];
            self.middleView.image = [self.array10 objectAtIndex:1];
            self.rightView.image = [self.array10 objectAtIndex:1];
        }
            break;
        case 11:
        {
            self.leftView.image = [self.array11 objectAtIndex:0];
            self.middleView.image = [self.array11 objectAtIndex:1];
            self.rightView.image = [self.array11 objectAtIndex:1];
        }
            break;
        case 12:
        {
            self.leftView.image = [self.array12 objectAtIndex:0];
            self.middleView.image = [self warmChangeMiddleAnimation:level];
            self.rightView.image = [self.array12 objectAtIndex:1];
        }
            break;

        default:
        {
            self.leftView.image = [self.array13 objectAtIndex:0];
            self.middleView.image = [self warmChangeMiddleAnimation:level];
            self.rightView.image = [self.array13 objectAtIndex:1];
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
    [[FYUDPNetWork shareNetEngine] stopMainData];
    __weak typeof(self) weakSelf = self;
    NSString *globleString = [NSString stringWithFormat:@"%ld",(long)kAppDelegate.globleNumber];
    NSString *state = (self.controlId&0x08) == 0 ? @"1" :@"0";
    NSString *request = [NSString stringWithFormat:kMainNoPINString,kAppDelegate.deviceID,kAppDelegate.userName,globleString,@"cmd_sdss",state];
    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        [[FYUDPNetWork shareNetEngine] resumeMainData];
        if(finish){
            [weakSelf AnalyticalData:responseString];
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
    [[FYUDPNetWork shareNetEngine] stopMainData];
    __weak typeof(self) weakSelf = self;
    NSString *globleString = [NSString stringWithFormat:@"%ld",(long)kAppDelegate.globleNumber];
    NSString *state = (self.controlId&0x04) == 0 ? @"1" :@"0";
    NSString *request = [NSString stringWithFormat:kMainNoPINString,kAppDelegate.deviceID,kAppDelegate.userName,globleString,@"cmd_sdjr",state];
    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        [[FYUDPNetWork shareNetEngine] resumeMainData];
        if(finish){
            [weakSelf AnalyticalData:responseString];
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
    [[FYUDPNetWork shareNetEngine] stopMainData];
    __weak typeof(self) weakSelf = self;
    NSString *globleString = [NSString stringWithFormat:@"%ld",(long)kAppDelegate.globleNumber];

    NSString *state = (self.controlId&0x02) == 0 ? @"1" :@"0";
    NSString *request = [NSString stringWithFormat:kMainNoPINString,kAppDelegate.deviceID,kAppDelegate.userName,globleString,@"cmd_wcxh",state];

    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        [[FYUDPNetWork shareNetEngine] resumeMainData];
        if(finish){
            [weakSelf AnalyticalData:responseString];

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
    [[FYUDPNetWork shareNetEngine] stopMainData];
    __weak typeof(self) weakSelf = self;
    NSString *globleString = [NSString stringWithFormat:@"%ld",(long)kAppDelegate.globleNumber];

    NSString *state = (self.controlId&0x01) == 0 ? @"1" :@"0";
    NSString *request = [NSString stringWithFormat:kMainNoPINString,kAppDelegate.deviceID,kAppDelegate.userName,globleString,@"cmd_gdhs",state];
    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        [[FYUDPNetWork shareNetEngine] resumeMainData];
        if(finish){
            [weakSelf AnalyticalData:responseString];
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
