//
//  AppDelegate.h
//  FYIntelligence
//
//  Created by changxicao on 15/10/9.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *deviceID;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *pinCode;
@property (strong, nonatomic) NSString *receivedStream;


@property (assign, nonatomic) BOOL isRemember;
@property (strong, nonatomic) NSString *userPWD;
@property (strong, nonatomic) NSString *ESPDescription;

+ (AppDelegate *)currentAppdelegate;

@end

