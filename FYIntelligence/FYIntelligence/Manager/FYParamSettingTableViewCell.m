//
//  FYParamSettingTableViewCell.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/13.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYParamSettingTableViewCell.h"

@interface FYParamSettingTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;

@end

@implementation FYParamSettingTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)loadCellTitle:(NSString *)title
{
    self.titleLabel.text = title;
//    [self.titleLabel sizeToFit];
}

- (void)loadCellImage:(UIImage *)image
{
    self.cellImageView.image = image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
