//
//  MineCell.m
//  BaskSharing
//
//  Created by Yang on 8/26/16.
//  Copyright © 2016 Jack_yy. All rights reserved.
//

#import "MineCell.h"
@interface MineCell()
@property (weak, nonatomic) IBOutlet UIImageView *userName;

@end
@implementation MineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *dataImage  =[user objectForKey:@"userImage"];
    _userName.image = [UIImage imageWithData:dataImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
