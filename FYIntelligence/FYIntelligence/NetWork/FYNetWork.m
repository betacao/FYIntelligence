//
//  FYNetWork.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/19.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYNetWork.h"
#import "GCDAsyncSocket.h"

@interface FYNetWork()
@property (strong, nonatomic) GCDAsyncSocket *sendTcpSocket;
@end

@implementation FYNetWork

+ (instancetype) shareNetEngine
{
    static FYNetWork *sharedEngine = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedEngine = [[self alloc] init];
    });
    return sharedEngine;
}

- (void)createClientTcpSocket
{
    dispatch_queue_t dQueue = dispatch_queue_create("client tdp socket", NULL);
    // 1. 创建一个 udp socket用来和服务端进行通讯
    self.sendTcpSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dQueue socketQueue:nil];
    // 2. 连接服务器端. 只有连接成功后才能相互通讯 如果60s连接不上就出错
    NSString *host = @"112.124.35.155";
    uint16_t port = 11104 ;
    [self.sendTcpSocket connectToHost:host onPort:port withTimeout:60 error:nil];
    // 连接必须服务器在线
}


- (void)sendRequest:(NSString *)requset complete:(void (^)(NSDictionary *))block
{
    NSData *data = [requset dataUsingEncoding:NSUTF8StringEncoding];
    // 开始发送
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // 发送消息 这里不需要知道对象的ip地址和端口
    [self.sendTcpSocket writeData:data withTimeout:60 tag:100];
}

#pragma mark - 代理方法表示连接成功/失败 回调函数
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"连接成功");
    // 等待数据来啊
    [sock readDataWithTimeout:-1 tag:200];;
}
// 如果对象关闭了 这里也会调用
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"连接失败 %@", err);
    // 断线重连
    NSString *host = @"112.124.35.155";
    uint16_t port = 11104;
    [self.sendTcpSocket connectToHost:host onPort:port withTimeout:60 error:nil];
}

@end
