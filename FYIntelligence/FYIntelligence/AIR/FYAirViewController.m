//
//  FYAirViewController.m
//  FYIntelligence
//
//  Created by changxicao on 16/4/17.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "FYAirViewController.h"
#import "FYAboutViewController.h"
#import "FYBaseNavigationViewController.h"
#import "FYEnterPINViewController.h"
#import "FYParamSettingViewController.h"

@interface FYAirViewController ()<FYEnterPINDelegate>
{
    NSThread *thread;
}
@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;

@property (weak, nonatomic) IBOutlet UIButton *aboutButton;
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

@property (assign, nonatomic) BOOL isShowView;
@end

@implementation FYAirViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.aboutButton];
    
    [self.leftImageView addSubview:self.leftButton];
    [self.rightImageView addSubview:self.rightButton];
    self.bgView.sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);

    self.titleImageView.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, -20.0f)
    .widthIs(MarginFactor(100.0f))
    .heightIs(MarginFactor(50.0f));

    self.aboutButton.sd_layout
    .widthIs(MarginFactor(100.0f))
    .heightIs(MarginFactor(28.0f));
    [self.aboutButton setEnlargeEdge:20.0f];

    NSInteger width = self.leftImageView.image.size.width + self.middleImageView.image.size.width + self.rightImageView.image.size.width;
    CGFloat margin = SCREENWIDTH - MarginFactor(20.0f);

    self.leftImageView.sd_layout
    .leftSpaceToView(self.view, MarginFactor(10.0f))
    .topSpaceToView(self.titleImageView, MarginFactor(0.0f))
    .widthIs(self.leftImageView.image.size.width / width * margin)
    .heightIs(self.leftImageView.image.size.height / width * margin);

    self.middleImageView.sd_layout
    .leftSpaceToView(self.leftImageView, 0.0f)
    .topSpaceToView(self.titleImageView, MarginFactor(0.0f))
    .widthIs(self.middleImageView.image.size.width / width * margin)
    .heightIs(self.middleImageView.image.size.height / width * margin);

    self.rightImageView.sd_layout
    .leftSpaceToView(self.middleImageView, 0.0f)
    .topSpaceToView(self.titleImageView, MarginFactor(0.0f))
    .widthIs(self.rightImageView.image.size.width / width * margin)
    .heightIs(self.rightImageView.image.size.height / width * margin);

    margin = (margin - 4 * 80.0f) / 3.0f;
    self.firstButton.sd_layout
    .leftEqualToView(self.leftImageView)
    .topSpaceToView(self.leftImageView, MarginFactor(5.0f))
    .widthIs(80.0f)
    .heightIs(32.0f);

    self.secondButton.sd_layout
    .leftSpaceToView(self.firstButton, margin)
    .topEqualToView(self.firstButton)
    .widthIs(80.0f)
    .heightIs(32.0f);

    self.thirdButton.sd_layout
    .leftSpaceToView(self.secondButton, margin)
    .topEqualToView(self.firstButton)
    .widthIs(80.0f)
    .heightIs(32.0f);

    self.fourthButton.sd_layout
    .leftSpaceToView(self.thirdButton, margin)
    .topEqualToView(self.firstButton)
    .widthIs(80.0f)
    .heightIs(32.0f);

    self.leftButton.sd_layout
    .leftSpaceToView(self.leftImageView, MarginFactor(20.0f))
    .topSpaceToView(self.leftImageView, MarginFactor(30.0f))
    .widthIs(46.0f)
    .heightIs(30.0f);

    self.rightButton.sd_layout
    .leftSpaceToView(self.rightImageView, MarginFactor(2.0f))
    .topSpaceToView(self.rightImageView, MarginFactor(50.0f))
    .widthIs(46.0f)
    .heightIs(30.0f);

    self.isShowView = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.isShowView = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.isShowView = NO;
    [FYProgressHUD hideHud];
}

