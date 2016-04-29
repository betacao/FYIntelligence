//
//  FYCFCPViewController.m
//  FYIntelligence
//
//  Created by changxicao on 16/4/22.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "FYCFCPViewController.h"
#import "FYCFCPAboutViewController.h"

@interface FYCFCPViewController ()<UIScrollViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
{
    NSThread *thread;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UITextField *firstField;
@property (weak, nonatomic) IBOutlet UITextField *secondField;
@property (weak, nonatomic) IBOutlet UITextField *thirdField;
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
@property (weak, nonatomic) IBOutlet UIButton *fourthButton;
@property (weak, nonatomic) IBOutlet UIButton *fifthButton;
@property (weak, nonatomic) IBOutlet UIButton *sixthButton;
@property (weak, nonatomic) IBOutlet UIButton *seventhButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) UITextField *currentField;
@property (strong, nonatomic) NSString *intValue;
@property (strong, nonatomic) NSString *decimalValue;
@property (assign, nonatomic) NSInteger p1;
@property (assign, nonatomic) NSInteger p2;

@property (assign, nonatomic) BOOL isShowView;
@property (assign, nonatomic) BOOL userTouched;
@end

@implementation FYCFCPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self addAutoLayout];
    self.isShowView = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.isShowView = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.isShowView = NO;
}



- (void)initView
{

    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView:)];
    [self.scrollView addGestureRecognizer:recognizer];

    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0f, MarginFactor(120.0f), MarginFactor(30.0f))];
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0f, MarginFactor(120.0f), MarginFactor(30.0f))];
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0f, MarginFactor(120.0f), MarginFactor(30.0f))];
    self.firstField.leftView = leftView1;
    self.secondField.leftView = leftView2;
    self.thirdField.leftView = leftView3;
    self.firstField.leftViewMode = UITextFieldViewModeAlways;
    self.secondField.leftViewMode = UITextFieldViewModeAlways;
    self.thirdField.leftViewMode = UITextFieldViewModeAlways;

    self.firstField.font = self.secondField.font = self.thirdField.font = BoldFontFactor(15.0f);

}

- (void)addAutoLayout
{
    self.scrollView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    self.imageView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);

    self.titleImageView.sd_layout
    .leftSpaceToView(self.scrollView, 0.0f)
    .rightSpaceToView(self.scrollView, 0.0f)
    .topSpaceToView(self.scrollView, MarginFactor(90.0f))
    .heightIs(MarginFactor(30.0f));

    self.firstField.sd_layout
    .centerYEqualToView(self.scrollView)
    .topSpaceToView(self.titleImageView, MarginFactor(100.0f))
    .widthIs(MarginFactor(230.0f))
    .heightIs(MarginFactor(30.0f));

    self.secondField.sd_layout
    .leftEqualToView(self.firstField)
    .topSpaceToView(self.firstField, MarginFactor(32.0f))
    .widthIs(MarginFactor(230.0f))
    .heightIs(MarginFactor(30.0f));

    self.thirdField.sd_layout
    .leftEqualToView(self.firstField)
    .topSpaceToView(self.secondField, MarginFactor(32.0f))
    .widthIs(MarginFactor(230.0f))
    .heightIs(MarginFactor(30.0f));

    self.secondButton.sd_layout
    .centerXEqualToView(self.scrollView)
    .topSpaceToView(self.thirdField, MarginFactor(50.0f))
    .heightIs(MarginFactor(29.0f))
    .widthIs(MarginFactor(100.0f));

    self.firstButton.sd_layout
    .rightSpaceToView(self.secondButton, MarginFactor(10.0f))
    .topEqualToView(self.secondButton)
    .widthRatioToView(self.secondButton, 1.0f)
    .heightRatioToView(self.secondButton, 1.0f);

    self.thirdButton.sd_layout
    .leftSpaceToView(self.secondButton, MarginFactor(10.0f))
    .topEqualToView(self.secondButton)
    .widthRatioToView(self.secondButton, 1.0f)
    .heightRatioToView(self.secondButton, 1.0f);

    self.fourthButton.sd_layout
    .leftEqualToView(self.firstButton)
    .topSpaceToView(self.firstButton, MarginFactor(42.0f))
    .widthIs(MarginFactor(70.0f))
    .heightEqualToWidth();

    self.fifthButton.sd_layout
    .leftSpaceToView(self.fourthButton, MarginFactor(25.0f))
    .centerYEqualToView(self.fourthButton)
    .widthIs(MarginFactor(50.0f))
    .heightEqualToWidth();

    self.sixthButton.sd_layout
    .leftSpaceToView(self.fifthButton, MarginFactor(25.0f))
    .centerYEqualToView(self.fourthButton)
    .widthIs(MarginFactor(50.0f))
    .heightEqualToWidth();

    self.seventhButton.sd_layout
    .rightEqualToView(self.thirdButton)
    .centerYEqualToView(self.fourthButton)
    .widthIs(MarginFactor(64.0f))
    .heightIs(MarginFactor(33.0f));

    [self.scrollView setupAutoContentSizeWithBottomView:self.fourthButton bottomMargin:MarginFactor(90.0f)];

}

- (void)setIsShowView:(BOOL)isShowView
{
    BOOL new = isShowView;
    BOOL old = _isShowView;
    if (new && !old) {
        thread = [[NSThread alloc] initWithTarget:self selector:@selector(getInfo) object:nil];
        [thread start];
    } else if (!new) {
        [thread cancel];
    }
    _isShowView = isShowView;
}

