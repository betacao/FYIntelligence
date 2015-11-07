//
//  FYListTableViewCell.h
//  FYIntelligence
//
//  Created by changxicao on 15/10/11.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FYDevice;
@protocol FYListDelegate <NSObject>

- (void)clickCongfigButton:(FYDevice *)device;

@end

@interface FYListTableViewCell : UITableViewCell

@property (assign, nonatomic) id<FYListDelegate> delegate;
- (void)loadDataWithDevice:(FYDevice *)device;

@end
