//
//  LoginPageVC.m
//  BaskSharing
//
//  Created by 洋洋 on 16/8/17.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//登录页面

#import <AudioToolbox/AudioToolbox.h>
#import "Common.h"
#import "LoginPageVC.h"
#import <Masonry/Masonry.h>
#import <AVOSCloud/AVOSCloud.h>
#import <LeanCloudSocial/AVUser+SNS.h>
#import "MainTabBarVC.h"
#import "MineVC.h"
#import "registerPageVC.h"
#import "ResetPasswordVC.h"
#import "SharePlatformView.h"
@interface LoginPageVC ()
/**用户名*/
@property (weak, nonatomic) IBOutlet UITextField *lblUserName;
/**密码*/
@property (weak, nonatomic) IBOutlet UITextField *lblPassWord;
/**背景View*/
@property (strong, nonatomic) IBOutlet UIView *backview;

/**提示框*/
@property (nonatomic,strong ) UILabel *lblprompt;
@end

@implementation LoginPageVC

-(void)viewWillAppear:(BOOL)animated
{
    
    self.lblUserName.text = nil;
    self.lblPassWord.text = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBasicSetting];
    self.title = @"登录";
    /**隐藏底部的工具条*/
    //self.hidesBottomBarWhenPushed = YES;
}
#pragma mark 加载默认设置
-(void)loadBasicSetting
{
    //  支持摇一摇  此处应该写在AppDelegate中,为粘贴代码方便写在这里
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    //  让此控制器成为第一响应者
    [self becomeFirstResponder];
    
    _lblprompt = [[UILabel alloc]init];
    [self.view addSubview:_lblprompt];
    [_lblprompt mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(_lblUserName);
        make.bottom.mas_equalTo(_lblUserName.mas_top).mas_offset(10);
        
    }];
    _lblPassWord.secureTextEntry = YES;//密文
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        // 注册成功
        /**弹框提示*/
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"登录提示:" message:@"注册成功，请登录你的账号" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];

    } else {
        //缓存用户对象为空时，可打开用户注册界面…
    }
//        UIButton *chookbutton = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:chookbutton];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self resignFirstResponder];
}
#pragma  mark 三方登录按钮
- (IBAction)OtherLoginBtnAction:(UIButton *)sender
{
    /**分享按钮*/
    //NSArray *imageArray = @[@"wechat",@"friendquan",@"qq",@"qqzone",@"weibo"];

    NSArray *imageArray = @[@"tabbar_compose_background_icon_close",@"qq",@"weibo"];
      __weak typeof(self) weakSelf = self;
    SharePlatformView *shareView = [[SharePlatformView alloc]initWithFrame:CGRectMake(0, 0, LYSCREEN_WIDTH, LYSCREEN_HEIGHT) ImageArray:imageArray didShareButtonBlock:^(NSInteger tag)
    {
//        NSLog(@"---- %ld",tag);
        [weakSelf buttonTagget:tag];
        
    }];
    [shareView show];

}

