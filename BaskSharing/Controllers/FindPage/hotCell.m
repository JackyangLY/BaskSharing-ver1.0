//
//  hotTableViewCell.m
//  BaskSharing
//
//  Created by Yang on 8/28/16.
//  Copyright © 2016 Jack_yy. All rights reserved.
//

#import "hotCell.h"
@interface hotCell ()

@property (weak, nonatomic) IBOutlet UIImageView *BackImageView;
@property (weak, nonatomic) IBOutlet UILabel *LabelTitle;

@property (weak, nonatomic) IBOutlet UILabel *LabelBrowse;
@end
@implementation hotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
