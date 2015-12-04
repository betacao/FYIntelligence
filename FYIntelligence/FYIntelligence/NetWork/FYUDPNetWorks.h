//
//  FYUDPNetWorks.h
//  FYIntelligence
//
//  Created by changxicao on 15/12/4.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FYUDPNetWorksFinishBlock) (BOOL finish, NSString *reponseString);

@interface FYUDPNetWorks : NSObject

+ (instancetype) shareNetEngine;

- (void)createClientUdpSocket;

- (void)refreshUdpSocket;

- (void)sendRequest:(NSString *)request complete:(void(^)(BOOL finish, NSString *responseString))block;

- (void)startRequestMainData:(void (^)(BOOL, NSString *))block;

- (void)resumeMainData;

- (void)stopMainData;

@end
