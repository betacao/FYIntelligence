//
//  FYCFCPViewController.m
//  FYIntelligence
//
//  Created by changxicao on 16/4/22.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "FYCFCPViewController.h"
#import "FYCFCPAboutViewController.h"

@interface FYCFCPViewController ()<UIScrollViewDelegate, UITextFieldDelegate>

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
@end

@implementation FYCFCPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self addAutoLayout];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
