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
#import "FYDeviceManagerViewController.h"
#import "FYDevice.h"

@interface FYListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) NSInteger deviceCount;
@property (strong, nonatomic) NSMutableArray *deviceArray;
@end

@implementation FYListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设备列表";
    self.deviceArray = [NSMutableArray array];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normalImage = [UIImage imageNamed:@"right_add"];
    [rightButton setImage:normalImage forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(gotoDeviceInitViewController) forControlEvents:UIControlEventTouchUpInside];
    [rightButton sizeToFit];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

    [self.tableView setTableFooterView:[[UIView alloc] init]];

    [self loadData];
}

- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [[FYTCPNetWork shareNetEngine] sendRequest:[NSString stringWithFormat:@"%@%@#",kListAddress,kAppDelegate.userName] complete:^(NSDictionary *dic) {
        NSString *string = [dic objectForKey:kResponseString];
        NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern: @"\\d+" options:0 error:nil];
        NSMutableArray *results = [NSMutableArray array];
        [regularExpression enumerateMatchesInString:string options:0 range:NSMakeRange(0, string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            [results addObject:result];
        }];
        NSComparator cmptr = ^(NSTextCheckingResult *obj1, NSTextCheckingResult *obj2){
            if (obj1.range.location > obj2.range.location) {
                return (NSComparisonResult)NSOrderedDescending;
            } else if (obj1.range.location < obj2.range.location) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        };
        NSArray *MResult = [results sortedArrayUsingComparator:cmptr];
        NSTextCheckingResult *result = [MResult firstObject];
        NSString *resultString = [string substringWithRange:result.range];
        weakSelf.deviceCount = [resultString integerValue];
        for (NSInteger i = 1; i <= (MResult.count - 1) / 3; i++) {
            FYDevice *device = [[FYDevice alloc] init];

            result = [MResult objectAtIndex:(i * 3 - 2)];
            device.deviceID = [string substringWithRange:result.range];

            result = [MResult objectAtIndex:(i * 3 - 1)];
            device.deviceTD = (FYDeviceType)[[string substringWithRange:result.range] integerValue];

            result = [MResult objectAtIndex:(i * 3)];
            device.deviceCondition = (FYDeviceCondition)[[string substringWithRange:result.range] integerValue];

            [self.deviceArray addObject:device];
        }
        [weakSelf.tableView reloadData];
        NSLog(@"%@",weakSelf.deviceArray);
    }];
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
    return self.deviceCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FYListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FYListTableViewCell"];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FYListTableViewCell" owner:self options:nil] lastObject];
    }
    FYDevice *device = [self.deviceArray objectAtIndex:indexPath.row];
    [cell loadDataWithDevice:device];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FYDeviceManagerViewController *controller = [[FYDeviceManagerViewController alloc] initWithNibName:@"FYDeviceManagerViewController" bundle:nil];
    FYBaseNavigationViewController *nav = [[FYBaseNavigationViewController alloc] initWithRootViewController:controller];
    FYDevice *device = [self.deviceArray objectAtIndex:indexPath.row];
    kAppDelegate.deviceID = device.deviceID;
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark FYEnterPINDelegate

- (void)didEnterAllPIN:(NSString *)pinNumber
{
    FYDeviceManagerViewController *controller = [[FYDeviceManagerViewController alloc] initWithNibName:@"FYDeviceManagerViewController" bundle:nil];
    FYBaseNavigationViewController *nav = [[FYBaseNavigationViewController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