- (NSArray *)array0
{
    if (!_array0) {
        _array0 = @[[UIImage imageNamed:@"kqnleft"],
                    [UIImage imageNamed:@"kqnright"]];
    }
    return _array0;
}
- (NSArray *)array1
{
    if (!_array1) {
        _array1 = @[[UIImage animatedImageWithImages:@[[UIImage imageNamed:@"kqn_gdxh_0"], [UIImage imageNamed:@"kqn_gdxh_1"], [UIImage imageNamed:@"kqn_gdxh_2"], [UIImage imageNamed:@"kqn_gdxh_3"], [UIImage imageNamed:@"kqn_gdxh_4"], [UIImage imageNamed:@"kqn_gdxh_5"]] duration:4.0f], [UIImage imageNamed:@"kqnright"]];
    }
    return _array1;
}
- (NSArray *)array2
{
    if (!_array2) {
        _array2 = @[[UIImage imageNamed:@"kqnleft"],
                    [UIImage imageNamed:@"kqnright"]];
    }
    return _array2;
}
- (NSArray *)array4
{
    if (!_array4) {
        _array4 = @[[UIImage imageNamed:@"kqnleft"],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"kqn_jr0"], [UIImage imageNamed:@"kqn_jr1"], [UIImage imageNamed:@"kqn_jr2"], [UIImage imageNamed:@"kqn_jr3"], [UIImage imageNamed:@"kqn_jr4"], [UIImage imageNamed:@"kqn_jr5"]] duration:4.0f]];
    }
    return _array4;
}
- (NSArray *)array8
{
    if (!_array8) {
        _array8 = @[[UIImage imageNamed:@"kqnleft"],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"kqn_ss0"], [UIImage imageNamed:@"kqn_ss1"], [UIImage imageNamed:@"kqn_ss2"], [UIImage imageNamed:@"kqn_ss3"]] duration:4.0f]];
    }
    return _array8;
}
- (NSArray *)array5
{
    if (!_array5) {
        _array5 = @[[UIImage animatedImageWithImages:@[[UIImage imageNamed:@"kqn_gdxh_0"], [UIImage imageNamed:@"kqn_gdxh_1"], [UIImage imageNamed:@"kqn_gdxh_2"], [UIImage imageNamed:@"kqn_gdxh_3"], [UIImage imageNamed:@"kqn_gdxh_4"], [UIImage imageNamed:@"kqn_gdxh_5"]] duration:4.0f],

                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"kqn_jr0"], [UIImage imageNamed:@"kqn_jr1"], [UIImage imageNamed:@"kqn_jr2"], [UIImage imageNamed:@"kqn_jr3"], [UIImage imageNamed:@"kqn_jr4"], [UIImage imageNamed:@"kqn_jr5"]] duration:4.0f]];
    }
    return _array5;
}
- (NSArray *)array9
{
    if (!_array9) {
        _array9 = @[[UIImage animatedImageWithImages:@[[UIImage imageNamed:@"kqn_gdxh_0"], [UIImage imageNamed:@"kqn_gdxh_1"], [UIImage imageNamed:@"kqn_gdxh_2"], [UIImage imageNamed:@"kqn_gdxh_3"], [UIImage imageNamed:@"kqn_gdxh_4"], [UIImage imageNamed:@"kqn_gdxh_5"]] duration:4.0f],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"kqn_ss0"], [UIImage imageNamed:@"kqn_ss1"], [UIImage imageNamed:@"kqn_ss2"], [UIImage imageNamed:@"kqn_ss3"]] duration:4.0f]];
    }
    return _array9;
}
- (NSArray *)array3
{
    if (!_array3) {
        _array3 = @[[UIImage animatedImageWithImages:@[[UIImage imageNamed:@"kqn_gdxh_0"], [UIImage imageNamed:@"kqn_gdxh_1"], [UIImage imageNamed:@"kqn_gdxh_2"], [UIImage imageNamed:@"kqn_gdxh_3"], [UIImage imageNamed:@"kqn_gdxh_4"], [UIImage imageNamed:@"kqn_gdxh_5"]] duration:4.0f], [UIImage imageNamed:@"kqnright"]];
    }
    return _array3;
}
- (NSArray *)array6
{
    if (!_array6) {
        _array6 = @[[UIImage imageNamed:@"kqnleft"],
                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"kqn_jr0"], [UIImage imageNamed:@"kqn_jr1"], [UIImage imageNamed:@"kqn_jr2"], [UIImage imageNamed:@"kqn_jr3"], [UIImage imageNamed:@"kqn_jr4"], [UIImage imageNamed:@"kqn_jr5"]] duration:4.0f]];
    }
    return _array6;
}
- (NSArray *)array12
{
    if (!_array12) {
        _array12 = @[[UIImage imageNamed:@"kqnleft"],
                     [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"kqn_jr_ss_0"], [UIImage imageNamed:@"kqn_jr_ss_1"], [UIImage imageNamed:@"kqn_jr_ss_2"], [UIImage imageNamed:@"kqn_jr_ss_3"]] duration:4.0f]];
    }
    return _array12;
}
- (NSArray *)array13
{
    if (!_array13) {
        _array13 = @[[UIImage animatedImageWithImages:@[[UIImage imageNamed:@"kqn_gdxh_0"], [UIImage imageNamed:@"kqn_gdxh_1"], [UIImage imageNamed:@"kqn_gdxh_2"], [UIImage imageNamed:@"kqn_gdxh_3"], [UIImage imageNamed:@"kqn_gdxh_4"], [UIImage imageNamed:@"kqn_gdxh_5"]] duration:4.0f],
                     [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"kqn_jr_ss_0"], [UIImage imageNamed:@"kqn_jr_ss_1"], [UIImage imageNamed:@"kqn_jr_ss_2"], [UIImage imageNamed:@"kqn_jr_ss_3"]] duration:4.0f]];
    }
    return _array13;
}
- (NSArray *)array7
{
    if (!_array7) {
        _array7 = @[[UIImage animatedImageWithImages:@[[UIImage imageNamed:@"kqn_gdxh_0"], [UIImage imageNamed:@"kqn_gdxh_1"], [UIImage imageNamed:@"kqn_gdxh_2"], [UIImage imageNamed:@"kqn_gdxh_3"], [UIImage imageNamed:@"kqn_gdxh_4"], [UIImage imageNamed:@"kqn_gdxh_5"]] duration:4.0f],

                    [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"kqn_jr0"], [UIImage imageNamed:@"kqn_jr1"], [UIImage imageNamed:@"kqn_jr2"], [UIImage imageNamed:@"kqn_jr3"], [UIImage imageNamed:@"kqn_jr4"], [UIImage imageNamed:@"kqn_jr5"]] duration:4.0f]];
    }
    return _array7;
}


