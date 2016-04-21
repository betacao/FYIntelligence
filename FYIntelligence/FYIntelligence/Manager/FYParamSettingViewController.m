//
//  FYParamSettingViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/13.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYParamSettingViewController.h"
#import "FYParamSettingTableViewCell.h"
#import "FYSDSSViewController.h"
#import "FYDSSSViewController.h"
#import "FYWKJSViewController.h"
#import "FYSDJRViewController.h"
#import "FYDSJRViewController.h"
#import "FYHWJRViewController.h"
#import "FYGDXHViewController.h"
#import "FYFDBHViewController.h"
#import "FYYSBJViewController.h"
#import "FYHSWViewController.h"
#import "FYWCXHViewController.h"

@interface FYParamSettingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *imageArray;

@end

@implementation FYParamSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"参数设置";
    if (self.devideType == DeviceTypeSun) {
        self.titleArray = @[@"手动上水",@"定时上水",@"温控进水",@"手动加热",@"定时加热",@"恒温加热",@"管道循环",@"防冻保护",@"预设报警",@"恒水位",@"集热器温差循环"];
        self.imageArray = @[@"sdss",@"dsss",@"wkjs",@"sdjr",@"dsjr",@"hwjr",@"gdxh",@"fdbh",@"ysbj",@"hsw",@"wcxh"];
    } else if (self.devideType == DeviceTypeAir) {
        self.titleArray = @[@"手动上水",@"定时上水",@"手动加热",@"定时加热",@"恒温加热",@"管道循环",@"预设报警",@"恒水位"];
        self.imageArray = @[@"sdss",@"dsss",@"sdjr",@"dsjr",@"hwjr",@"gdxh",@"ysbj",@"hsw"];
    }
    [self.tableView setTableFooterView:[[UIView alloc] init]];
}

- (void)backButtonClick:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FYParamSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FYParamSettingTableViewCell"];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FYParamSettingTableViewCell" owner:self options:nil] lastObject];
    }
    [cell loadCellTitle:[self.titleArray objectAtIndex:indexPath.row]];
    [cell loadCellImage:[UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [self.titleArray objectAtIndex:indexPath.row];
    [self didSelectViewController:title];

}

- (void)didSelectViewController:(NSString *)title
{
    if ([title isEqualToString:@"手动上水"]) {
        FYSDSSViewController *controller = [[FYSDSSViewController alloc] initWithNibName:@"FYSDSSViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    } else if ([title isEqualToString:@"定时上水"]) {
        FYDSSSViewController *controller = [[FYDSSSViewController alloc] initWithNibName:@"FYDSSSViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    } else if ([title isEqualToString:@"温控进水"]) {
        FYWKJSViewController *controller = [[FYWKJSViewController alloc] initWithNibName:@"FYWKJSViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    } else if ([title isEqualToString:@"手动加热"]) {
        FYSDJRViewController *controller = [[FYSDJRViewController alloc] initWithNibName:@"FYSDJRViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    } else if ([title isEqualToString:@"定时加热"]) {
        FYDSJRViewController *controller = [[FYDSJRViewController alloc] initWithNibName:@"FYDSJRViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    } else if ([title isEqualToString:@"恒温加热"]) {
        FYHWJRViewController *controller = [[FYHWJRViewController alloc] initWithNibName:@"FYHWJRViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    } else if ([title isEqualToString:@"管道循环"]) {
        FYGDXHViewController *controller = [[FYGDXHViewController alloc] initWithNibName:@"FYGDXHViewController" bundle:nil];
        controller.deviceName = self.devideType;
        [self.navigationController pushViewController:controller animated:YES];
    } else if ([title isEqualToString:@"防冻保护"]) {
        FYFDBHViewController *controller = [[FYFDBHViewController alloc] initWithNibName:@"FYFDBHViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    } else if ([title isEqualToString:@"预设报警"]) {
        FYYSBJViewController *controller = [[FYYSBJViewController alloc] initWithNibName:@"FYYSBJViewController" bundle:nil];
        controller.deviceName = self.devideType;
        [self.navigationController pushViewController:controller animated:YES];
    } else if ([title isEqualToString:@"恒水位"]) {
        FYHSWViewController *controller = [[FYHSWViewController alloc] initWithNibName:@"FYHSWViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    } else if ([title isEqualToString:@"集热器温差循环"]) {
        FYWCXHViewController *controller = [[FYWCXHViewController alloc] initWithNibName:@"FYWCXHViewController" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
