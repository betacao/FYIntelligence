//
//  FYDeviceInitViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/11.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYDeviceInitViewController.h"
#import "FYAddDeviceViewController.h"
#import "FYJoinNetViewController.h"

@interface FYDeviceInitViewController ()

@end

@implementation FYDeviceInitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备初始化";
}

- (IBAction)joinNet:(UIButton *)sender {
    FYJoinNetViewController *controller = [[FYJoinNetViewController alloc] initWithNibName:@"FYJoinNetViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)deviceLogin:(UIButton *)sender {
    FYAddDeviceViewController *controller = [[FYAddDeviceViewController alloc] initWithNibName:@"FYAddDeviceViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
