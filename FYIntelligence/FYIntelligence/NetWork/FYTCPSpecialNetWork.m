//
//  FYTCPSpecialNetWork.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/24.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYTCPSpecialNetWork.h"

//
//  FYNetWork.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/19.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYTCPNetWork.h"
#import "GCDAsyncSocket.h"

@interface FYTCPSpecialNetWork()<GCDAsyncSocketDelegate>
@property (strong, nonatomic) GCDAsyncSocket *sendTcpSocket;
@property (copy, nonatomic) FYTCPSpecialNetWorkFinishBlock finishBlock;
@end

@implementation FYTCPSpecialNetWork

+ (instancetype) shareNetEngine
{
    static FYTCPSpecialNetWork *sharedEngine = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedEngine = [[self alloc] init];
    });
    return sharedEngine;
}

- (void)createClientTcpSocket
{
    dispatch_queue_t dQueue = dispatch_queue_create("client special tdp socket", NULL);
    // 1. 创建一个 udp socket用来和服务端进行通讯
    self.sendTcpSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dQueue socketQueue:nil];
    // 2. 连接服务器端. 只有连接成功后才能相互通讯 如果60s连接不上就出错
    NSString *host = kAppDelegate.ESPDescription;
//    NSString *host = @"192.168.2.108";
    uint16_t port = 180;
    [self.sendTcpSocket connectToHost:host onPort:port withTimeout:60 error:nil];
    // 连接必须服务器在线
}


- (void)sendRequest:(NSString *)request complete:(void (^)(NSDictionary *))block
{
    NSData *data = [request dataUsingEncoding:NSUTF8StringEncoding];
    // 发送消息 这里不需要知道对象的ip地址和端口
    [self.sendTcpSocket writeData:data withTimeout:60 tag:0];
    self.finishBlock = block;
    [FYProgressHUD showLoadingWithMessage:@"请稍等..."];
}



#pragma mark - 代理方法表示连接成功/失败 回调函数
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接成功");
    // 等待数据来啊
    [sock readDataWithTimeout:-1 tag:0];;
}
// 如果对象关闭了 这里也会调用
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"连接失败 %@", err);
    // 断线重连
    NSString *host = kHostAddress;
    uint16_t port = kTCPHostPort;
    [self.sendTcpSocket connectToHost:host onPort:port withTimeout:60 error:nil];
}


- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"消息发送成功");
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    [FYProgressHUD hideHud];
    __weak typeof(self) weakSelf = self;
    NSString *ip = [sock connectedHost];
    uint16_t port = [sock connectedPort];
    NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"接收到服务器返回的数据 tcp [%@:%d] %@", ip, port, s);
    dispatch_async(dispatch_get_main_queue(), ^{
        if(weakSelf.finishBlock){
            weakSelf.finishBlock(@{kResponseString:s});
            weakSelf.finishBlock = nil;
        }
    });
    [sock readDataWithTimeout:-1 tag:0];;
}

@end
