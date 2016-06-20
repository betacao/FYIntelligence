//
//  FYTCPSpecialNetWork.h
//  FYIntelligence
//
//  Created by changxicao on 15/10/24.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FYTCPSpecialNetWorkFinishBlock) (NSDictionary *dicionary);

@interface FYTCPSpecialNetWork : NSObject

+ (instancetype) shareNetEngine;

- (void)createClientTcpSocket;

- (void)sendRequest:(NSString *)request complete:(void(^)(NSDictionary *dic))block;

@end