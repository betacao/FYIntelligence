//
//  FYCFCPViewController.m
//  FYIntelligence
//
//  Created by changxicao on 16/4/20.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "FYCFCPSettingViewController.h"

@interface FYCFCPSettingViewController ()<UITextFieldDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *paramLabel;
@property (weak, nonatomic) IBOutlet UIButton *readButton;
@property (weak, nonatomic) IBOutlet UIButton *writeButton;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UITextField *paramField;

@property (strong, nonatomic) UITextField *currentField;
@property (assign, nonatomic) NSInteger v1;
@property (assign, nonatomic) NSInteger v2;
@end

@implementation FYCFCPSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self addAutoLayout];
}

- (void)initView
{
    self.titleLabel.text = @"变频器高级参数设置";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.addressLabel.text = @"项目地址";
    self.paramLabel.text = @"项目参数";
    [self.readButton setTitle:@"读参数" forState:UIControlStateNormal];
    [self.writeButton setTitle:@"写参数" forState:UIControlStateNormal];
    [self.readButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.writeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.textColor = self.addressLabel.textColor = self.paramLabel.textColor = [UIColor whiteColor];

    self.readButton.layer.masksToBounds = YES;
    self.readButton.layer.cornerRadius = 3.0f;
    self.readButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.readButton.layer.borderWidth = 1.0f;

    self.writeButton.layer.masksToBounds = YES;
    self.writeButton.layer.cornerRadius = 3.0f;
    self.writeButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.writeButton.layer.borderWidth = 1.0f;

    self.titleLabel.font = BoldFontFactor(20.0f);
    self.addressLabel.font = self.paramLabel.font = BoldFontFactor(18.0f);
    self.addressField.backgroundColor = self.paramField.backgroundColor = [UIColor whiteColor];
}

- (void)addAutoLayout
{
    self.scrollView.sd_layout
    .spaceToSuperView(UIEdgeInsetsZero);
    self.scrollView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT + 1.0f);

    self.titleLabel.sd_layout
    .topSpaceToView(self.scrollView, MarginFactor(180.0f))
    .leftSpaceToView(self.scrollView, 0.0f)
    .rightSpaceToView(self.scrollView, 0.0f)
    .heightIs(self.titleLabel.font.lineHeight);

    self.addressLabel.sd_layout
    .topSpaceToView(self.titleLabel, MarginFactor(80.0f))
    .leftSpaceToView(self.scrollView, MarginFactor(36.0f))
    .heightIs(self.addressLabel.font.lineHeight);
    [self.addressLabel setSingleLineAutoResizeWithMaxWidth:SCREENWIDTH];

    self.paramLabel.sd_layout
    .topSpaceToView(self.addressLabel, MarginFactor(70.0f))
    .leftEqualToView(self.addressLabel)
    .heightIs(self.paramLabel.font.lineHeight);
    [self.paramLabel setSingleLineAutoResizeWithMaxWidth:SCREENWIDTH];

    self.addressField.sd_layout
    .leftSpaceToView(self.addressLabel, MarginFactor(9.0f))
    .centerYEqualToView(self.addressLabel)
    .heightIs(MarginFactor(36.0f))
    .rightSpaceToView(self.scrollView, MarginFactor(36.0f));

    self.paramField.sd_layout
    .leftEqualToView(self.addressField)
    .centerYEqualToView(self.paramLabel)
    .heightIs(MarginFactor(36.0f))
    .rightSpaceToView(self.scrollView, MarginFactor(36.0f));
    

    self.readButton.sd_layout
    .leftSpaceToView(self.scrollView, MarginFactor(80.0f))
    .topSpaceToView(self.paramField, MarginFactor(85.0f))
    .widthIs(MarginFactor(100.0f))
    .heightIs(MarginFactor(40.0f));

    self.writeButton.sd_layout
    .rightSpaceToView(self.scrollView, MarginFactor(80.0f))
    .topSpaceToView(self.paramField, MarginFactor(85.0f))
    .widthIs(MarginFactor(100.0f))
    .heightIs(MarginFactor(40.0f));

}
- (IBAction)readButtonClick:(id)sender
{
    NSString *string = [self.addressField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (string.length == 0) {
        [FYProgressHUD showMessageWithText:@"请输入项目地址"];
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *request = [NSString stringWithFormat:@"read_bpq_config$%@$", string];
        NSString *responseString = [[FYUDPNetWork sharedNetWork] sendMessage:request type:1];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"^" withString:@""];
        NSArray *array = [responseString componentsSeparatedByString:@"&"];
        [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 2) {
                self.v1 = [obj integerValue];
            } else if (idx == 3) {
                self.v2 = [obj integerValue];
            }
        }];
        self.v1 = self.v1<<8 + self.v2;
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.paramField.text = [NSString stringWithFormat:@"%ld", (long)self.v1];
        });
    });

}

- (IBAction)writeButtonClick:(id)sender
{
    NSString *address = [self.addressField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (address.length == 0) {
        [FYProgressHUD showMessageWithText:@"请输入项目地址"];
        return;
    }
    NSString *param = [self.paramField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (param.length == 0) {
        [FYProgressHUD showMessageWithText:@"请输入参数"];
        return;
    }

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *request = [NSString stringWithFormat:@"set_bpq_config$%@$%@$", address, param];
        NSString *responseString = [[FYUDPNetWork sharedNetWork] sendMessage:request type:1];
        responseString = [responseString stringByReplacingOccurrencesOfString:@"^" withString:@""];
        NSArray *array = [responseString componentsSeparatedByString:@"&"];
        if ([[array firstObject] isEqualToString:@"01"]) {
            [FYProgressHUD showMessageWithText:@"设置成功"];
        } else {
            [FYProgressHUD showMessageWithText:@"设置失败"];
        }
    });
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.currentField = textField;
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.currentField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
