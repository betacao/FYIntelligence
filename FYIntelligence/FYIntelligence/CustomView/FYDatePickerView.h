//
//  FYDatePickerView.h
//  FYIntelligence
//
//  Created by changxicao on 15/10/14.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FYDatePickerViewDelegate <NSObject>

- (void)object:(UIButton *)button didSelectDate:(NSString *)date;

@end

@interface FYDatePickerView : UIView
@property (assign, nonatomic) id<FYDatePickerViewDelegate> delegate;
@property (weak, nonatomic) UIButton *responseObject;
@end
