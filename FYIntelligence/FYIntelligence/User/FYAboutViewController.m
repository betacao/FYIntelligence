//
//  FYAboutViewController.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/20.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYAboutViewController.h"
#import "FYParamSettingTableViewCell.h"

@interface FYAboutViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;

@end

@implementation FYAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"关于";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.titleArray = @[@"服务热线:4006686046", @"官方网站:http://www.rc2004.com", @"版本信息：V1.0"];
}

- (void)backButtonClick:(UIButton *)button
{
    NSInteger count = self.navigationController.viewControllers.count;
    if (count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4006686046"]];
    } else if (indexPath.row == 1){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.rc2004.com"]];
    } else if (indexPath.row == 2){

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
