//
//  FYUDPNewWork.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/21.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYUDPNetWork.h"
#import "GCDAsyncUdpSocket.h"

@interface FYUDPNetWork ()<GCDAsyncUdpSocketDelegate>

@property (strong, nonatomic) GCDAsyncUdpSocket *sendUdpSocket;
@property (copy, nonatomic) FYUDPNetWorkFinishBlock finishBlock;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSData *sendMessage;
@property (assign, nonatomic) NSInteger sendTimes;
@property (assign, nonatomic) BOOL isSending;

@end

@implementation FYUDPNetWork

+ (instancetype) shareNetEngine
{
    static FYUDPNetWork *sharedEngine = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedEngine = [[self alloc] init];
    });
    return sharedEngine;

}

- (void)createClientUdpSocket
{
    dispatch_queue_t dQueue = dispatch_queue_create("client udp socket", NULL);
    self.sendUdpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dQueue socketQueue:nil];
    uint16_t port = kUDPHostPort;
    NSError *error = nil;
    if (![self.sendUdpSocket bindToPort:port error:&error]){
        NSLog(@"Error starting server (bind): %@", error);
        return;
    }
    if (![self.sendUdpSocket beginReceiving:&error]){
        [self.sendUdpSocket close];
        NSLog(@"Error starting server (recv): %@", error);
        return;
    }
    NSLog(@"Udp Echo server started on port %hu", [self.sendUdpSocket localPort]);
}

- (NSTimer *)timer
{
    if(!_timer){
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(fireSendMessage) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
    [self.timer setFireDate:[NSDate distantFuture]];
    self.sendTimes = 0;
    self.sendMessage = nil;
    self.isSending = NO;
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"udp string:%@",string);
//    st
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    
}
- (void)sendRequest:(NSString *)request complete:(void (^)(NSDictionary *))block
{
    if(self.isSending){
        return;
    }
    self.isSending = YES;
    NSData *data = [request dataUsingEncoding:NSUTF8StringEncoding];
    [self.timer setFireDate:[NSDate date]];
    self.sendMessage = data;
    self.finishBlock = block;
    [FYProgressHUD showLoadingWithMessage:@"请稍等..."];
}

- (void)fireSendMessage
{
    if(!self.sendMessage && self.sendTimes > 20){
        return;
    }
    self.sendTimes++;
    NSLog(@"send times %ld",(long)self.sendTimes);
    // 发送消息 这里不需要知道对象的ip地址和端口
    NSString *host = kHostAddress;
    uint16_t port = kUDPHostPort;
    [self.sendUdpSocket sendData:self.sendMessage toHost:host port:port withTimeout:0 tag:0];
}

@end
