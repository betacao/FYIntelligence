//
//  FYHeatCycleViewController.m
//  FYIntelligence
//
//  Created by changxicao on 16/1/6.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "FYHeatCycleViewController.h"

@interface FYHeatCycleViewController ()
@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIImageView *fanBgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fanImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bgzImageView;
@property (weak, nonatomic) IBOutlet UIImageView *hswdImageView;
@property (weak, nonatomic) IBOutlet UILabel *bgzLabel;
@property (weak, nonatomic) IBOutlet UILabel *hswdLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
