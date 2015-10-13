//
//  FYListViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/11.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYListViewController.h"
#import "FYListTableViewCell.h"
#import "FYDeviceInitViewController.h"
#import "FYEnterPINViewController.h"
#import "FYDeviceManagerViewController.h"

@interface FYListViewController ()<UITableViewDataSource,UITableViewDelegate,FYEnterPINDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation FYListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备列表";
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = [UIImage imageNamed:@"right_add"];
    [rightButton setImage:normalImage forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(gotoDeviceInitViewController) forControlEvents:UIControlEventTouchUpInside];
    [rightButton sizeToFit];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

    [self.tableView setTableFooterView:[[UIView alloc] init]];
}

- (void)gotoDeviceInitViewController
{
    FYDeviceInitViewController *controller = [[FYDeviceInitViewController alloc] initWithNibName:@"FYDeviceInitViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FYListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FYListTableViewCell"];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FYListTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FYEnterPINViewController *controller = [[FYEnterPINViewController alloc] initWithNibName:@"FYEnterPINViewController" bundle:nil];
    controller.delegate = self;
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
}

#pragma mark FYEnterPINDelegate

- (void)didEnterAllPIN:(NSString *)pinNumber
{
    FYDeviceManagerViewController *controller = [[FYDeviceManagerViewController alloc] initWithNibName:@"FYDeviceManagerViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
