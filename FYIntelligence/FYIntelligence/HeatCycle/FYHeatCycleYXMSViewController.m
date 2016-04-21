//
//  FYHeatCycleYXMSViewController.m
//  FYIntelligence
//
//  Created by changxicao on 16/1/9.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "FYHeatCycleYXMSViewController.h"


@interface FYHeatCycleYXMSViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UISwitch *switch2;

@end

@implementation FYHeatCycleYXMSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"运行模式";
    self.bgImageView.image = [UIImage imageNamed:@"rsxh_bj"];
    [self getInfo];
}

- (void)getInfo
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *responseString = [[FYUDPNetWork sharedNetWork] sendMessage:@"read_ryxms_config" type:1];
        if ([responseString containsString:@"OFF"]||[responseString containsString:@"ERROR"]) {
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern: @"\\w+" options:0 error:nil];
            NSMutableArray *results = [NSMutableArray array];
            [regularExpression enumerateMatchesInString:responseString options:0 range:NSMakeRange(0, responseString.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
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

            NSString *isOn1 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:0]).range];
            [self.switch1 setOn: [isOn1 isEqualToString:@"01"] ? YES : NO];


            NSString *isOn2 = [responseString substringWithRange:((NSTextCheckingResult *)[MResult objectAtIndex:1]).range];
            [self.switch2 setOn: [isOn2 isEqualToString:@"01"] ? YES : NO];

            
        });
    });
}

- (IBAction)sendMessage:(id)sender
{
    NSString *isOn1 = self.switch1.isOn ? @"01": @"00";
    NSString *isOn2 = self.switch2.isOn ? @"01": @"00";
    NSString *string = [NSString stringWithFormat:@"rconfig_yxms$%@$%@", isOn1, isOn2];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[FYUDPNetWork sharedNetWork] sendMessage:string type:1];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end