//
//  FYNetWork.h
//  FYIntelligence
//
//  Created by changxicao on 15/10/19.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYNetWork : NSObject

+ (instancetype) shareNetEngine;

- (void)createClientTcpSocket;

- (void)sendRequest:(NSString *)requset complete:(void(^)(NSDictionary *dic))block;

@end
