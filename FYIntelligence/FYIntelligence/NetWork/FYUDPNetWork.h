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

typedef void (^FYUDPNetWorkFinishBlock) (BOOL finish, NSString *reponseString);

@interface FYUDPNetWork : NSObject

+ (instancetype) shareNetEngine;

- (void)createClientUdpSocket;

- (void)refreshUdpSocket;

- (void)sendRequest:(NSString *)request complete:(void(^)(BOOL finish, NSString *responseString))block;

- (void)requestMainData:(void (^)(BOOL, NSString *))block;

- (void)stopMainData;
@end
