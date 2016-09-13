//
//  AppDelegate.h
//  FYIntelligence
//
//  Created by changxicao on 15/10/9.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *appKey = @"31ed3c68b0bf411f8c3dfba7";
static NSString *channel = @"Publish channel";
static BOOL isProduction = TRUE;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *deviceID;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *pinCode;
@property (strong, nonatomic) NSString *receivedStream;


@property (assign, nonatomic) BOOL isRemember;
@property (strong, nonatomic) NSString *userPWD;
@property (strong, nonatomic) NSString *ESPDescription;

@property (assign, nonatomic) BOOL refreshing;
+ (AppDelegate *)currentAppdelegate;

@end

