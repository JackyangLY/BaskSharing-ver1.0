//
//  QYFooterView.h
//  青云微博
//
//  Created by qingyun on 16/7/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYStatusModel;

@interface LYFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) LYStatusModel *status;

+ (instancetype)footerViewWithTableView:(UITableView *)tableView;

@end
