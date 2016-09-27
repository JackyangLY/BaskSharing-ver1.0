//
//  UITextField+LYExtxtension.m
//  BaskSharing
//
//  Created by Yang on 16/8/25.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//封装自定义输入框

#import "UITextField+LYExtxtension.h"
static NSString *const LYplaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (LYExtxtension)
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    
    //提前设置占位文字
    NSString *oldplaceholderColor = self.placeholder;
    self.placeholder  = @"";
    self.placeholder = oldplaceholderColor;
//    if (self.placeholder.length == 0)
//    {
//        self.placeholder = @" ";
//    }
    [self setValue:placeholderColor forKeyPath:LYplaceholderColorKey];
    
    
}
-(UIColor *)placeholderColor
{
    return [self valueForKeyPath:LYplaceholderColorKey];
}

@end
