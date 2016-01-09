//
//  ESPThread.h
//  FYIntelligence
//
//  Created by changxicao on 16/1/9.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESPThread : NSObject

+ (ESPThread *) currentThread;

- (BOOL) sleep: (long long) milliseconds;

- (void) interrupt;

- (BOOL) isInterrupt;

@end
