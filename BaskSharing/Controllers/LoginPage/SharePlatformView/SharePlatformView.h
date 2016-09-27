//
//  SharePlatformView.h
//  ZsfMall
//
//  Created by zsf on 16/6/22.
//  Copyright © 2016年 zsf. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickShareButtonBlock)(NSInteger tag);
@interface SharePlatformView : UIView
- (instancetype)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArray didShareButtonBlock:(ClickShareButtonBlock)saveBlock;
- (void)show;
@end
