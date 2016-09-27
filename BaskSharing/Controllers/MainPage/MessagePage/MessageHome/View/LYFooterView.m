//
//  QYFooterView.m
//  青云微博
//
//  Created by qingyun on 16/7/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "LYFooterView.h"
#import "LYStatusModel.h"

@implementation LYFooterView
{
    __weak IBOutlet UIView *_viewBg;
    __weak IBOutlet UIButton *_btnComment;
    __weak IBOutlet UIButton *_btnPraise;
    __weak IBOutlet UIButton *_btnRetweet;
}

+ (instancetype)footerViewWithTableView:(UITableView *)tableView {
    static NSString *strId = @"LYFooterView";
    LYFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:strId];
    if (footer == nil) {
        footer = [[[NSBundle mainBundle] loadNibNamed:@"LYFooterView" owner:nil options:nil] firstObject];
        [footer setValue:strId forKey:@"reuseIdentifier"];
    }
    
    return footer;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // 当从xib启动时候, 如果重写方法中outlet还没有被赋值
    // 一定要想到awakeFromNib
}

- (void)setStatus:(LYStatusModel *)status {
    _status = status;
    
    // 如果这个数字大于0 , 显示这个数字, 否则显示原有的转发, 赞, 评论
//    [self loadTitle:@"转发" count:status.repostsCount forButton:_btnRetweet];
//    [self loadTitle:@"评论" count:status.commentsCount forButton:_btnComment];
//    [self loadTitle:@"点赞" count:status.attitudesCount forButton:_btnPraise];
}

- (void)loadTitle:(NSString *)title count:(NSInteger)count forButton:(UIButton *)button {
    if (count == 0) {
        [button setTitle:title forState:UIControlStateNormal];
    } else {
        [button setTitle:[NSString stringWithFormat:@"%ld", count] forState:UIControlStateNormal];
    }
}

//- (void)didMoveToWindow {
//    [self sendSubviewToBack:_viewBg];
//    
//    //NSTimer *timer;
//    //// 设置计时器触发的日期在很久很久很久之后(你的应用不可能活到那个时候的)
//    //[timer setFireDate:[NSDate distantFuture]];
//    //// 设置现在就开始计时
//    //[timer setFireDate:[NSDate date]];
//}

@end
