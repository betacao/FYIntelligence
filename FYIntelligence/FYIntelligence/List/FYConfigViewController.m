//
//  FYConfigViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/11/7.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYConfigViewController.h"

@interface FYConfigViewController ()

@end

@implementation FYConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}
@end