- (void)setIsShowView:(BOOL)isShowView
{
    BOOL new = isShowView;
    BOOL old = _isShowView;
    if (new && !old) {
        thread = [[NSThread alloc] initWithTarget:self selector:@selector(getInfo) object:nil];
        [thread start];
    } else if (!new) {
        [thread cancel];
    }
    _isShowView = isShowView;
}

- (void)getInfo
{
    __weak typeof(self) weakSelf = self;
    while (1) {
        if ([NSThread currentThread].isCancelled) {
            break;
        } else {
            NSString *responseString = [[FYUDPNetWork sharedNetWork] sendMessage:kMainViewCmd type:0];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf AnalyticalData:responseString];
            });
            [NSThread sleepForTimeInterval:25.0f];
        }
    }

}
- (void)AnalyticalData:(NSString *)responseString
{
    if (responseString.length == 0||[responseString isEqualToString:@"OFFLINE"]) {
        return;
    }
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
//    [self.firstButton setTitle:value forState:UIControlStateNormal];
    value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:2]).range];
    if ([value isEqualToString:@"111"]) {
        value = @"未连接";
    } else if ([value isEqualToString:@"112"]){
        value = @"短路";
    } else{
        value = [value stringByAppendingString:@"°C"];
    }
//    [self.secondButton setTitle:value forState:UIControlStateNormal];
    value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:3]).range];
    if ([value isEqualToString:@"111"]) {
        value = @"未连接";
    } else if ([value isEqualToString:@"112"]){
        value = @"短路";
    } else{
        value = [value stringByAppendingString:@"°C"];
    }
    [self.rightButton setTitle:value forState:UIControlStateNormal];
    value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:4]).range];
    if ([value isEqualToString:@"111"]) {
        value = @"未连接";
    } else if ([value isEqualToString:@"112"]){
        value = @"短路";
    } else{
        value = [value stringByAppendingString:@"°C"];
    }
    [self.leftButton setTitle:value forState:UIControlStateNormal];

    NSString *type = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:0]).range];
    NSString *level = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:5]).range];
    self.controlId = [type integerValue];
    [self changeImage:type level:level];
}

