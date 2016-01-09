//
//  FYHeatCycleSettingViewController.m
//  FYIntelligence
//
//  Created by changxicao on 16/1/9.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "FYHeatCycleSettingViewController.h"
#import "FYParamSettingTableViewCell.h"
#import "FYHeatCycleHSWDViewController.h"
#import "FYHeatCycleHSSJViewController.h"
#import "FYHeatCycleJXSJViewController.h"
#import "FYHeatCycleSLJCViewController.h"
#import "FYHeatCycleSJDViewController.h"
#import "FYHeatCycleYXMSViewController.h"

@interface FYHeatCycleSettingViewController() <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *imageArray;

@end

@implementation FYHeatCycleSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"参数设置";
    self.titleArray = @[@"回水温度",@"回水时间",@"间隙时间",@"水流检测",@"时间段",@"运行模式"];
    self.imageArray = @[@"sdss",@"dsss",@"wkjs",@"sdjr",@"dsjr",@"hwjr"];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
}

- (void)backButtonClick:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    [self didSelectViewController:indexPath.row];

}

- (void)didSelectViewController:(NSInteger)index
{
    switch (index) {
        case 0:{
            FYHeatCycleHSWDViewController *controller = [[FYHeatCycleHSWDViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 1:{
            FYHeatCycleHSSJViewController *controller = [[FYHeatCycleHSSJViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 2:{
            FYHeatCycleJXSJViewController *controller = [[FYHeatCycleJXSJViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 3:{
            FYHeatCycleSLJCViewController *controller = [[FYHeatCycleSLJCViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 4:{
            FYHeatCycleSJDViewController *controller = [[FYHeatCycleSJDViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 5:{
            FYHeatCycleYXMSViewController *controller = [[FYHeatCycleYXMSViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;

        default:
            break;
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
