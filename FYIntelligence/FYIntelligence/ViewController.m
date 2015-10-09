//
//  ViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/9.
//  Copyright (c) 2015年 changxicao. All rights reserved.
//

#import "ViewController.h"
#import "FYLoginViewController.h"
#import "FYBaseNavigationViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FYLoginViewController *rootController = [[FYLoginViewController alloc] initWithNibName:@"FYLoginViewController" bundle:nil];

    FYBaseNavigationViewController *navController = [[FYBaseNavigationViewController alloc] initWithRootViewController:rootController];
    [self addChildViewController:navController];
    [self.view addSubview:navController.view];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
