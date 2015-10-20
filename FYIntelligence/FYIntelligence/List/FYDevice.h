//
//  FYDevice.h
//  FYIntelligence
//
//  Created by changxicao on 15/10/20.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FYDeviceType)
{
    DeviceTypeSun = 0
};

typedef NS_ENUM(NSInteger, FYDeviceCondition)
{
    deviceConditionOff = 0,
    deviceConditionOn = 1
};


@interface FYDevice : NSObject

@property (strong, nonatomic) NSString *deviceID;
@property (assign, nonatomic) FYDeviceType deviceTD;
@property (assign, nonatomic) FYDeviceCondition deviceCondition;

@end
