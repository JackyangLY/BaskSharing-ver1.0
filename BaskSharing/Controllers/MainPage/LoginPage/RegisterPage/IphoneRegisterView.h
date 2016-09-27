//
//  IphoneRegisterView.h
//  BaskSharing
//
//  Created by 洋洋 on 16/8/19.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IphoneRegisterView : UIView
typedef void(^BlockIphoneRegisterViewSecuritycode)(UIButton *button);
typedef void(^BlockIphoneRegisterViewPassValue)(UIButton *button);
/**手机输入框*/
@property (nonatomic,strong)UITextField *textIPhone;
/**手机验证码输入框*/
@property (nonatomic,strong)UITextField *textTesting;
/**手机密码输入框*/
@property (nonatomic,strong)UITextField *textpassword;
/**手机密码再次输入框*/
@property (nonatomic,strong)UITextField *textagainpass;
/**验证码按钮*/
@property (nonatomic,copy)BlockIphoneRegisterViewSecuritycode blockIphoneviewSecuritycode;
/**注册按钮*/
@property (nonatomic,copy)BlockIphoneRegisterViewPassValue blockIphoneviewPassValue;

@end
