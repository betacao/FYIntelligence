//
//  const.h
//  FYIntelligence
//
//  Created by changxicao on 15/10/9.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#ifndef const_h
#define const_h

#define kAppDelegate [AppDelegate currentAppdelegate]

#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

#define XFACTOR kScreenWidth / 320.0f
#define YFACTOR kScreenHeight / 568.0f
#define kRememberUserName @"rememberUserName"
#define kUserName @"userName"
#define kPassWord @"passWord"
#define kResponseString @"responseString"
#define kHostAddress @"120.27.151.216"
#define kTCPHostPort 11104
#define kUDPHostPort 11102
#define kLoginAddress @"fyzn2015#1#6#"
#define kListAddress @"fyzn2015#1#8#"

#define kNoPINString @"ICP2P0259#%@#U#G7S3#%@#%@#%@$#"
#define kMainNoPINString @"ICP2P0259#%@#U#G7S3#%@#%@#%@$%@$#"
#define kNoPINClearCmd @"fyzn2015#1#11#%@#G7S3#%@#"

#define kNeedPINString @"ICP2P0259#%@#U#%@#%@#%@#%@$#"
#define kNeedPINClearCmd @"fyzn2015#1#11#%@#%@#%@#"
//定时加热
#define kDSJRCmd @"config_dsjr$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@"
#define kGETDSJRCmd @"read_dsjr_config"
//定时上水
#define kDSSSCmd @"config_dsss$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@"
#define kGETDSSSCmd @"read_dsss_config"
//防冻保护
#define kFDBHCmd @"config_fdbh$%@$%@"
#define kGETFDBHCmd @"read_fdbh_config"
//管道循环
#define kGDXHCmd @"config_gdxh$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@"
#define kGETGDXHCmd @"read_gdxh_config"
//恒水位
#define kHSWCmd @"config_hsw$%@$%@"
#define kGETHSWCmd @"read_hsw_config"
//恒温加热
#define kHWJRCmd @"config_hwjr$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@"
#define kGETHWJRCmd @"read_hwjr_config"
//手动加热
#define kSDJRCmd @"config_sdjr$%@"
#define kGETSDJRCmd @"read_sdjr_config"
//手动上水
#define kSDSSCmd @"config_sdss$%@"
#define kGETSDSSCmd @"read_sdss_config"
//温差循环
#define kWCXHCmd @"config_wcxh$%@$%@$%@"
#define kGETWCXHCmd @"read_wcxh_config"
//温控进水
#define kWKJSCmd @"config_wkjs$%@$%@"
#define kGETWKJSCmd @"read_wkjs_config"
//预设报警
#define kYSBJCmd @"config_ysbj$%@$%@$%@$%@$%@"
#define kGETYSBJCmd @"read_ysbj_config"

//注册指令
#define kRegisterCmd @"fyzn2015#1#7#%@#%@#0#0#0#%@#"
//添加设备
#define kAddDeviceCmd @"LOCAL_GET_ID"
//首页指令
#define kMainViewCmd @"read_dev_info"

#define kAddedDeviceCmd @"fyzn2015#1#12#%@#%@#%@#%@#0#"

#define kDeleteDeviceCmd @"fyzn2015#1#13#%@#%@#%@#"

#define kConfigDeviceCmd @"change_wifi$%@$%@"

#define kResetPwdCmd @"fyzn2015#1#15#%@#"

#define kGetCodeCmd @"fyzn2015#1#9#%@#"

//热循环首页指令
#define kHotMainViewCmd @"read_rsxh_info"
//热循环手动循环
#define kHotSDXHCmd @"sdxh_start$1"

#endif /* const_h */
