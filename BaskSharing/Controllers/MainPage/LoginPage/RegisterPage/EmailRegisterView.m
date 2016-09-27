//
//  ZhuceView.m
//  BaskSharing
//
//  Created by 洋洋 on 16/8/19.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//
#import "Common.h"
#import "EmailRegisterView.h"

@implementation EmailRegisterView


/**纯代码创建时加载*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]  )
    {
        [self loadBasicSetting];
    }
    return self;
}
/**创建Xib时加载*/
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self loadBasicSetting];
    }
    return self;
}
/**加载默认设置UI*/
-(void)loadBasicSetting
{
    /**邮箱*/
    UILabel *lblEmail = [[UILabel alloc]init];
    [self addSubview:lblEmail];
    lblEmail.text = @"邮箱:";
      __weak typeof(self) weakSelf = self;
    [lblEmail mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(weakSelf).mas_offset(8);
        //make.leading.equalTo(weakSelf).mas_offset(90);
        make.centerX.equalTo(weakSelf).mas_offset(-65);

    }];
    UITextField *textEmail = [[UITextField alloc]init];
    self.textEmail = textEmail;
    textEmail.borderStyle =  UITextBorderStyleRoundedRect;
    [self addSubview:textEmail];
    [textEmail mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(lblEmail);
        make.leading.equalTo(lblEmail.mas_trailing).mas_offset(8);
        make.width.mas_equalTo(LYSCREEN_WIDTH/2);
        make.height.mas_equalTo(30);
    }];

    /**密码*/
    UILabel *lblPassword = [[UILabel alloc]init];
    lblPassword.text = @"密码:";
    [self addSubview:lblPassword];
    [lblPassword mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.trailing.equalTo(lblEmail);
        make.top.equalTo(lblEmail.mas_bottom).offset(32);
    }];
    UITextField *textpassword = [[UITextField alloc]init];
    self.textpassword = textpassword;
    textpassword.borderStyle =  UITextBorderStyleRoundedRect;
    [self addSubview:textpassword];
    [textpassword mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(textEmail.mas_bottom).offset(20);
         make.leading.equalTo(textEmail.mas_leading);
         make.width.mas_equalTo(textEmail);
         make.height.mas_equalTo(textEmail);
     }];
    /**再次输入密码*/
    UILabel *lblagainpass = [[UILabel alloc]init];
    [self addSubview:lblagainpass];
    lblagainpass.text = @"确认密码:";
    [lblagainpass mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.trailing.equalTo(lblPassword);
         make.top.equalTo(lblPassword.mas_bottom).offset(32);
     }];
    UITextField *textagainpass= [[UITextField alloc]init];
    self.textagainpass=textagainpass;
    textagainpass.borderStyle =  UITextBorderStyleRoundedRect;
    [self addSubview:textagainpass];
    [textagainpass mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(textpassword.mas_bottom).offset(20);
         make.leading.equalTo(textpassword.mas_leading);
         make.width.mas_equalTo(textpassword);
         make.height.mas_equalTo(textpassword);
     }];
    
    /**注册*/
    UIButton *btnRegister = [[UIButton alloc]init];
    [self addSubview:btnRegister];
    [btnRegister setBackgroundColor:[UIColor cyanColor]];
    [btnRegister setTitle:@"注册" forState:UIControlStateNormal];
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.equalTo(textagainpass.mas_bottom).offset(25);
        make.leading.equalTo(textagainpass).mas_offset(-30);
        make.width.mas_equalTo(TextFeildWidth);
        make.height.mas_equalTo(textagainpass);
    }];
    [btnRegister addTarget:self action:@selector(ClickEmailRegisterViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)ClickEmailRegisterViewBtnAction:(UIButton *)button
{
    if (self.blockEmailViewPassValue)
    {
        self.blockEmailViewPassValue(button);
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
