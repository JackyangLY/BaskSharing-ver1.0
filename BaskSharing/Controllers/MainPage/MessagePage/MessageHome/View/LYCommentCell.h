//
//  QYCommentCell.h
//  青云微博
//
//  Created by qingyun on 16/7/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//  评论的cell

#import <UIKit/UIKit.h>

static CGFloat const CommentHeaderSpace = 20;

@class LYCommentModel;

@interface LYCommentCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) LYCommentModel *comment;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
