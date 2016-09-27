//
//  UIBarButtonItem+BarButtonItemManager.h
//  BaskSharing
//
//  Created by 洋洋 on 16/8/19.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BarButtonItemManager)
+(instancetype)BarButtonItemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target  action:(SEL)action;
@end
