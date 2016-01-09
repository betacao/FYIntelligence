//
//  FYUDPNewWork.h
//  FYIntelligence
//
//  Created by changxicao on 15/10/21.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, FYUDPSendType)
{
    FYUDPSendTypeNone = 0,
    FYUDPSendTypePIN
};

typedef NS_ENUM(NSInteger, FYMainType)
{
    FYMainTypeSun = 0,
    FYMainTypeHot
};

typedef void (^FYUDPNetWorkFinishBlock) (BOOL finish, NSString *reponseString);

@interface FYUDPNetWork : NSObject

@property (assign, nonatomic) FYMainType mainType;

+ (instancetype) shareNetEngine;

- (void)createClientUdpSocket;

- (void)refreshUdpSocket;

- (void)sendRequest:(NSString *)request complete:(void(^)(BOOL finish, NSString *responseString))block;

- (void)udpMainType:(FYMainType)type startRequestMainData:(void (^)(BOOL, NSString *))block;

- (void)resumeMainData;

- (void)stopMainData;
@end
