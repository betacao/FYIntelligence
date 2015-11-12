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
@property (copy, nonatomic) FYUDPNetWorkFinishBlock mainBlock;
@property (strong, nonatomic) NSTimer *mainTimer;
@property (assign, nonatomic) NSInteger mainNumber;
@property (assign, nonatomic) BOOL needSend;

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
    self.sendUdpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
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
}

- (void)refreshUdpSocket
{
    self.sendUdpSocket = nil;
    [self createClientUdpSocket];
}

- (void)requestMainData:(void (^)(BOOL, NSString *))block
{
    self.mainTimer = [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(mainSendMessage) userInfo:nil repeats:YES];
    [self.mainTimer fire];
    self.mainBlock = block;
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
    [FYProgressHUD hideHud];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"udp string:%@",string);

    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern: @"\\w+" options:0 error:nil];
    NSMutableArray *results = [NSMutableArray array];
    [regularExpression enumerateMatchesInString:string options:0 range:NSMakeRange(0, string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        [results addObject:result];
    }];
    NSComparator cmptr = ^(NSTextCheckingResult *obj1, NSTextCheckingResult *obj2){
        if (obj1.range.location > obj2.range.location) {
            return (NSComparisonResult)NSOrderedDescending;
        } else if (obj1.range.location < obj2.range.location) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    NSArray *MResult = [results sortedArrayUsingComparator:cmptr];
    NSTextCheckingResult *result = [MResult firstObject];
    NSString *globleString = [string substringWithRange:result.range];
    NSInteger globleNumber = [[globleString substringFromIndex:6] integerValue];
    NSLog(@"globleNumber = %ld",(long)globleNumber);
    __weak typeof(self) weakSelf = self;
    NSString *responeString = @"";
    for (NSInteger index = 1; index <= MResult.count - 1; index++) {
        result = [MResult objectAtIndex:index];
        responeString = [responeString stringByAppendingFormat:@"%@&",[string substringWithRange:result.range]];
    }
    NSLog(@"success = %@",responeString);
    if ([responeString rangeOfString:@"ERROR"].location == NSNotFound && responeString.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.mainNumber == globleNumber) {
                if (weakSelf.mainBlock) {
                    weakSelf.mainBlock(YES, responeString);
                }
            } else{
                weakSelf.needSend = NO;
                if (weakSelf.finishBlock) {
                    weakSelf.finishBlock(YES, responeString);
                }
            }
        });
    } else{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.mainNumber == globleNumber) {
                if (weakSelf.mainBlock) {
                    weakSelf.mainBlock(NO, @"");
                }
            } else{
                if (weakSelf.finishBlock) {
                    weakSelf.needSend = NO;
                    weakSelf.finishBlock(NO, @"");
                }
            }
        });
    }
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{

}

- (void)sendRequest:(NSString *)request complete:(void (^)(BOOL, NSString *))block
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    NSData *data = [request dataUsingEncoding:NSUTF8StringEncoding];
    self.finishBlock = block;
    [FYProgressHUD showLoadingWithMessage:@"请稍等..."];
    self.needSend = YES;
    [self performSelector:@selector(fireSendMessage:) withObject:data];

}

- (void)fireSendMessage:(NSData *)sendMessage
{
    // 发送消息 这里不需要知道对象的ip地址和端口
    NSString *host = kHostAddress;
    uint16_t port = kUDPHostPort;
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger i = 0;
        while (i <= 20 && weakSelf.needSend) {
            i++;
            [weakSelf.sendUdpSocket sendData:sendMessage toHost:host port:port withTimeout:-1 tag:0];
            kAppDelegate.globleNumber++;
            NSLog(@"执行次数%ld",(long)i);
            sleep(1);
        }
    });
}

- (void)mainSendMessage
{
    NSLog(@"send main data");
    NSString *request = [NSString stringWithFormat:kNoPINString,kAppDelegate.deviceID,kAppDelegate.userName,@(kAppDelegate.globleNumber),kMainViewCmd];
    NSData *data = [request dataUsingEncoding:NSUTF8StringEncoding];
    NSString *host = kHostAddress;
    uint16_t port = kUDPHostPort;
    [self.sendUdpSocket sendData:data toHost:host port:port withTimeout:-1 tag:0];
    self.mainNumber = kAppDelegate.globleNumber;
    kAppDelegate.globleNumber++;
    
}


@end
