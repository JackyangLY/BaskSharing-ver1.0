//
//  UIView+LYExtension.m
//  BaskSharing
//
//  Created by 洋洋 on 16/8/20.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//自定义view

#import "UIView+LYExtension.h"

@implementation UIView (LYExtension)
-(CGFloat)LY_wideth
{
    return self.frame.size.width;
}
-(CGFloat)LY_height
{
    return self.frame.size.height;
}
-(void)setLY_wideth:(CGFloat)LY_wideth
{
    CGRect frame = self.frame;
    frame.size.width = LY_wideth;
    self.frame = frame;
}
-(void)setLY_height:(CGFloat)LY_height
{
    CGRect frame = self.frame;
    frame.size.height = LY_height;
    self.frame = frame;
}
-(CGFloat)LY_X
{
    return self.frame.origin.x;
}
-(CGFloat)LY_Y
{
    return self.frame.origin.y;
}
-(void)setLY_X:(CGFloat)LY_X
{
    CGRect frame = self.frame;
    frame.origin.x = LY_X;
    self.frame = frame;
}
-(void)setLY_Y:(CGFloat)LY_Y
{
    CGRect frame = self.frame;
    frame.origin.y = LY_Y;
    self.frame = frame;
}

@end
