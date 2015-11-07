//
//  FYBaseViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/9.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYBaseNavigationViewController.h"
#import "FYDeviceManagerViewController.h"

@interface FYBaseNavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation FYBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];

    UIColor *color = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationBar.titleTextAttributes = dict;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [[self topViewController] supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotate
{
    UIViewController *controller = self.topViewController;
    if ([controller isKindOfClass:[FYDeviceManagerViewController class]]) {
        return YES;
    }
    return NO;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self topViewController] preferredInterfaceOrientationForPresentation];
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