- (void)changeImage:(NSString *)type level:(NSString *)level
{
    switch ([type integerValue]) {
        case 0:
        {
            self.leftImageView.image = [self.array0 objectAtIndex:0];
            self.middleImageView.image = [self normalChangeMiddleAnimation:level];
            self.rightImageView.image = [self.array0 objectAtIndex:1];
        }
            break;
        case 1:
        {
            self.leftImageView.image = [self.array1 objectAtIndex:0];
            self.middleImageView.image = [self normalChangeMiddleAnimation:level];
            self.rightImageView.image = [self.array1 objectAtIndex:1];
        }
            break;
        case 2:
        {
            self.leftImageView.image = [self.array2 objectAtIndex:0];
            self.middleImageView.image = [self normalChangeMiddleAnimation:level];
            self.rightImageView.image = [self.array2 objectAtIndex:1];
        }
            break;
        case 3:
        {
            self.leftImageView.image = [self.array3 objectAtIndex:0];
            self.middleImageView.image = [self normalChangeMiddleAnimation:level];
            self.rightImageView.image = [self.array3 objectAtIndex:1];
        }
            break;
        case 4:
        {
            self.leftImageView.image = [self.array4 objectAtIndex:0];
            self.middleImageView.image = [self warmChangeMiddleAnimation:level];
            self.rightImageView.image = [self.array4 objectAtIndex:1];
        }
            break;
        case 5:
        {
            self.leftImageView.image = [self.array5 objectAtIndex:0];
            self.middleImageView.image = [self warmChangeMiddleAnimation:level];
            self.rightImageView.image = [self.array5 objectAtIndex:1];
        }
            break;
        case 6:
        {
            self.leftImageView.image = [self.array6 objectAtIndex:0];
            self.middleImageView.image = [self warmChangeMiddleAnimation:level];
            self.rightImageView.image = [self.array6 objectAtIndex:1];
        }
            break;
        case 7:
        {
            self.leftImageView.image = [self.array7 objectAtIndex:0];
            self.middleImageView.image = [self warmChangeMiddleAnimation:level];
            self.rightImageView.image = [self.array7 objectAtIndex:1];
        }
            break;
        case 8:
        {
            self.leftImageView.image = [self.array8 objectAtIndex:0];
            self.middleImageView.image = [self normalChangeMiddleAnimation:level];
            self.rightImageView.image = [self.array8 objectAtIndex:1];
        }
            break;
        case 9:
        {
            self.leftImageView.image = [self.array9 objectAtIndex:0];
            self.middleImageView.image = [self normalChangeMiddleAnimation:level];
            self.rightImageView.image = [self.array9 objectAtIndex:1];
        }
            break;
        case 10:
        {
            self.leftImageView.image = [self.array10 objectAtIndex:0];
            self.middleImageView.image = [self.array10 objectAtIndex:1];
            self.rightImageView.image = [self.array10 objectAtIndex:1];
        }
            break;
        case 11:
        {
            self.leftImageView.image = [self.array11 objectAtIndex:0];
            self.middleImageView.image = [self.array11 objectAtIndex:1];
            self.rightImageView.image = [self.array11 objectAtIndex:1];
        }
            break;
        case 12:
        {
            self.leftImageView.image = [self.array12 objectAtIndex:0];
            self.middleImageView.image = [self warmChangeMiddleAnimation:level];
            self.rightImageView.image = [self.array12 objectAtIndex:1];
        }
            break;

        default:
        {
            self.leftImageView.image = [self.array13 objectAtIndex:0];
            self.middleImageView.image = [self warmChangeMiddleAnimation:level];
            self.rightImageView.image = [self.array13 objectAtIndex:1];
        }
            break;
    }
}

