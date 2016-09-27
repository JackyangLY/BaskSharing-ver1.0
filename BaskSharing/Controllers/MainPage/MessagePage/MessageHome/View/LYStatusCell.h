//
//  QYStatusCell.h
//  青云微博
//
//  Created by qingyun on 16/7/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//  微博主页cell

#import <UIKit/UIKit.h>

@class LYStatusModel;
@class ShareModel;
@interface LYMessageCell : UITableViewCell
@property (nonatomic, strong) LYStatusModel *status;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
@interface LYStatusCell : UITableViewCell

@property (nonatomic ,strong) ShareModel *shares;

@property (nonatomic, strong) LYStatusModel *status;
/** 创建时间 */
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
/** 头像按钮 */
@property (weak, nonatomic) IBOutlet UIButton *btnHead;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end


