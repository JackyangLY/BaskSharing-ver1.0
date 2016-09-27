//
//  loginregisterTextField.m
//  BaskSharing
//
//  Created by Yang on 16/8/24.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//自定义Textfield


#import "loginregisterTextField.h"
static NSString *const LYplaceholderColorKey = @"placeholderLabel.textColor";
@interface loginregisterTextField()

@end
@implementation loginregisterTextField

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.tintColor = [UIColor cyanColor];
    self.textColor = [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:16];
//    //设置默认的占位符文字的颜色
//    [self setValue:[UIColor grayColor] forKeyPath:LYplaceholderColorKey];
//    [self addTarget:self action:@selector(EditingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
//    [self addTarget:self action:@selector(EventEditingDidEnd) forControlEvents:
//     UIControlEventEditingDidEnd];
//    UILabel *label = [self valueForKey:@"placeholderLabel"];
//    label.textColor = [UIColor orangeColor];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UILabel *label = self.subviews.lastObject;
//        label.textColor = [UIColor cyanColor];
//    });
    
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    attributes[NSForegroundColorAttributeName] = [UIColor grayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attributes];
//
    
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    attributes[NSForegroundColorAttributeName] = [UIColor yellowColor];
//    attributes[NSBackgroundColorAttributeName] = [UIColor redColor];
//    attributes[NSUnderlineStyleAttributeName] = @YES;
//    NSAttributedString *string = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attributes];
    //self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attributes];
}
#pragma  mark 开始编辑
//-(void)EditingDidBegin
//{
//    [self setValue:[UIColor blackColor] forKeyPath:LYplaceholderColorKey];
//
//}
//#pragma  mark 结束编辑
//-(void)EventEditingDidEnd
//{
//    [self setValue:[UIColor grayColor] forKeyPath:LYplaceholderColorKey];
//
//}
-(BOOL)becomeFirstResponder
{
    [self setValue:[UIColor blackColor] forKeyPath:LYplaceholderColorKey];

    return [super becomeFirstResponder];
}
-(BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:LYplaceholderColorKey];

    return [super resignFirstResponder];
}
//-(void)drawPlaceholderInRect:(CGRect)rect
//{
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    attributes[NSForegroundColorAttributeName] = [UIColor grayColor];
//    attributes[NSFontAttributeName] = self.font;
//    CGPoint placeholderPoint = CGPointMake(0, 0.5*(rect.size.height - self.font.lineHeight));
//    [self.placeholder drawAtPoint:placeholderPoint withAttributes:attributes];
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
