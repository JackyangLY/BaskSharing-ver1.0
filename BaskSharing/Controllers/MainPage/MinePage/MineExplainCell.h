//
//  MineExplainCell.h
//  BaskSharing
//
//  Created by Yang on 8/26/16.
//  Copyright © 2016 Jack_yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineExplainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *Age;
@property (weak, nonatomic) IBOutlet UILabel *email;

@property (nonatomic ,copy) void(^blockselectionSexAction)(NSInteger index);

+(instancetype)cellWithTableview: (UITableView *)tableview;
@end
