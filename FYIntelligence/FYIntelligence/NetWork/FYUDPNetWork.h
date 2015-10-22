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

typedef void (^FYUDPNetWorkFinishBlock) (NSDictionary *dicionary);

@interface FYUDPNetWork : NSObject

+ (instancetype) shareNetEngine;

- (void)createClientUdpSocket;

- (void)sendRequest:(NSString *)request complete:(void(^)(NSDictionary *dic))block;
@end
