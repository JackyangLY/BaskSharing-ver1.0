//
//  registerPageVC.m
//  BaskSharing
//
//  Created by 洋洋 on 16/8/17.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//注册密码
#import <AVOSCloud/AVOSCloud.h>
#import "registerPageVC.h"
#import "Common.h"
#import "IphoneRegisterView.h"
#import "EmailRegisterView.h"
#import "MainTabBarVC.h"

@interface registerPageVC ()



/**手机号 */
@property (weak, nonatomic) IBOutlet UITextField *textPhone;
/**验证码 */
@property (weak, nonatomic) IBOutlet UITextField *textTesting;
/**密码 */
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
/**确认密码*/
@property (weak, nonatomic) IBOutlet UITextField *textAgainPassword;

@property (nonatomic ,strong) UILabel *lblprompt;//提示框

@property (weak, nonatomic) EmailRegisterView *EmailView;
@property (weak, nonatomic) IphoneRegisterView *IphoneView;
@end

@implementation registerPageVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    AVUser *currentUser = [AVUser currentUser];
   // NSString *strEmailVerified = currentUser[@"emailVerified"];
    NSInteger emailVer = [currentUser[@"emailVerified"] integerValue];
    if (emailVer == 1)
    {
        MainTabBarVC *mainVC = [MainTabBarVC new];
        [self presentViewController:mainVC animated:YES completion:nil];
        
    }
    [self loadBasicSetting];
}
#pragma mark 加载默认设置
-(void)loadBasicSetting
{
    //[self.view setBackgroundColor:RandomColor];
    IphoneRegisterView *IphoneView = [IphoneRegisterView new];
    [self.view addSubview:IphoneView];
    [IphoneView setBackgroundColor:[UIColor whiteColor]];
    self.IphoneView = IphoneView;
      __weak typeof(self) weakSelf = self;
    [IphoneView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(weakSelf.view).mas_offset(200);
         make.leading.trailing.bottom.equalTo(self.view);
     }];
    EmailRegisterView *EmailView = [EmailRegisterView new];
    [self.view addSubview:EmailView];
    [self.view sendSubviewToBack:EmailView];
    [EmailView setBackgroundColor:[UIColor whiteColor]];
    self.EmailView = EmailView;
    [EmailView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(weakSelf.view).mas_offset(200);
         make.leading.trailing.bottom.equalTo(self.view);
     }];
       [self BtnClickRegisterAction];
    _EmailView.textpassword.secureTextEntry = YES;
    _EmailView.textagainpass.secureTextEntry = YES;
    
    _IphoneView.textpassword.secureTextEntry = YES;
    _IphoneView.textagainpass.secureTextEntry = YES;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_EmailView.textEmail resignFirstResponder];
    [_EmailView.textpassword resignFirstResponder];
    [_EmailView.textagainpass resignFirstResponder];
    [_IphoneView.textIPhone resignFirstResponder];
    [_IphoneView.textTesting resignFirstResponder];
    [_IphoneView.textpassword resignFirstResponder];
    [_IphoneView.textagainpass resignFirstResponder];
}
-(void)dismissCurrentView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)iphoneOrEamilAction:(UISegmentedControl *)SegmentedControl
{
    NSInteger index = SegmentedControl.selectedSegmentIndex;
    if (index == 1)
    {
        /**打印此方法*/
//        NSLog(@"%s\n邮箱注册",__func__);
        [self.view bringSubviewToFront:_EmailView];
        _EmailView.textEmail.text = nil;
        _EmailView.textpassword.text = nil;
        _EmailView.textagainpass.text = nil;
             }
    else
    {
        /**打印此方法*/
//        NSLog(@"%s\n手机注册",__func__);
        [self.view sendSubviewToBack:_EmailView];
        _IphoneView.textIPhone.text = nil;
        _IphoneView.textTesting.text = nil;
        _IphoneView.textpassword.text = nil;
        _IphoneView.textagainpass.text = nil;
               
    }

}
-(void)BtnClickRegisterAction
{
      //__weak typeof(self) weakSelf = self;
    _IphoneView.blockIphoneviewSecuritycode = ^(UIButton *button)
    {
        /**打印此方法*/
//        NSLog(@"%s",__func__);
        AVUser *user = [AVUser user];
        if (![_IphoneView.textIPhone.text isEqualToString:@""])
        {
            user.username = _IphoneView.textIPhone.text;
            user.password = _IphoneView.textpassword.text;
            //user.email = @"hang@leancloud.rocks";
            user.mobilePhoneNumber = _IphoneView.textIPhone.text;
            if (![user.mobilePhoneNumber isEqualToString:@""])
            {
                NSError *error = nil;
                //发送验证码
                [user signUp:&error];
//                NSLog(@"%s\n%@",__func__,error);
            }
        }
      
    };
    _IphoneView.blockIphoneviewPassValue = ^(UIButton *button)
    {
        
       
        [self BtnIphoneRegisterAction];
        
    };
    _EmailView.blockEmailViewPassValue = ^(UIButton *button)
    {
        /**打印此方法*/
//        NSLog(@"%s",__func__);
        [self BtnEmailRegisterAction];
        
    };

}
#pragma  mark 注册手机按钮
- (void)BtnIphoneRegisterAction
{
    /**手机号*/
    NSString *StrPhone = _IphoneView.textIPhone.text;
    NSString *StrTesting = _IphoneView.textTesting.text;
    NSString *StrPassword = _IphoneView.textpassword.text;
    NSString *StrAgainPW = _IphoneView.textagainpass.text;
    if (!StrTesting)
    {
        return;
        
    }
    else{
        
        if ([StrPhone isEqualToString:@""]||[StrPassword isEqualToString:@""]||[StrAgainPW isEqualToString:@""])
        {
//            NSLog(@"手机号或密码为空");
            [self ShowErrorString:@"手机号或密码为空"];
        }
        else if ([StrPassword isEqualToString:StrAgainPW])
        {
            if ([StrPhone isValidMobileNumber])
            {//判断为手机号
                
                if ([StrTesting isValidVerifyCode])
                {//是否为验证码
            [AVUser verifyMobilePhone:StrTesting withBlock:^(BOOL succeeded, NSError *error) {
                //验证结果
                if (succeeded)
                {
                    // 注册成功
//                    NSLog(@"手机注册成功");
                    /**弹框提示*/
                    __weak typeof(self) weakSelf = self;
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"手机注册提示:" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                        
                        MainTabBarVC *mainVC = [MainTabBarVC new];
                        [weakSelf presentViewController:mainVC animated:YES completion:nil];
                    }];
                    [alertVC addAction:action];
                    [self presentViewController:alertVC animated:YES completion:^{
                    }];
                    

//                    NSUserDefaults *userDdfaults = [NSUserDefaults standardUserDefaults];
//                    [userDdfaults setObject:StrPhone forKey:@"username"];
//                    [userDdfaults synchronize];
//                    
//                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    // 失败的原因可能有多种，常见的是用户名已经存在。
                    /**打印此方法*/
//                    NSLog(@"%s\n%@",__func__,error);
                    [self ShowErrorString:@"用户名有误"];
                }

            }];
        }
        //[AVOSCloud requestSmsCodeWithPhoneNumber:StrPhone callback:^(BOOL succeeded, NSError *error) {
        // 发送失败可以查看 error 里面提供的信息
        //  if (error)
        // {
        //NSLog(@"%s\n%@",__func__,error);
        //  }
        // }];
            }
            else
            {//手机验证码不正确
                /**打印此方法*/
//                NSLog(@"%s\n验证码错误",__func__);
                [UIView animateWithDuration:0.2 animations:^{
                   _lblprompt.text = @"验证码错误";
                    _lblprompt.textColor = [UIColor redColor];
                }];
            }
    }
        else
        {//手机号格式不正确
            /**打印此方法*/
//            NSLog(@"%s\n手机号格式不正确",__func__);
            [UIView animateWithDuration:0.2 animations:^{
                _lblprompt.text = @"登录失败，手机号格式不正确";
                _lblprompt.textColor = [UIColor redColor];
            }];
            
        }
  }
    
}
-(void)BtnEmailRegisterAction
{
    /**邮箱*/
    
    NSString *StrEmail = _EmailView.textEmail.text;
    NSString *StrPassword = _EmailView.textpassword.text;
    NSString *StrAgainPW = _EmailView.textagainpass.text;
    if ([StrEmail isEqualToString:@""]||[StrPassword isEqualToString:@""]||[StrAgainPW isEqualToString:@""])
    {
//        NSLog(@"邮箱或密码为空");
        [self ShowErrorString:@"邮箱或密码为空"];
    }
    else if([StrPassword isEqualToString:StrAgainPW])
    {
        if ([_EmailView.textEmail.text isValidEmail])
        {//为邮箱格式
        AVUser *user = [AVUser user];// 新建 AVUser 对象实例
        user.username = StrEmail;// 设置用户名
        user.password =  StrPassword;// 设置密码
        user.email = StrEmail;// 设置邮箱
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded)
            {
                // 注册成功
                /**弹框提示*/
                //__weak typeof(self) weakSelf = self;
//                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"邮箱注册提示:" message:@"验证消息发送成功" preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//                }];
//                [alertVC addAction:action];
//                [self presentViewController:alertVC animated:YES completion:^{
                
                    AVUser *currentUser = [AVUser currentUser];
                    NSString *strEmailVerified = currentUser[@"emailVerified"];
                    NSInteger emailVer = [currentUser[@"emailVerified"] integerValue];
//                    NSLog(@"%s---%@",__func__,strEmailVerified);
                    if (emailVer == 0)
                    {
//                        NSLog(@"未认证");
                        UIViewController *nullVC = [[UIViewController alloc]init];
                        nullVC.view.backgroundColor = [UIColor yellowColor];
                        UILabel *label = [[UILabel alloc]init];
                        label.text = [NSString stringWithFormat:@"请前往您的邮箱：\n%@",_EmailView.textEmail.text];
                        [nullVC.view addSubview:label];
                        [label mas_makeConstraints:^(MASConstraintMaker *make)
                         {
                             make.center.equalTo(nullVC.view);
                             
                         }];
                        [self.navigationController pushViewController: nullVC animated:YES];
                        
                    }
//                    else
//                    {
//                        MainTabBarVC *mainVC = [MainTabBarVC new];
//                        [self presentViewController:mainVC animated:YES completion:nil];
//                        
//                    }
//                }];


                
            } else {
                // 失败的原因可能有多种，常见的是用户名已经存在。
//                NSLog(@"用户名已存在%@",error);
                //重新验证邮箱
                [AVUser requestEmailVerify:StrEmail withBlock:^(BOOL succeeded, NSError *error)
                 {
                     if (succeeded) {
                         [self showAlterControllerWithString:@"邮箱注册提示:" titleWithMessage:@"请求重发验证邮件成功"];
                     }
                
                     else
                     {
                         [self showAlterControllerWithString:@"邮箱注册错误提示:" titleWithMessage:@"错误error"];
                     }
                 }];
            }
        }];
        
    }
    //[AVOSCloud requestSmsCodeWithPhoneNumber:StrPhone callback:^(BOOL succeeded, NSError *error) {
    // 发送失败可以查看 error 里面提供的信息
    //  if (error)
    // {
    //NSLog(@"%s\n%@",__func__,error);
    //  }
    // }];
    }
    else
    {//邮箱格式错误
        /**打印此方法*/
//        NSLog(@"%s\n邮箱格式不对",__func__);
//        [UIView animateWithDuration:0.2 animations:^{
//            _lblprompt.text = @"邮箱格式不正确";
//            _lblprompt.textColor = [UIColor redColor];
//        }];
//        [UIView animateWithDuration:0.6 animations:^{
//            _lblprompt.text = nil;
//        }];
        [self showAlterControllerWithString:@"邮箱注册提示：" titleWithMessage:@"邮箱格式不对"];
        
    }

}
-(void)showAlterControllerWithString :(NSString *)title titleWithMessage:(NSString *)message
{
    /**弹框提示*/
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}
#pragma mark 错误提示
-(void)ShowErrorString:(NSString *)error
{
    /**弹框提示*/
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"注册失败" message:error preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
    /**添加抖动动画*/
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.values = @[@-5,@0,@5,@0];
    shake.repeatCount = 3;
    shake.duration = 0.2;
    [self.view.layer addAnimation:shake forKey:nil];
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
