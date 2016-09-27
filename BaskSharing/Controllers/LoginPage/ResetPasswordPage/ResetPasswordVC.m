//
//  ResetPasswordVC.m
//  BaskSharing
//
//  Created by 洋洋 on 16/8/17.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//密码重置

#import "Common.h"
#import "ResetPasswordVC.h"
#import "ResetEmailPassword.h"
@interface ResetPasswordVC ()
@property (nonatomic ,strong) UITextField *textIPhone;
@property (nonatomic ,strong) UITextField *textpassword;
@property (nonatomic ,strong) UITextField *textTesting;
//计时器总时间
@property (nonatomic , assign) NSInteger count;
//计时器
@property (nonatomic , strong) NSTimer *stimer;

@property (nonatomic, strong) UIButton *Secucode;//右侧验证码

@end

@implementation ResetPasswordVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBasicSetting];
}
#pragma mark 加载默认设置
-(void)loadBasicSetting
{
    self.navigationItem.title = @"重置手机密码";
    //[self.view setBackgroundColor:RandomColor];
    /**手机*/
    UILabel *lblIPhone = [[UILabel alloc]init];
    [self.view addSubview:lblIPhone];
    lblIPhone.text = @"手机号码:";
    [lblIPhone mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.view).mas_offset(LYSCREEN_HEIGHT/2- LYSCREEN_WIDTH/2);
         make.leading.equalTo(self.view).mas_offset(LYSCREEN_WIDTH/8);
     }];
    UITextField *textIPhone = [[UITextField alloc]init];
    _textIPhone = textIPhone;
    textIPhone.borderStyle =  UITextBorderStyleRoundedRect;
    [self.view addSubview:textIPhone];
    [textIPhone mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(lblIPhone);
         make.leading.equalTo(lblIPhone.mas_trailing).mas_offset(8);
         make.width.mas_equalTo(TextFeildWidth);
         make.height.mas_equalTo(30);
     }];
    /**验证码*/
    UILabel *lblTesting = [[UILabel alloc]init];
    [self.view addSubview:lblTesting];
    lblTesting.text = @"验证码:";
    [lblTesting mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.trailing.equalTo(lblIPhone);
         make.top.equalTo(lblIPhone.mas_bottom).offset(32);
     }];
    
    UITextField *textTesting = [[UITextField alloc]init];
    textTesting.borderStyle =  UITextBorderStyleRoundedRect;
    [self.view addSubview:textTesting];
    _textTesting = textTesting;
    [textTesting mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(textIPhone.mas_bottom).offset(20);
         make.leading.equalTo(textIPhone.mas_leading);
         make.width.mas_equalTo(textIPhone).multipliedBy(0.5);
         make.height.mas_equalTo(textIPhone);
     }];
    /**验证码按钮*/
    UIButton *btnTesting = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btnTesting];
    _Secucode = btnTesting;
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
    
    /**新密码*/
    UILabel *lblPassword = [[UILabel alloc]init];
    lblPassword.text = @"新密码:";
    [self.view addSubview:lblPassword];
    [lblPassword mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.trailing.equalTo(lblTesting);
         make.top.equalTo(lblTesting.mas_bottom).offset(32);
     }];
    UITextField *textpassword = [[UITextField alloc]init];
    textpassword.borderStyle =  UITextBorderStyleRoundedRect;
    [self.view addSubview:textpassword];
    _textpassword = textpassword;
    [textpassword mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(textTesting.mas_bottom).offset(20);
         make.leading.equalTo(textTesting.mas_leading);
         make.width.mas_equalTo(textIPhone);
         make.height.mas_equalTo(textTesting);
     }];
    /**邮箱重置密码按钮*/
    UIButton *btnEmail = [[UIButton alloc]init];
    [self.view addSubview:btnEmail];
    btnEmail.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnEmail setBackgroundColor:[UIColor orangeColor]];
    [btnEmail mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(textpassword.mas_bottom).offset(25);
         make.trailing.equalTo(textpassword);
         make.width.mas_equalTo(textpassword).multipliedBy(0.5);
         make.height.mas_equalTo(textpassword);
     }];
    [btnEmail setTitle:@"邮箱重置密码>>" forState:UIControlStateNormal];
    [btnEmail addTarget:self action:@selector(gotoResetEmailPassword:) forControlEvents:UIControlEventTouchUpInside];

    
    /**重置密码*/
    UIButton *btnRegister = [[UIButton alloc]init];
    [self.view addSubview:btnRegister];
    [btnRegister setBackgroundColor:[UIColor brownColor]];
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(btnEmail.mas_bottom).offset(25);
         make.leading.equalTo(textpassword);
         make.width.mas_equalTo(textpassword);
         make.height.mas_equalTo(btnEmail);
     }];
    [btnRegister setTitle:@"重置密码" forState:UIControlStateNormal];
    [btnRegister addTarget:self action:@selector(ClickResetBtnPhonePassword) forControlEvents:UIControlEventTouchUpInside];

    
    
}
#pragma  mark 验证码
-(void)ClickSecuritycodeAction:(UIButton *)button
{
    NSString *strPhone = _textIPhone.text;
    if (![strPhone isEqualToString:@""])
    {
        [AVUser requestPasswordResetWithPhoneNumber:_textIPhone.text block:^(BOOL succeeded, NSError *error) {
            if (succeeded)
            {
                /**弹框提示*/
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"手机重置密码提示:" message:@"发送验证码成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alertVC addAction:action];
                  __weak typeof(self) weakSelf = self;
                [self presentViewController:alertVC animated:YES completion:^{
                    [weakSelf gainsecucode];
                }];

                
            } else {
                NSLog(@"%s===%@",__func__,error);
                
            }
        }];
        
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
        NSMutableString *nsmu = [NSMutableString stringWithFormat:@"%lus重新获取 ",_count];
        [_Secucode setTitle:nsmu forState:UIControlStateDisabled];
    }
}

- (void )gainsecucode//验证码 显示
{
    _count = 60;
    _stimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(numbertime:) userInfo:nil repeats:YES];
    
}
#pragma  mark 手机密码重置
-(void)ClickResetBtnPhonePassword
{
    if (![_textTesting.text isEqualToString:@""]||![_textIPhone.text isEqualToString:@""]||![_textpassword.text isEqualToString:@""])
    {
        
        [AVUser resetPasswordWithSmsCode:_textTesting.text newPassword:_textpassword.text block:^(BOOL succeeded, NSError *error) {
            if (succeeded)
            {
                /**弹框提示*/
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"手机重置密码提示:" message:@"密码重置成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alertVC addAction:action];
                [self presentViewController:alertVC animated:YES completion:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            else
            {
                NSLog(@"%s===%@",__func__,error);
                
                
            }
        }];
    }
    else
    {
        NSLog(@"您输入的内容有误");
        /**弹框提示*/
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"手机重置密码提示::" message:@"您输入的内容有误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
        

    }
    
}
#pragma  mark 前往邮箱重置密码
-(void)gotoResetEmailPassword:(UIButton *)button
{
    ResetEmailPassword *resetEmailVC = [[ResetEmailPassword alloc]init];
    [self.navigationController pushViewController:resetEmailVC animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