- (void)getInfo
{
    __weak typeof(self) weakSelf = self;
    while (1) {
        if ([NSThread currentThread].isCancelled) {
            break;
        } else {
            NSString *responseString = [[FYUDPNetWork sharedNetWork] sendMessage:@"read_bpq_info" type:0];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf AnalyticalData:responseString];
            });
            [NSThread sleepForTimeInterval:25.0f];
        }
    }

}

- (void)AnalyticalData:(NSString *)responseString
{
    [self.firstButton setImage:[UIImage imageNamed:@"bpqqsbh"] forState:UIControlStateNormal];
    [self.secondButton setImage:[UIImage imageNamed:@"bpqbpgz"] forState:UIControlStateNormal];
    [self.thirdButton setImage:[UIImage imageNamed:@"bpqcgqgz"] forState:UIControlStateNormal];

    responseString = [responseString stringByReplacingOccurrencesOfString:@"^" withString:@""];
    NSArray *array = [responseString componentsSeparatedByString:@"&"];
    [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            if ([obj integerValue] == 1) {
                [self.thirdButton setImage:[UIImage imageNamed:@"bpqcgqgzon"] forState:UIControlStateNormal];
            } else if ([obj integerValue] == 2) {
                [self.secondButton setImage:[UIImage imageNamed:@"bpqbpgzon"] forState:UIControlStateNormal];
            } else if ([obj integerValue] == 3) {
                [self.secondButton setImage:[UIImage imageNamed:@"bpqbpgzon"] forState:UIControlStateNormal];
                [self.thirdButton setImage:[UIImage imageNamed:@"bpqcgqgzon"] forState:UIControlStateNormal];
            } else if ([obj integerValue] == 4) {
                [self.firstButton setImage:[UIImage imageNamed:@"bpqqsbhon"] forState:UIControlStateNormal];
            } else if ([obj integerValue] == 5) {
                [self.firstButton setImage:[UIImage imageNamed:@"bpqqsbhon"] forState:UIControlStateNormal];
                [self.thirdButton setImage:[UIImage imageNamed:@"bpqcgqgzon"] forState:UIControlStateNormal];
            } else if ([obj integerValue] == 6) {
                [self.firstButton setImage:[UIImage imageNamed:@"bpqqsbhon"] forState:UIControlStateNormal];
                [self.secondButton setImage:[UIImage imageNamed:@"bpqbpgzon"] forState:UIControlStateNormal];
            } else if ([obj integerValue] == 7) {
                [self.firstButton setImage:[UIImage imageNamed:@"bpqqsbhon"] forState:UIControlStateNormal];
                [self.secondButton setImage:[UIImage imageNamed:@"bpqbpgzon"] forState:UIControlStateNormal];
                [self.thirdButton setImage:[UIImage imageNamed:@"bpqcgqgzon"] forState:UIControlStateNormal];
            }
        } else if (idx == 1) {
            self.intValue = obj;
        } else if (idx == 2) {
            self.decimalValue = obj;
        } else if (idx == 3 && !self.userTouched) {
            self.p1 = [obj integerValue];
            NSString *string = [NSString stringWithFormat:@"%.2f", [obj integerValue] / 100.0f];
            self.secondField.text = [string stringByAppendingString:@"Mpa"];
        } else if (idx == 4) {
            self.p2 = [obj integerValue];
            NSString *string = [NSString stringWithFormat:@"%.2f", [obj integerValue] / 100.0f];
            self.thirdField.text = [string stringByAppendingString:@"Mpa"];
        }
    }];
    self.firstField.text = [NSString stringWithFormat:@"%@.%@Hz", self.intValue, self.decimalValue];
}

- (IBAction)settingButtonClick:(id)sender
{
    NSString *string = [NSString stringWithFormat:@"设定压力为%.2fMpa？", self.p1 / 100.0f];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (IBAction)upButtonClick:(id)sender
{
    self.userTouched = YES;
    self.p1++;
    if (self.p1 > 60) {
        self.p1 = 60;
        [FYProgressHUD showMessageWithText:@"超过设定压力上限"];
    }
    NSString *string = [NSString stringWithFormat:@"%.2f", self.p1 / 100.0f];
    self.secondField.text = [string stringByAppendingString:@"Mpa"];
}

- (IBAction)downButtonClick:(id)sender
{
    self.userTouched = YES;
    self.p1--;
    if (self.p1 < 0) {
        self.p1 = 0;
        [FYProgressHUD showMessageWithText:@"低于设定压力下限"];
    }
    NSString *string = [NSString stringWithFormat:@"%.2f", self.p1 / 100.0f];
    self.secondField.text = [string stringByAppendingString:@"Mpa"];
}

- (IBAction)aboutButtonClick:(id)sender
{
    FYCFCPAboutViewController *controller = [[FYCFCPAboutViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currentField = textField;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)tapScrollView:(UITapGestureRecognizer *)recognizer
{
    [self.currentField resignFirstResponder];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.currentField resignFirstResponder];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

            NSString *string = [NSString stringWithFormat:@"bpq_sdyl$%ld$", (long)self.p1];
            NSString *responseString = [[FYUDPNetWork sharedNetWork] sendMessage:string type:0];
            responseString = [responseString stringByReplacingOccurrencesOfString:@"^" withString:@""];
            NSArray *array = [responseString componentsSeparatedByString:@"&"];
            if ([[array firstObject] isEqualToString:@"01"]) {
                [FYProgressHUD showMessageWithText:@"设定成功"];
            } else {
                [FYProgressHUD showMessageWithText:@"设定失败"];
            }
        });
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
