//
//  FYHeatCycleViewController.m
//  FYIntelligence
//
//  Created by changxicao on 16/1/6.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "FYHeatCycleViewController.h"
#import "FYEnterPINViewController.h"

@interface FYHeatCycleViewController ()<FYEnterPINDelegate>

@property (strong, nonatomic) IBOutlet UIView *titleView;
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
@property (strong, nonatomic) NSString *runState;

@end

@implementation FYHeatCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgImageView.image = [UIImage imageNamed:@"rsxh_bj"];
    self.navigationItem.titleView = self.titleView;
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

    [self getInfo];
}

- (void)getInfo
{
    __weak typeof(self) weakSelf = self;
    [FYUDPNetWork shareNetEngine].mainType = FYMainTypeHot;
    [[FYUDPNetWork shareNetEngine] startRequestMainData:^(BOOL success, NSString *responseString) {
        //状态
        NSString *state = @"";
        weakSelf.runState = state;
        //分
        NSString *minute = @"";
        //秒
        NSString *second = @"";
        //显示时间
        NSString *time = @"";
        self.bgzImageView.image = [UIImage imageNamed:@"bgz"];
        [self stopAnimation];
        if ([state isEqualToString:@"0"]) {
            weakSelf.stateImageView.image = [UIImage imageNamed:@"rsxhshutdown"];
            self.bgzImageView.hidden = YES;
            self.hswdImageView.hidden = YES;
        } else if ([state isEqualToString:@"1"]){
            weakSelf.stateImageView.image = [UIImage imageNamed:@"djz"];
            self.bgzImageView.hidden = YES;
            self.hswdImageView.hidden = YES;
        } else if ([state isEqualToString:@"2"]){
            weakSelf.stateImageView.image = [UIImage imageNamed:@"bgz"];
            self.bgzImageView.hidden = NO;
            self.hswdImageView.hidden = NO;
            [self startAnimation];
        } else if ([state isEqualToString:@"3"]){
            weakSelf.stateImageView.image = [UIImage imageNamed:@"jx"];
            self.bgzImageView.image = [UIImage imageNamed:@"jx"];
            self.bgzImageView.hidden = NO;
            self.hswdImageView.hidden = NO;
        }

        //温度
        NSString *temp = [@"" stringByAppendingString:@"°C"];
        self.hswdLabel.text = temp;

        //运行模式
        NSInteger mode = [@"" integerValue];

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
        
    }];
}

- (void)startAnimation
{
    self.fanImageView.image = [UIImage animatedImageWithImages:
  @[[UIImage imageNamed:@"yelun_1"], [UIImage imageNamed:@"yelun_2"], [UIImage imageNamed:@"yelun_3"], [UIImage imageNamed:@"yelun_4"], [UIImage imageNamed:@"yelun_5"], [UIImage imageNamed:@"yelun_6"], ] duration:0.3f];
}

- (void)stopAnimation
{
    self.fanImageView.image = [UIImage imageNamed:@"yelun"];
}

- (IBAction)userClick:(UIButton *)sender
{
    [[FYUDPNetWork shareNetEngine] stopMainData];
//    __weak typeof(self) weakSelf = self;
    NSString *globleString = [NSString stringWithFormat:@"%ld",(long)kAppDelegate.globleNumber];
    NSString *request = [NSString stringWithFormat:kNoPINString,kAppDelegate.deviceID,kAppDelegate.userName,globleString,kHotSDXHCmd];
    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        [[FYUDPNetWork shareNetEngine] resumeMainData];
        if(finish){

        } else{
            
        }
    }];
}

- (IBAction)powerClick:(id)sender
{
    NSString *request = @"";
    NSString *globleString = [NSString stringWithFormat:@"%ld",(long)kAppDelegate.globleNumber];
    if ([self.runState isEqualToString:@"0"]) {
        request = [NSString stringWithFormat:kNoPINString,kAppDelegate.deviceID,kAppDelegate.userName,globleString,@"power$1"];
    } else{
        request = [NSString stringWithFormat:kNoPINString,kAppDelegate.deviceID,kAppDelegate.userName,globleString,@"power$0"];
    }
    [[FYUDPNetWork shareNetEngine] sendRequest:request complete:^(BOOL finish, NSString *responseString) {
        [[FYUDPNetWork shareNetEngine] resumeMainData];
        if(finish){

        } else{

        }
    }];
}

- (IBAction)paramClick:(id)sender
{
    if(kAppDelegate.pinNumber.length == 0){
        FYEnterPINViewController *controller = [[FYEnterPINViewController alloc] initWithNibName:@"FYEnterPINViewController" bundle:nil];
        controller.delegate = self;
        //        controller.index = indexPath.row;
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
        return;
    }

//    FYParamSettingViewController *controller = [[FYParamSettingViewController alloc] initWithNibName:@"FYParamSettingViewController" bundle:nil];
//    FYBaseNavigationViewController *nav = [[FYBaseNavigationViewController alloc] initWithRootViewController:controller];
//    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)aboutClick:(id)sender
{

}

- (void)didEnterAllPIN:(NSString *)pinNumber index:(NSInteger)index
{
    kAppDelegate.pinNumber = pinNumber;
//    FYParamSettingViewController *controller = [[FYParamSettingViewController alloc] initWithNibName:@"FYParamSettingViewController" bundle:nil];
//    FYBaseNavigationViewController *nav = [[FYBaseNavigationViewController alloc] initWithRootViewController:controller];
//    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
