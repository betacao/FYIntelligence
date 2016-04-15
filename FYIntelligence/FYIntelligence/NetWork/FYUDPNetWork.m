//
//  FYUDPNetWork.m
//  SocketDemo
//
//  Created by changxicao on 16/4/10.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "FYUDPNetWork.h"

@interface FYUDPNetWork()<GCDAsyncUdpSocketDelegate>

@property (assign, nonatomic) long tag;
@property (assign, nonatomic) BOOL isReceived;
@property (assign, nonatomic) long sendCount;
@property (assign, nonatomic) NSString *code;
@end

@implementation FYUDPNetWork

+ (instancetype)sharedNetWork
{
    static FYUDPNetWork *sharedNetWork = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetWork = [[self alloc] init];
    });
    return sharedNetWork;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSocket];
    }
    return self;
}

- (void)refreshUdpSocket
{
    [self.socket close];
}

- (void)setupSocket
{
    dispatch_queue_t dQueue = dispatch_queue_create("delegateQueue", NULL);
    self.socket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dQueue];
    NSError *error = nil;

    if (![self.socket bindToPort:11102 error:&error]) {
        NSLog(@"error------%@", error.description);
        return;
    }
    
    if (![self.socket beginReceiving:&error]) {
        NSLog(@"error------%@", error.description);
        return;
    }
}


- (NSString *)sendMessage:(NSString *)message type:(NSInteger)type
{
    [FYProgressHUD showLoadingWithMessage:@"请稍等..."];
    self.isReceived = NO;
    self.sendCount = 0;
    self.tag++;
    self.code = [@"accept" stringByAppendingFormat:@"%ld", self.tag];

    message = [[NSString stringWithFormat:@"%ld#",self.tag] stringByAppendingFormat:@"%@#",message];
    if (type == 1) {
        message = [@"ICP2P0259#" stringByAppendingFormat:@"%@#U#%@#%@#%@",kAppDelegate.deviceID, kAppDelegate.pinCode, kAppDelegate.userID, message];
    } else{
        message = [@"ICP2P0259#" stringByAppendingFormat:@"%@#U#G7S3#%@#%@",kAppDelegate.deviceID, kAppDelegate.userID, message];
    }
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];

    long port = strtoul([kAppDelegate.deviceID UTF8String], 0, 16);
    port = [self getPort:port];

    NSInteger i = 20;
    while (!self.isReceived && self.sendCount < 3) {
        if (i == 20) {
            i = 0;
            self.sendCount++;
            [self.socket sendData:data toHost:@"120.27.151.216" port:port withTimeout:-1 tag:self.tag];
        }
        i++;
        usleep(200 * 1000);
    }

    [FYProgressHUD hideHud];
    if (self.sendCount >= 3) {
        //tcp清理掉数据
        [FYProgressHUD showMessageWithText:@"设备离线"];
        return @"";
    }
    NSString *steam = kAppDelegate.receivedStream;
    kAppDelegate.receivedStream = @"";

    if ([steam containsString:@"ERROR_PIN"]) {
        [FYProgressHUD showMessageWithText:@"PIN码输入错误"];
        return @"ERROR_PIN";
    } else if([steam containsString:@"OFFLINE"]) {
        [FYProgressHUD showMessageWithText:@"设备离线"];
        return @"OFFLINE";
    }
    return steam;
}

- (uint16_t)getPort:(long)port
{
    if(port%10==0)
        return 11000;
    else if(port%10==1)
        return 11001;
    else if(port%10==2)
        return 11002;
    else if(port%10==3)
        return 11003;
    else if(port%10==4)
        return 11004;
    else if(port%10==5)
        return 11005;
    else if(port%10==6)
        return 11006;
    else if(port%10==7)
        return 11007;
    else if(port%10==8)
        return 11008;
    else if(port%10==9)
        return 11009;
    else 
        return 11102;
}


- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    NSLog(@"发送数据 tag===%ld", tag);
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    NSLog(@"未能发送数据 tag===%ld", tag);
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"udp string:%@",string);
    if ([string containsString:@"ERROR_PIN"]) {
        self.isReceived = YES;
        kAppDelegate.receivedStream = string;
    } else if([string containsString:@"OFFLINE"]) {
        self.isReceived = YES;
        kAppDelegate.receivedStream = string;
    } else {
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
        NSLog(@"code == %@", self.code);
        if ([self.code isEqualToString:globleString]) {
            self.isReceived = YES;
            string = [string substringFromIndex:[string rangeOfString:globleString].length];
            kAppDelegate.receivedStream = string;
        }
    }

}

- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setupSocket];
    });
}

@end
