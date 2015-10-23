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
#define kDSJRCmd @"config_dsjr$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@"
#endif /* const_h */