#pragma  mark 选择散开buttn的index
-(void)buttonTagget:(NSInteger )index
{
     if(index ==1)
    {//QQ
        if ([AVOSCloudSNS isAppInstalledForType:AVOSCloudSNSQQ])
        {
//            NSLog(@"%s/n已安装QQ",__func__);
            
            [AVOSCloudSNS loginWithCallback:^(id object, NSError *error)
                      {
                          if (!error)
                          {
                              NSDictionary *authData = object;
                            //为 AVUser 增加 authData
                    [AVUser loginWithAuthData:authData platform:AVOSCloudSNSPlatformQQ block:^(AVUser *user, NSError *error) {
                                  if (error)
                                  {
                                      // 登录失败，可能为网络问题或 authData 无效
                                      [self ShowErrorString:@"登录失败，可能为网络问题或 authData 无效"] ;                               } else
                                  {
                                      // 登录成功
                                      MainTabBarVC *mainVC = [MainTabBarVC new];
                                      [self presentViewController:mainVC animated:YES completion:nil];
                                  }
                              }];
                              
                          }
                          else
                          {
                              /**打印此方法*/
//                              NSLog(@"%s\n 错误提示%@",__func__,error);
                              [self ShowErrorString:@"错误error"];
                          }
                          
                      } toPlatform:AVOSCloudSNSQQ];

                 }
        else
        {
            /**打印此方法*/
//            NSLog(@"%s/n未安装QQ",__func__);
            // 登录失败，可能为网络问题或 authData 无效
//            [self ShowErrorString:@"登录失败，可能为网络问题或 authData 无效"];
            [AVOSCloudSNS loginWithCallback:^(id object, NSError *error)
             {
                 if (!error)
                 {
                     NSDictionary *authData = object;
                        //为 AVUser 增加 authData
                     [AVUser loginWithAuthData:authData platform:AVOSCloudSNSPlatformQQ block:^(AVUser *user, NSError *error) {
                         if (error)
                         {
                             // 登录失败，可能为网络问题或 authData 无效
                             [self ShowErrorString:@"登录失败，可能为网络问题或 authData 无效"];
                             
                         } else
                         {
                             // 登录成功
                             MainTabBarVC *mainVC = [MainTabBarVC new];
                             [self presentViewController:mainVC animated:YES completion:nil];
                         }
                     }];
                     
                 }
                 else
                 {
                     [self ShowErrorString:@"错误error"];
                 }
                 
             } toPlatform:AVOSCloudSNSQQ];
            
        }
    }
    else if(index == 2)
    {//新浪
        if ([AVOSCloudSNS isAppInstalledForType:AVOSCloudSNSSinaWeibo])
        {
            [AVOSCloudSNS loginWithCallback:^(id object, NSError *error)
                      {
                          if (!error)
                          {
                              NSDictionary *authData = object;
                              [[AVUser currentUser]setObject:authData[@"username"] forKey:[AVUser currentUser][@"name"]];
                              
                                /**三方登陆的信息*/
                              [AVUser loginWithAuthData:authData platform:AVOSCloudSNSPlatformWeiBo block:^(AVUser *user, NSError *error) {
                                  if (error)
                                  {
                                      // 登录失败，可能为网络问题或 authData 无效
                                      [self ShowErrorString:@"登录失败，可能为网络问题或 authData 无效"];
                                  } else
                                  {
                                      // 登录成功
                                      MainTabBarVC *mainVC = [MainTabBarVC new];
                                      [self presentViewController:mainVC animated:YES completion:^{
                                          [self showAlterControllerWithString:@"登录提示：" titleWithMessage:@"登陆成功"];
                                      }];                                                                        }
                              }];
                          }
                          else
                          {
                              [self ShowErrorString:@"失败"];
                          }
                          
                      } toPlatform:AVOSCloudSNSSinaWeibo];
        }
        else
        {
            /**打印此方法*/
//            NSLog(@"%s/n未安装微博",__func__);
            [AVOSCloudSNS loginWithCallback:^(id object, NSError *error)
             {
                if (!error)
                          {
                              NSDictionary *authData = object;
                              /**三方登陆的信息*/
                              [AVUser loginWithAuthData:authData platform:AVOSCloudSNSPlatformWeiBo block:^(AVUser *user, NSError *error)
                              {
                                  if (error)
                                  {
                                      [self ShowErrorString:@"登录失败，可能为网络问题或 authData 无效"];
                                  }
                                  else
                                  {
                                      // 登录成功
                                      MainTabBarVC *mainVC = [MainTabBarVC new];
                                      [self presentViewController:mainVC animated:YES completion:^{
                                          [self showAlterControllerWithString:@"登录提示：" titleWithMessage:@"登陆成功"];
                                      }];
                                  }
                              }];
                          }
                          else
                          {
                              [self showAlterControllerWithString:@"登录提示：" titleWithMessage:@"获取信息失败"];
                          }
                          
             } toPlatform:AVOSCloudSNSSinaWeibo];
        }
    }
    
}
#pragma  mark 登录按钮
- (IBAction)loginBtnAction:(UIButton *)button
{
    [self.view endEditing:YES];
    
      /**取出用户名和密码*/
    NSString *strUserName = self.lblUserName.text;
    NSString *strPassWord = self.lblPassWord.text;
    if ([strUserName isEqualToString:@""]||[strPassWord isEqualToString:@""])
    {
        [self ShowErrorString:@"用户名或密码为空"];
        return;
     }
     else
    {
        /**保存使用异步*/
        [AVUser logInWithUsernameInBackground:self.lblUserName.text password:self.lblPassWord.text block:^(AVUser *user, NSError *error) {
            if (user)
            {
                MainTabBarVC *mainVC = [MainTabBarVC new];
                [self presentViewController:mainVC animated:YES completion:^{
                    [self showAlterControllerWithString:@"登录提示：" titleWithMessage:@"登录成功"];
                }];
            }
            else
            {
                [self ShowErrorString:@"用户名或密码错误"];
            }
        }];
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
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"登录失败" message:error preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
  
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.values = @[@-5,@0,@5,@0];
    shake.repeatCount = 3;
    shake.duration = 0.2;
    [self.view.layer addAnimation:shake forKey:nil];
}

#pragma  mark 重置密码
/**重置密码按钮*/
- (IBAction)BtnResetPassWordAction:(UIButton *)button
{
    
    ResetPasswordVC *resetPWVC = [ResetPasswordVC new];
    //[self presentViewController:resetPWVC animated:YES completion:nil];
     [self.navigationController pushViewController:resetPWVC animated:YES];
    
}
#pragma  mark 注册页面
/**注册按钮*/
- (IBAction)BnRegiseterVCAction:(UIButton *)button
{
    registerPageVC *registerVC = [registerPageVC new];
    //[self presentViewController:registerVC animated:YES completion:nil];
     [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_lblPassWord resignFirstResponder];
    [_lblUserName resignFirstResponder];
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
