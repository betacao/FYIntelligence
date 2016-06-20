//
//  FYGlobleManager.h
//  FYNetWork
//
//  Created by changxicao on 16/6/19.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FYGlobleManager : NSObject

+ (instancetype)sharedGlobleManager;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *deviceID;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *pinCode;
@property (strong, nonatomic) NSString *receivedStream;


@property (assign, nonatomic) BOOL isRemember;
@property (strong, nonatomic) NSString *userPWD;
@property (strong, nonatomic) NSString *ESPDescription;

@property (assign, nonatomic) BOOL refreshing;

@end
