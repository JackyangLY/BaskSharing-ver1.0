//
//  RecommendCell.m
//  BaskSharing
//
//  Created by Yang on 8/31/16.
//  Copyright © 2016 Jack_yy. All rights reserved.
//

#import "recommendCell.h"
@interface recommendCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageUSerName;
@property (weak, nonatomic) IBOutlet UILabel *labelUSerName;
@property (weak, nonatomic) IBOutlet UIImageView *imageContent;
@property (weak, nonatomic) IBOutlet UILabel *LabelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;

@end
@implementation recommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
