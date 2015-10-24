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
#define kHostAddress @"112.124.35.155"
#define kTCPHostPort 11104
#define kUDPHostPort 11102
#define kLoginAddress @"fyzn2015#1#6#"
#define kListAddress @"fyzn2015#1#8#"

#define kNoPINString @"ICP2P0259#%@#U#G7S3#%@#%@#%@$#"
#define kNoPINClearCmd @"1#11#%@#G7S3#%@$#"

#define kNeedPINString @"ICP2P0259#%@#U#%@#%@#%@#%@$#"
#define kNeedPINClearCmd @"1#11#%@#%@#%@$#"
//定时加热
#define kDSJRCmd @"config_dsjr$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@"
//定时上水
#define kDSSSCmd @"config_dsss$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@"
//防冻保护
#define kFDBHCmd @"config_fdbh$%@$%@"
//管道循环
#define kGDXHCmd @"config_gdxh$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@"
//恒水位
#define kHSWCmd @"config_hsw$%@"
//恒温加热
#define kHWJRCmd @"config_hwjr$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@"
//手动加热
#define kSDJRCmd @"config_sdjr$%@"
//手动上水
#define kSDSSCmd @"config_sdss$%@"
//温差循环
#define kWCXHCmd @"config_wcxh$%@$%@$%@"
//温控进水
#define kWKJSCmd @"config_wkjs$%@$%@"
//预设报警
#define kYSBJCmd @"config_ysbj$%@$%@$%@$%@$%@"

#endif /* const_h */
