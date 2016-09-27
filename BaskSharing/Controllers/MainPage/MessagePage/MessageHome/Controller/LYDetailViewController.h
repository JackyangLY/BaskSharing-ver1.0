//
//  QYDetailViewController.h
//  青云微博
//
//  Created by qingyun on 16/7/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//  微博详情

#import <UIKit/UIKit.h>

@class LYStatusModel;

@interface LYDetailViewController : UITableViewController

@property (nonatomic, strong) LYStatusModel *status;

@end
