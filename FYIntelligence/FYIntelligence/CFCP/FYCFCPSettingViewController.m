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
    [self.readButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.writeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.textColor = self.addressLabel.textColor = self.paramLabel.textColor = [UIColor whiteColor];
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
    .leftSpaceToView(self.scrollView, MarginFactor(90.0f))
    .topSpaceToView(self.paramField, MarginFactor(85.0f))
    .widthIs(MarginFactor(105.0f))
    .heightIs(MarginFactor(40.0f));

    self.writeButton.sd_layout
    .rightSpaceToView(self.scrollView, MarginFactor(90.0f))
    .topSpaceToView(self.paramField, MarginFactor(85.0f))
    .widthIs(MarginFactor(105.0f))
    .heightIs(MarginFactor(40.0f));

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
