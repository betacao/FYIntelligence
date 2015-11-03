//
//  FYUDPSpecialNetWork.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/25.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYUDPSpecialNetWork.h"
#import "AsyncUdpSocket.h"

@interface FYUDPSpecialNetWork ()<AsyncUdpSocketDelegate>

@property (strong, nonatomic) AsyncUdpSocket *sendUdpSocket;
@property (copy, nonatomic) FYUDPNetWorkFinishBlock finishBlock;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSData *sendMessage;
@property (assign, nonatomic) NSInteger sendTimes;
@property (assign, nonatomic) BOOL isSending;

@end

@implementation FYUDPSpecialNetWork

+ (instancetype) shareNetEngine
{
    static FYUDPSpecialNetWork *sharedEngine = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedEngine = [[self alloc] init];
    });
    return sharedEngine;

}

- (void)createClientUdpSocket
{
    self.sendUdpSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    NSString *address = kHostAddress;
    uint16_t port = kUDPHostPort;
    NSError *error = nil;
    [self.sendUdpSocket bindToAddress:address port:port error:&error];
    if (error) {
        NSLog(@"%@",error.description);
    }
}

- (NSTimer *)timer
{
    if(!_timer){
        _timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(fireSendMessage) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port
{
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
    NSLog(@"globleString = %@",globleString);

    NSInteger globleNumber = [[globleString substringFromIndex:6] integerValue];
    NSLog(@"globleNumber = %ld",(long)globleNumber);

    NSString *responeString = @"";
    for (NSInteger index = 1; index <= MResult.count - 1; index++) {
        result = [MResult objectAtIndex:index];
        responeString = [responeString stringByAppendingFormat:@"%@&",[string substringWithRange:result.range]];
    }
    NSLog(@"success = %@",responeString);
    __weak typeof(self) weakSelf = self;

    if(globleNumber == kAppDelegate.globleNumber){
        kAppDelegate.globleNumber++;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.finishBlock(YES, responeString);
        });
        return YES;
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.finishBlock(NO, @"ERROR");
        });
        return NO;
    }
}


- (void)sendRequest:(NSString *)request complete:(void (^)(BOOL, NSString *))block
{
    if(self.isSending){
        self.finishBlock = block;
        return;
    }
    self.isSending = YES;
    NSData *data = [request dataUsingEncoding:NSUTF8StringEncoding];
    [self.timer setFireDate:[NSDate date]];
    self.sendMessage = data;
}

- (void)fireSendMessage
{
    if(!self.sendMessage){
        [self.timer setFireDate:[NSDate distantFuture]];
        self.sendTimes = 0;
        self.isSending = NO;
        self.finishBlock(NO,nil);
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