//
//  ESPThread.m
//  FYIntelligence
//
//  Created by changxicao on 16/1/9.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "ESPThread.h"

@interface ESPThread ()

@property(atomic, assign, getter=isInterrupt) BOOL isInterrupt;
@property(atomic, strong) NSCondition *condition;

@end

@implementation ESPThread

+ (ESPThread *) currentThread
{
    static ESPThread *sharedEngine = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedEngine = [[self alloc] init];
    });
    return sharedEngine;

}

- (id) init
{
    self = [super init];
    if (self)
    {
        self.isInterrupt = NO;
        self.condition = [[NSCondition alloc]init];
    }
    return self;
}

- (BOOL) sleep: (long long) milliseconds
{
    [self.condition lock];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow: milliseconds/1000.0];
    [self.condition waitUntilDate:date];
    [self.condition unlock];
    return self.isInterrupt;
}

- (void) interrupt
{
    [self.condition lock];
    self.isInterrupt = YES;
    [self.condition signal];
    [self.condition unlock];
}

@end
