//
//  ZFButton.h
//  ZFIsuueWeiboDemo
//
//  Created by 张锋 on 16/5/24.
//  Copyright © 2016年 张锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYButton.h"

@class LYWeiboButton;

@protocol ZFWeiboButtonDelegate <NSObject>
- (void)WeiboButtonClick:(LYWeiboButton *)button;
@end

@interface LYWeiboButton : UIView
@property (nonatomic, assign) NSInteger btnTag;
@property (nonatomic, weak) id <ZFWeiboButtonDelegate> delegate;
+ (LYWeiboButton *)buttonWithFrame:(CGRect)frame image:(NSString *)image title:(NSString *)title;

@end
