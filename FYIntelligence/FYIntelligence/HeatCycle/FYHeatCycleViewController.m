//
//  FYHeatCycleViewController.m
//  FYIntelligence
//
//  Created by changxicao on 16/1/6.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "FYHeatCycleViewController.h"
#import "FYEnterPINViewController.h"
#import "FYHeatCycleSettingViewController.h"

@interface FYHeatCycleViewController ()<FYEnterPINDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;

@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIImageView *fanBgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fanImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bgzImageView;
@property (weak, nonatomic) IBOutlet UIImageView *hswdImageView;
@property (weak, nonatomic) IBOutlet UILabel *bgzLabel;
@property (weak, nonatomic) IBOutlet UILabel *hswdLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourthLabel;
@property (weak, nonatomic) IBOutlet UIButton *powerButton;
@property (strong, nonatomic) NSString *runState;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger currentTime;
@property (strong, nonatomic) NSString *responseString;

@end

@implementation FYHeatCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgImageView.image = [UIImage imageNamed:@"rsxh_bj"];
    CGRect frame = self.topView.frame;
    frame.origin.y *= YFACTOR;
    frame.size.height *= YFACTOR;
    self.topView.frame = frame;

    frame = self.fanBgImageView.frame;
    frame.size.width *= YFACTOR;
    frame.size.height *= YFACTOR;
    self.fanBgImageView.frame = frame;

    frame = self.fanImageView.frame;
    frame.size.width *= YFACTOR;
    frame.size.height *= YFACTOR;
    self.fanImageView.frame = frame;


    frame = self.bgzImageView.frame;
    frame.origin.x = CGRectGetMaxX(self.fanBgImageView.frame) + 5.0f;
    frame.origin.y *= YFACTOR;
    self.bgzImageView.frame = frame;

    frame = self.hswdImageView.frame;
    frame.origin.x = CGRectGetMaxX(self.fanBgImageView.frame) + 5.0f;
    frame.origin.y *= YFACTOR;
    self.hswdImageView.frame = frame;

    frame = self.bgzLabel.frame;
    frame.origin.x = CGRectGetMaxX(self.bgzImageView.frame) + 5.0f;
    frame.origin.y *= YFACTOR;
    self.bgzLabel.frame = frame;

    frame = self.hswdLabel.frame;
    frame.origin.x = CGRectGetMaxX(self.hswdImageView.frame) + 5.0f;
    frame.origin.y *= YFACTOR;
    self.hswdLabel.frame = frame;

    frame = self.middleView.frame;
    frame.origin.y = CGRectGetMaxY(self.topView.frame);
    self.middleView.frame = frame;

    frame = self.bottomView.frame;
    frame.origin.y = CGRectGetMaxY(self.middleView.frame) * (YFACTOR > 1.0f ? 1.0f : YFACTOR);
    self.bottomView.frame = frame;

    self.currentTime = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [self getInfo];
}

- (void)getInfo
{
    __weak typeof(self) weakSelf = self;
    [[FYUDPNetWork shareNetEngine] udpMainType:FYMainTypeHot startRequestMainData:^(BOOL success, NSString *responseString) {
        weakSelf.responseString = responseString;
    }];
}

- (void)startAnimation
{
    self.fanImageView.image = [UIImage animatedImageWithImages:
  @[[UIImage imageNamed:@"yelun_1"], [UIImage imageNamed:@"yelun_2"], [UIImage imageNamed:@"yelun_3"], [UIImage imageNamed:@"yelun_4"], [UIImage imageNamed:@"yelun_5"], [UIImage imageNamed:@"yelun_6"], ] duration:1.0f];
}

- (void)stopAnimation
{
    self.fanImageView.image = [UIImage imageNamed:@"yelun"];
}

