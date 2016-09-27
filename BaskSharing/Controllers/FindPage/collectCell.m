//
//  collectCell.m
//  BaskSharing
//
//  Created by Yang on 8/31/16.
//  Copyright © 2016 Jack_yy. All rights reserved.
//

#import "collectCell.h"
@interface collectCell()
@property (weak, nonatomic) IBOutlet UILabel *LabelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageUserName;
@property (weak, nonatomic) IBOutlet UILabel *LabelName;
@property (weak, nonatomic) IBOutlet UILabel *LabelAttention;

@end
@implementation collectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
