//
//  FYEnterPINViewController.h
//  FYIntelligence
//
//  Created by changxicao on 15/10/11.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FYEnterPINDelegate <NSObject>

- (void)didEnterAllPIN:(NSString *)pinNumber index:(NSInteger)index;

@end

@interface FYEnterPINViewController : UIViewController

@property (assign, nonatomic) id<FYEnterPINDelegate> delegate;
@property (assign, nonatomic) NSInteger index;

@end