- (void)countDown
{
    if (self.currentTime < 0) {
        if (self.responseString.length > 0) {
            [self AnalyticalData:self.responseString];
        }
        return;
    }
    self.bgzLabel.text = [NSString stringWithFormat:@"%ld秒",(long)self.currentTime];
    self.currentTime--;
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
    NSString *value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:0]).range];

    //状态
    NSString *state = value;
    self.runState = state;
    self.bgzImageView.image = [UIImage imageNamed:@"bgz"];
    [self.powerButton setImage:[UIImage imageNamed:@"rsxhpower"] forState:UIControlStateNormal];
    [self stopAnimation];
    if ([state isEqualToString:@"00"]) {
        self.stateImageView.image = [UIImage imageNamed:@"rsxhshutdown"];
        [self.powerButton setImage:[UIImage imageNamed:@"rsxhpoweroff"] forState:UIControlStateNormal];
        self.bgzImageView.hidden = YES;
        self.bgzLabel.hidden = YES;
    } else if ([state isEqualToString:@"01"]){
        self.stateImageView.image = [UIImage imageNamed:@"djz"];
        self.bgzImageView.hidden = YES;
        self.bgzLabel.hidden = YES;
    } else if ([state isEqualToString:@"02"]){
        self.stateImageView.image = [UIImage imageNamed:@"bgz"];
        self.bgzImageView.hidden = NO;
        self.bgzLabel.hidden = NO;
        [self startAnimation];
    } else if ([state isEqualToString:@"03"]){
        self.stateImageView.image = [UIImage imageNamed:@"jx"];
        self.bgzImageView.image = [UIImage imageNamed:@"jx"];
        self.bgzImageView.hidden = NO;
        self.bgzLabel.hidden = NO;
    }
    //分
    value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:1]).range];
    NSString *minute = value;
    //秒
    value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:2]).range];
    NSString *second = value;
    //显示时间
    NSInteger time = [minute integerValue] * 60.0f + [second integerValue];
    self.currentTime = time;

    //温度
    value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:3]).range];
    NSString *temp = [value stringByAppendingString:@"°C"];
    self.hswdLabel.text = temp;

    //运行模式
    value = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:4]).range];
    NSInteger mode = [value integerValue];

    self.firstLabel.textColor = [UIColor colorWithHexString:@"bebebe"];
    self.secondLabel.textColor = [UIColor colorWithHexString:@"bebebe"];
    self.thirdLabel.textColor = [UIColor colorWithHexString:@"bebebe"];
    self.fourthLabel.textColor = [UIColor colorWithHexString:@"bebebe"];

    if ((mode & 0x01) != 0){
        self.firstLabel.textColor = [UIColor whiteColor];
    } else if ((mode & 0x02) != 0){
        self.secondLabel.textColor = [UIColor whiteColor];
    } else if ((mode & 0x04) != 0){
        self.thirdLabel.textColor = [UIColor whiteColor];
    } else if ((mode & 0x05) != 0){
        self.fourthLabel.textColor = [UIColor whiteColor];
    }
}

- (IBAction)userClick:(UIButton *)sender
{
    [[FYUDPNetWork shareNetEngine] stopMainData];
    __weak typeof(self) weakSelf = self;
    NSString *globleString = [NSString stringWithFormat:@"%ld",(long)kAppDelegate.globleNumber];
    NSString *request = [NSString stringWithFormat:kNoPINString,kAppDelegate.deviceID,kAppDelegate.userName,globleString,kHotSDXHCmd];
    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        [[FYUDPNetWork shareNetEngine] resumeMainData];
        if(finish){
            [weakSelf AnalyticalData:responseString];
        } else{
            
        }
    }];
}

- (IBAction)powerClick:(id)sender
{
    [[FYUDPNetWork shareNetEngine] stopMainData];
    __weak typeof(self) weakSelf = self;
    NSString *request = @"";
    NSString *globleString = [NSString stringWithFormat:@"%ld",(long)kAppDelegate.globleNumber];
    if ([self.runState isEqualToString:@"00"]) {
        request = [NSString stringWithFormat:kNoPINString,kAppDelegate.deviceID,kAppDelegate.userName,globleString,@"power$1"];
    } else{
        request = [NSString stringWithFormat:kNoPINString,kAppDelegate.deviceID,kAppDelegate.userName,globleString,@"power$0"];
    }
    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        [[FYUDPNetWork shareNetEngine] resumeMainData];
        if(finish){
            [weakSelf AnalyticalData:responseString];
        } else{

        }
    }];
}

- (IBAction)paramClick:(id)sender
{
    if(kAppDelegate.pinNumber.length == 0){
        FYEnterPINViewController *controller = [[FYEnterPINViewController alloc] initWithNibName:@"FYEnterPINViewController" bundle:nil];
        controller.delegate = self;
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
        return;
    }

    FYHeatCycleSettingViewController *controller = [[FYHeatCycleSettingViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)aboutClick:(id)sender
{

}

- (void)didEnterAllPIN:(NSString *)pinNumber index:(NSInteger)index
{
    kAppDelegate.pinNumber = pinNumber;
    FYHeatCycleSettingViewController *controller = [[FYHeatCycleSettingViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[FYUDPNetWork shareNetEngine] stopMainData];
    [FYProgressHUD hideHud];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
