//
//  FYPickerView.h
//  FYIntelligence
//
//  Created by changxicao on 15/10/14.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FYPickerViewDelegate <NSObject>

- (void)didSelectItem:(NSString *)itemString;

@end

@interface FYPickerView : UIView

- (void)loadDataArray:(NSArray *)array;

@end
