//
//  FYConfigViewController.h
//  FYIntelligence
//
//  Created by changxicao on 15/11/7.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYDevice.h"

@protocol FYConfigDelegate <NSObject>

- (void)didDeleteDevice:(NSString *)deviceID;

@end

@interface FYConfigViewController : UIViewController
@property (strong, nonatomic) NSString *deviceID;
@property (assign, nonatomic) id<FYConfigDelegate> delegate;
@end
