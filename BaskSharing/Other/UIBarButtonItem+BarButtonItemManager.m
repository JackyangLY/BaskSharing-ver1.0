//
//  UIBarButtonItem+BarButtonItemManager.m
//  BaskSharing
//
//  Created by 洋洋 on 16/8/19.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//封装自定义的UIBarButtonItem

#import "UIBarButtonItem+BarButtonItemManager.h"
@implementation UIBarButtonItem (BarButtonItemManager)
+(instancetype)BarButtonItemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end
