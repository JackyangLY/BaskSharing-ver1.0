//
//  IphoneRegisterView.m
//  BaskSharing
//
//  Created by 洋洋 on 16/8/19.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//
#import "Common.h"
#import "IphoneRegisterView.h"
@interface IphoneRegisterView()

//计时器总时间
@property (nonatomic , assign) NSInteger count;
//计时器
@property (nonatomic , strong) NSTimer *stimer;
@property (nonatomic, strong) UIButton *Secucode;//右侧验证码
@end
@implementation IphoneRegisterView
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
    /**手机*/
    UILabel *lblIPhone = [[UILabel alloc]init];
    [self addSubview:lblIPhone];
    lblIPhone.text = @"手机:";
      __weak typeof(self) weakSelf = self;
    [lblIPhone mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(weakSelf).mas_offset(8);
         //make.leading.equalTo(weakSelf).mas_offset(90);
         make.centerX.equalTo(weakSelf).mas_offset(-65);
     }];
    UITextField *textIPhone = [[UITextField alloc]init];
    self.textIPhone = textIPhone;
    textIPhone.borderStyle =  UITextBorderStyleRoundedRect;
    [self addSubview:textIPhone];
    [textIPhone mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(lblIPhone);
         make.leading.equalTo(lblIPhone.mas_trailing).mas_offset(8);
         make.width.mas_equalTo(TextFeildWidth);
         make.height.mas_equalTo(30);
     }];
    /**验证码*/
    UILabel *lblTesting = [[UILabel alloc]init];
    [self addSubview:lblTesting];
    lblTesting.text = @"验证码:";
    [lblTesting mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.trailing.equalTo(lblIPhone);
        make.top.equalTo(lblIPhone.mas_bottom).offset(32);
    }];
    UITextField *textTesting = [[UITextField alloc]init];
    self.textTesting = textTesting;
    textTesting.borderStyle =  UITextBorderStyleRoundedRect;
    [self addSubview:textTesting];
    [textTesting mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(textIPhone.mas_bottom).offset(20);
         make.leading.equalTo(textIPhone.mas_leading);
         make.width.mas_equalTo(textIPhone).multipliedBy(0.5);
         make.height.mas_equalTo(textIPhone);
     }];
    /**验证码按钮*/
    UIButton *btnTesting = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btnTesting];
    _Secucode = btnTesting ;
    btnTesting.backgroundColor = [UIColor cyanColor];
    [btnTesting setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btnTesting mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.leading.equalTo(textTesting.mas_trailing);
         make.width.mas_equalTo(LYSCREEN_WIDTH/4);
         make.height.mas_equalTo(30);
         make.top.equalTo(textTesting);
         
     }];
    btnTesting.titleLabel.font = [UIFont systemFontOfSize:15];
    btnTesting.layer.borderColor = [UIColor blueColor].CGColor;
    btnTesting.layer.borderWidth = 1.0;
    btnTesting.layer.cornerRadius = 5.0;
    [btnTesting addTarget:self action:@selector(ClickSecuritycodeAction:) forControlEvents:UIControlEventTouchUpInside];

    /**密码*/
    UILabel *lblPassword = [[UILabel alloc]init];
    lblPassword.text = @"密码:";
    [self addSubview:lblPassword];
    [lblPassword mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.trailing.equalTo(lblTesting);
         make.top.equalTo(lblTesting.mas_bottom).offset(32);
     }];
    UITextField *textpassword = [[UITextField alloc]init];
    self.textpassword = textpassword;
    textpassword.borderStyle =  UITextBorderStyleRoundedRect;
    [self addSubview:textpassword];
    [textpassword mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(textTesting.mas_bottom).offset(20);
         make.leading.equalTo(textTesting.mas_leading);
         make.width.mas_equalTo(textIPhone);
         make.height.mas_equalTo(textTesting);
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
    self.textagainpass = textagainpass;
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
    [btnRegister setBackgroundColor:[UIColor brownColor]];
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(textagainpass.mas_bottom).offset(30);
         make.leading.equalTo(textagainpass).mas_offset(-25);
         make.width.mas_equalTo(textagainpass);
         make.height.mas_equalTo(textagainpass);
     }];
    [btnRegister setTitle:@"注册" forState:UIControlStateNormal];
    [btnRegister addTarget:self action:@selector(ClickIphoneRegisterViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)ClickSecuritycodeAction:(UIButton *)button
{
    if (![self.textIPhone.text isEqualToString:@""])
    {
        [self gainsecucode];
        if (self.blockIphoneviewSecuritycode)
        {
            self.blockIphoneviewSecuritycode(button);
        }
    }
}
- (void)numbertime:(NSTimer *)time //验证码 计时器
{
    _count --;
    if (_count <=0)
    {
        _Secucode.enabled = YES;
        _count=60;
        [_stimer invalidate];
    }
    else
    {
        _Secucode.enabled = NO;
        NSMutableString *nsmu = [NSMutableString stringWithFormat:@"%lus重新获取 ",(long)_count];
        [_Secucode setTitle:nsmu forState:UIControlStateDisabled];
    }
}
- (void )gainsecucode //验证码 显示
{
    _count = 60;
    _stimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(numbertime:) userInfo:nil repeats:YES];
    
}
-(void)ClickIphoneRegisterViewBtnAction:(UIButton *)button
{
    if (self.blockIphoneviewPassValue)
    {
        self.blockIphoneviewPassValue(button);
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
