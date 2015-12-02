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
@property (copy, nonatomic) FYUDPNetWorkFinishBlock tempBlock;
@property (assign, nonatomic) BOOL mainSwitch;
@property (assign, nonatomic) BOOL mainState;
@property (assign, nonatomic) BOOL normalState;

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
    self.sendUdpSocket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dQueue];
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
    NSLog(@"Ready");
}

- (void)refreshUdpSocket
{
    [self.sendUdpSocket close];
    [self createClientUdpSocket];
}

- (void)startRequestMainData:(void (^)(BOOL, NSString *))block
{
    self.mainSwitch = YES;
    [self mainSendMessage];
    self.mainBlock = block;
}

- (void)resumeMainData
{
    if (!self.mainSwitch) {
        self.mainSwitch = YES;
        self.mainBlock = self.tempBlock;
        self.tempBlock = nil;
    }
}

- (void)stopMainData
{
    self.mainSwitch = NO;
    self.tempBlock = self.mainBlock;
    self.mainBlock = nil;
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
    if ([responeString rangeOfString:@"ERROR"].location == NSNotFound && responeString.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.mainBlock) {
                weakSelf.mainState = NO;
                weakSelf.mainBlock(YES, responeString);
            } else{
                if (weakSelf.finishBlock) {
                    weakSelf.normalState = NO;
                    weakSelf.finishBlock(YES, responeString);
                }
            }
        });
    } else{
        dispatch_async(dispatch_get_main_queue(), ^{

            if (weakSelf.mainBlock) {
                weakSelf.mainState = NO;
                weakSelf.mainBlock(NO, @"");
            } else{
                if (weakSelf.finishBlock) {
                    weakSelf.normalState = NO;
                    [FYProgressHUD showMessageWithText:@"请求出错，请重试"];
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
    [self fireSendMessage:data];

}

- (void)fireSendMessage:(NSData *)sendMessage
{
    // 发送消息 这里不需要知道对象的ip地址和端口
    NSString *host = kHostAddress;
    uint16_t port = kUDPHostPort;
    self.normalState = YES;
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger i = 0;
        while (i < 20) {
            if (!weakSelf.normalState) {
                break;
            }
            i++;
            [weakSelf.sendUdpSocket sendData:sendMessage toHost:host port:port withTimeout:-1 tag:kAppDelegate.globleNumber];
            kAppDelegate.globleNumber++;
            NSLog(@"执行次数%ld",(long)i);
            sleep(1);
        }
        if (i >= 20 && self.finishBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [FYProgressHUD hideHud];
                [FYProgressHUD showMessageWithText:@"请求超时，请重试"];
                weakSelf.finishBlock(NO, @"");
            });
        }
    });
}

- (void)mainSendMessage
{

    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            if (weakSelf.mainSwitch) {
                [weakSelf sendMessage:kAppDelegate.globleNumber];
                kAppDelegate.globleNumber++;
                sleep(25);
            } else{
                sleep(3);
            }
        }
    });
    
}

- (void)sendMessage:(NSInteger)number
{
    self.mainState = YES;
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSInteger time = 0;
        while (time < 20 && weakSelf.mainSwitch && weakSelf.mainState) {
            time++;
            NSLog(@"detail %ld",(long)number);
            NSString *request = [NSString stringWithFormat:kNoPINString,kAppDelegate.deviceID,kAppDelegate.userName,@(number),kMainViewCmd];
            NSData *data = [request dataUsingEncoding:NSUTF8StringEncoding];
            NSString *host = kHostAddress;
            uint16_t port = kUDPHostPort;
            [weakSelf.sendUdpSocket sendData:data toHost:host port:port withTimeout:-1 tag:number];
            sleep(1);
        }
    });
}


@end
