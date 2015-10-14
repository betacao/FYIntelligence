//
//  UIColor+FYColor.h
//  FYIntelligence
//
//  Created by changxicao on 15/10/14.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FYColor)

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
