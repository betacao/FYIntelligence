//
//  FYUDPSpecialNetWork.h
//  FYIntelligence
//
//  Created by changxicao on 15/10/25.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FYUDPSpecialNetWorkFinishBlock) (BOOL finish, NSString *reponseString);

@interface FYUDPSpecialNetWork : NSObject

+ (instancetype) shareNetEngine;

- (void)createClientUdpSocket;

- (void)sendRequest:(NSString *)request complete:(void(^)(BOOL finish, NSString *responseString))block;
@end
