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
#import "FYConfigViewController.h"
#import "FYDevice.h"
#import "FYConfigViewController.h"
#import "FYHeatCycleViewController.h"

@interface FYListViewController ()<UITableViewDataSource,UITableViewDelegate, FYListDelegate, FYConfigDelegate>
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
    UIImage *rightImage = [UIImage imageNamed:@"right_add"];
    [rightButton setImage:rightImage forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(gotoDeviceInitViewController) forControlEvents:UIControlEventTouchUpInside];
    [rightButton sizeToFit];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];


    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *leftImage = [UIImage imageNamed:@"reload"];
    [leftButton setImage:leftImage forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton sizeToFit];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];

    [self loadData];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [[FYTCPNetWork shareNetEngine] sendRequest:[NSString stringWithFormat:@"%@%@#",kListAddress,kAppDelegate.userID] complete:^(NSDictionary *dic) {
        NSString *string = [dic objectForKey:kResponseString];
        NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern: @"\\w+" options:0 error:nil];
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
        [weakSelf.deviceArray removeAllObjects];

        NSInteger total = [[string substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:1]).range] integerValue];

        for (NSInteger i = 0; i < total; i++) {
            FYDevice *device = [[FYDevice alloc] init];

            result = [MResult objectAtIndex:i * 3 + 2];
            device.deviceID = [string substringWithRange:result.range];

            result = [MResult objectAtIndex:i * 3 + 3];
            device.deviceName = (FYDeviceType)[[string substringWithRange:result.range] integerValue];

            result = [MResult objectAtIndex:i * 3 + 4];
            device.deviceCondition = (FYDeviceCondition)[[string substringWithRange:result.range] integerValue];

            [weakSelf.deviceArray addObject:device];
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

- (void)leftButtonClick:(UIButton *)button
{
    [self loadData];
}

#pragma mark tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deviceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FYListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FYListTableViewCell"];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FYListTableViewCell" owner:self options:nil] lastObject];
    }
    cell.delegate = self;
    FYDevice *device = [self.deviceArray objectAtIndex:indexPath.row];
    [cell loadDataWithDevice:device];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FYDevice *device = [self.deviceArray objectAtIndex:indexPath.row];
    if (device.deviceName == DeviceTypeSun || device.deviceName == DeviceTypeAir) {
        FYDeviceManagerViewController *controller = [[FYDeviceManagerViewController alloc] initWithNibName:@"FYDeviceManagerViewController" bundle:nil];
        FYBaseNavigationViewController *nav = [[FYBaseNavigationViewController alloc] initWithRootViewController:controller];
        kAppDelegate.deviceID = device.deviceID;
        [self presentViewController:nav animated:YES completion:nil];
    } else{
        FYHeatCycleViewController *controller = [[FYHeatCycleViewController alloc] init];
        kAppDelegate.deviceID = device.deviceID;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)clickCongfigButton:(FYDevice *)device
{
    FYConfigViewController *controller = [[FYConfigViewController alloc] initWithNibName:@"FYConfigViewController" bundle:nil];
    controller.deviceID = device.deviceID;
    controller.delegate = self;
    [self addChildViewController:controller];
    controller.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:controller.view];
}

#pragma mark FYEnterPINDelegate

- (void)didEnterAllPIN:(NSString *)pinNumber
{
    FYDeviceManagerViewController *controller = [[FYDeviceManagerViewController alloc] initWithNibName:@"FYDeviceManagerViewController" bundle:nil];
    FYBaseNavigationViewController *nav = [[FYBaseNavigationViewController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)didDeleteDevice:(NSString *)deviceID
{
    for (FYDevice *device in self.deviceArray){
        if ([device.deviceID isEqualToString:deviceID]) {
            [self.deviceArray removeObject:device];
            break;
        }
    }
    [self.tableView reloadData];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
