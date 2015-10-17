//
//  FYPickerView.h
//  FYIntelligence
//
//  Created by changxicao on 15/10/14.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FYPickerViewDelegate <NSObject>

- (void)object:(UIButton *)button didSelectItem:(NSString *)itemString;

@end

@interface FYPickerView : UIView

@property (assign, nonatomic) id<FYPickerViewDelegate> delegate;
@property (weak, nonatomic) UIButton *responseObject;
- (void)loadDataArray:(NSArray *)array;
- (instancetype)initWithFrame:(CGRect)frame unit:(NSString *)unit;

@end