- (UIImage *)normalChangeMiddleAnimation:(NSString *)level
{
    UIImage *image = nil;
    if ([level isEqualToString:@"00"]){
        image = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"kqn_middle_00_0"], [UIImage imageNamed:@"kqn_middle_00_1"]] duration:1.0f];
    } else if ([level isEqualToString:@"20"]){
        image = [UIImage imageNamed:@"kqn_middle_20"];
    } else if ([level isEqualToString:@"50"]){
        image = [UIImage imageNamed:@"kqn_middle_50"];
    } else if ([level isEqualToString:@"80"]){
        image = [UIImage imageNamed:@"kqn_middle_80"];
    } else if ([level isEqualToString:@"100"]){
        image = [UIImage imageNamed:@"kqn_middle_100"];
    } else{
        image = [UIImage imageNamed:@"kqn_middle_err"];
    }
    return image;
}

- (UIImage *)warmChangeMiddleAnimation:(NSString *)level
{
    UIImage *image = nil;
    if ([level isEqualToString:@"00"]){
        image = [UIImage animatedImageWithImages:@[[UIImage imageNamed:@"kqn_jiare_middle_00_0"], [UIImage imageNamed:@"kqn_jiare_middle_00_1"]] duration:1.0f];
    } else if ([level isEqualToString:@"20"]){
        image = [UIImage imageNamed:@"kqn_jiare_middle_20"];
    } else if ([level isEqualToString:@"50"]){
        image = [UIImage imageNamed:@"kqn_jiare_middle_50"];
    } else if ([level isEqualToString:@"80"]){
        image = [UIImage imageNamed:@"kqn_jiare_middle_80"];
    } else if ([level isEqualToString:@"100"]){
        image = [UIImage imageNamed:@"kqn_jiare_middle_100"];
    } else{
        image = [UIImage imageNamed:@"kqn_jiare_middle_err"];
    }
    return image;
}

- (IBAction)aboutButtonClicked:(UIButton *)sender
{
    FYAboutViewController *controller = [[FYAboutViewController alloc] initWithNibName:@"FYAboutViewController" bundle:nil];
    FYBaseNavigationViewController *nav = [[FYBaseNavigationViewController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)firstButtonClicked:(UIButton *)sender
{
    FYEnterPINViewController *controller = [[FYEnterPINViewController alloc] initWithNibName:@"FYEnterPINViewController" bundle:nil];
    controller.delegate = self;
    [self.parentViewController addChildViewController:controller];
    [self.parentViewController.view addSubview:controller.view];
}

- (IBAction)secondButtonClicked:(id)sender
{
    //手动上水

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSString *state = (self.controlId&0x08) == 0 ? @"1" :@"0";

        NSString *responseString = [[FYUDPNetWork sharedNetWork] sendMessage:[NSString stringWithFormat:@"cmd_sdss$%@",state] type:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self AnalyticalData:responseString];
        });
    });
}

- (IBAction)thirdButtonClicked:(id)sender
{
    //手动加热
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *state = (self.controlId&0x04) == 0 ? @"1" :@"0";

        NSString *responseString = [[FYUDPNetWork sharedNetWork] sendMessage:[NSString stringWithFormat:@"cmd_sdjr$%@",state] type:0];
        dispatch_async(dispatch_get_main_queue(), ^{

            [self AnalyticalData:responseString];
        });
    });

}

- (IBAction)fourthButtonClicked:(id)sender
{
    //管道回水
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *state = (self.controlId&0x01) == 0 ? @"1" :@"0";
        NSString *responseString = [[FYUDPNetWork sharedNetWork] sendMessage:[NSString stringWithFormat:@"cmd_gdhs$%@",state] type:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self AnalyticalData:responseString];
        });
    });
}

- (void)didEnterAllPIN:(NSString *)pinNumber index:(NSInteger)index
{
    kAppDelegate.pinCode = pinNumber;

    FYParamSettingViewController *controller = [[FYParamSettingViewController alloc] initWithNibName:@"FYParamSettingViewController" bundle:nil];
    controller.devideType = DeviceTypeAir;
    FYBaseNavigationViewController *nav = [[FYBaseNavigationViewController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)backButtonClick:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
