//
//  FYBaseViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/9.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYBaseNavigationViewController.h"

@interface FYBaseNavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation FYBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];

    UIColor *color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationBar.titleTextAttributes = dict;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
