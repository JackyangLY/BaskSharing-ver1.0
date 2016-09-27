//
//  ZhuceView.h
//  BaskSharing
//
//  Created by 洋洋 on 16/8/19.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface EmailRegisterView : UIView
typedef void(^BlockEmailRegisterViewPassValue)(UIButton *button);
/**邮箱输入框*/
@property (nonatomic,strong) UITextField *textEmail;
/**邮箱密码输入框*/
@property (nonatomic,strong) UITextField *textpassword;
/**邮箱密码再次输入框*/
@property (nonatomic,strong) UITextField *textagainpass;

@property (nonatomic,copy)BlockEmailRegisterViewPassValue blockEmailViewPassValue;
@end
