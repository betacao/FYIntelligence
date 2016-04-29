//
//  FYListTableViewCell.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/11.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYListTableViewCell.h"
#import "FYDevice.h"

@interface FYListTableViewCell()
@property (strong, nonatomic) FYDevice *currentDevice;
@property (weak, nonatomic) IBOutlet UILabel *deviceID;
@property (weak, nonatomic) IBOutlet UILabel *deviceName;
@property (weak, nonatomic) IBOutlet UILabel *deviceState;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *controlButton;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIButton *configButton;

@end

@implementation FYListTableViewCell

- (void)awakeFromNib {
    UIImage *normalImage = [UIImage imageNamed:@"btn_login_normal"];
    UIImage *pressImage = [UIImage imageNamed:@"btn_login_press"];
    [self.deleteButton setBackgroundImage:[normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.deleteButton setBackgroundImage:[pressImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];

    [self.controlButton setBackgroundImage:[normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.controlButton setBackgroundImage:[pressImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];

    [self.connectButton setBackgroundImage:[normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.connectButton setBackgroundImage:[pressImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];
    [self.configButton setEnlargeEdge:20.0f];
}

- (void)loadDataWithDevice:(FYDevice *)device
{
    self.currentDevice = device;
    self.deviceID.text = device.deviceID;
    NSString *deviceName = @"";
    switch (device.deviceName) {
        case DeviceTypeSun:
            deviceName = @"太阳能智能云中央系统";
            break;
        case DeviceTypeHot:
            deviceName = @"热水智能云循环系统";
            break;
        case DeviceTypeAir:
            deviceName = @"热泵智能云中央系统";
            break;
        case DeviceTypeCFCP:
            deviceName = @"变频恒压智能云系统";
        default:
            break;
    }
    NSString *deviceCondition = @"";
    switch (device.deviceCondition) {
        case deviceConditionOff:
            deviceCondition = @"离线";
            break;

        default:
            deviceCondition = @"在线";
            break;
    }
    self.deviceName.text = deviceName;
    self.deviceState.text = deviceCondition;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (IBAction)clickConfig:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickCongfigButton:)]) {
        [self.delegate clickCongfigButton:self.currentDevice];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
