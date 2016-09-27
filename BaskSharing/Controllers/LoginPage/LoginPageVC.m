//
//  LoginPageVC.m
//  BaskSharing
//
//  Created by 洋洋 on 16/8/17.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//登录页面
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
        UIButton *chookbutton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:chookbutton];
}
#pragma  mark 三方登录按钮
- (IBAction)OtherLoginBtnAction:(UIButton *)sender
{
    /**分享按钮*/
    //NSArray *imageArray = @[@"wechat",@"friendquan",@"qq",@"qqzone",@"weibo"];

    NSArray *imageArray = @[@"wechat",@"qq",@"weibo"];
      __weak typeof(self) weakSelf = self;
    SharePlatformView *shareView = [[SharePlatformView alloc]initWithFrame:CGRectMake(0, 0, LYSCREEN_WIDTH, LYSCREEN_HEIGHT) ImageArray:imageArray didShareButtonBlock:^(NSInteger tag)
    {
        NSLog(@"---- %ld",tag+1);
        [weakSelf buttonTagget:tag+1];
        
    }];
    [shareView show];

    
}

#pragma  mark 选择散开buttn的index
-(void)buttonTagget:(NSInteger )index
{
    
    if (index == 1)
    {//微信
        if ([AVOSCloudSNS isAppInstalledForType:AVOSCloudSNSWeiXin])
        {
            [AVOSCloudSNS loginWithCallback:^(id object, NSError *error)
            {
                if (!error)
                {
                    
                }
                else
                {
                    /**打印此方法*/
                    NSLog(@"%s\n 错误提示%@",__func__,error);
                    
                   
                }
                
            } toPlatform:AVOSCloudSNSWeiXin];
        }
        else
        {
            /**打印此方法*/
            NSLog(@"%s/n未安装微信",__func__);
            
             [AVOSCloudSNS loginWithCallback:^(id object, NSError *error)
            {
                if (!error)
                {
                    
                }
                else
                {
                    /**打印此方法*/
                    NSLog(@"%s\n 错误提示%@",__func__,error);
                    
                    
                }
                
            } toPlatform:AVOSCloudSNSWeiXin];
        }
        
        
    }
    else if(index ==2)
    {//QQ
        if ([AVOSCloudSNS isAppInstalledForType:AVOSCloudSNSQQ])
        {
            NSLog(@"%s/n已安装QQ",__func__);
            
            [AVOSCloudSNS loginWithCallback:^(id object, NSError *error)
             {
                 if (!error)
                 {
                     
                 }
                 else
                 {
                     /**打印此方法*/
                     NSLog(@"%s\n 错误提示%@",__func__,error);
                     
                 }
                 
             } toPlatform:AVOSCloudSNSQQ];
        }
        else
        {
            /**打印此方法*/
            NSLog(@"%s/n未安装QQ",__func__);
            
            [AVOSCloudSNS loginWithCallback:^(id object, NSError *error)
             {
                 if (!error)
                 {
                     NSDictionary *authData = object;
                     /**三方登陆的信息*/
                     /**{
                      "access_token" = CFC1A1EF4BF8F9FC6AE43DB6283218EF;
                      avatar = "http://q.qlogo.cn/qqapp/100537582/66C60B3079DDB5F96F84F4BE5F30B7C9/100";头像
                      "expires_at" = "2016-11-30 13:22:54 +0000";
                      id = 66C60B3079DDB5F96F84F4BE5F30B7C9;
                      platform = 2;
                      "raw-user" =     {
                      city = "\U4fe1\U9633";
                      figureurl = "http://qzapp.qlogo.cn/qzapp/100537582/66C60B3079DDB5F96F84F4BE5F30B7C9/30";
                      "figureurl_1" = "http://qzapp.qlogo.cn/qzapp/100537582/66C60B3079DDB5F96F84F4BE5F30B7C9/50";
                      "figureurl_2" = "http://qzapp.qlogo.cn/qzapp/100537582/66C60B3079DDB5F96F84F4BE5F30B7C9/100";
                      "figureurl_qq_1" = "http://q.qlogo.cn/qqapp/100537582/66C60B3079DDB5F96F84F4BE5F30B7C9/40";
                      "figureurl_qq_2" = "http://q.qlogo.cn/qqapp/100537582/66C60B3079DDB5F96F84F4BE5F30B7C9/100";
                      gender = "\U7537";
                      "is_lost" = 0;
                      "is_yellow_vip" = 0;
                      "is_yellow_year_vip" = 0;
                      level = 0;
                      msg = "";
                      nickname = "\U0782";
                      openid = 66C60B3079DDB5F96F84F4BE5F30B7C9;
                      province = "\U6cb3\U5357";
                      ret = 0;
                      vip = 0;
                      year = 1994;
                      "yellow_vip_level" = 0;
                      };
                      username = "\U0782";//用户名
                      }
*/
                     //为 AVUser 增加 authData
                     [AVUser loginWithAuthData:authData platform:AVOSCloudSNSPlatformQQ block:^(AVUser *user, NSError *error) {
                         if (error)
                         {
                             // 登录失败，可能为网络问题或 authData 无效
                         } else
                         {
                             // 登录成功
                             MainTabBarVC *mainVC = [MainTabBarVC new];
                             [self presentViewController:mainVC animated:YES completion:nil];
//                             NSUserDefaults  *userDefaults = [NSUserDefaults standardUserDefaults];
//                             NSString *username = authData[@"username"];
//                             [userDefaults setObject:username forKey:@"username"];
//                             //保存
//                             [userDefaults synchronize];
                         }
                     }];

                 }
                 else
                 {
                     /**打印此方法*/
                     NSLog(@"%s\n 错误提示%@",__func__,error);
                 }
                 
             } toPlatform:AVOSCloudSNSQQ];
        }

    }
    else if(index == 3)
    {//新浪
        if ([AVOSCloudSNS isAppInstalledForType:AVOSCloudSNSSinaWeibo])
        {
            [AVOSCloudSNS loginWithCallback:^(id object, NSError *error)
             {
                 if (!error)
                 {
                     
                 }
                 else
                 {
                     /**打印此方法*/
                     NSLog(@"%s\n 错误提示%@",__func__,error);
                 }
                 
             } toPlatform:AVOSCloudSNSSinaWeibo];
        }
        else
        {
            /**打印此方法*/
            NSLog(@"%s/n未安装微博",__func__);
            
            [AVOSCloudSNS loginWithCallback:^(id object, NSError *error)
             {
                 if (!error)
                 {
                     NSDictionary *authData = object;
                     /**{
                      "access_token" = "2.00rCYWBE0mBAV5bc6ac193f1rfFxvD";
                      avatar = "http://tva1.sinaimg.cn/crop.18.40.272.272.180/dbc425c9jw1ed1y9l3qq0j20aa0cdta4.jpg";
                      "expires_at" = "2016-10-01 18:59:39 +0000";
                      id = 3687065033;
                      platform = 1;
                      "raw-user" =     {
                      "allow_all_act_msg" = 0;
                      "allow_all_comment" = 1;
                      "avatar_hd" = "http://tva1.sinaimg.cn/crop.18.40.272.272.1024/dbc425c9jw1ed1y9l3qq0j20aa0cdta4.jpg";
                      "avatar_large" = "http://tva1.sinaimg.cn/crop.18.40.272.272.180/dbc425c9jw1ed1y9l3qq0j20aa0cdta4.jpg";
                      "bi_followers_count" = 10;
                      "block_app" = 0;
                      "block_word" = 0;
                      city = 1000;
                      class = 1;
                      "created_at" = "Fri Dec 27 11:51:59 +0800 2013";
                      "credit_score" = 80;
                      description = "";
                      domain = "";
                      "favourites_count" = 1;
                      "follow_me" = 0;
                      "followers_count" = 16;
                      following = 0;
                      "friends_count" = 47;
                      gender = m;
                      "geo_enabled" = 1;
                      id = 3687065033;
                      idstr = 3687065033;
                      lang = "zh-cn";
                      location = "\U5176\U4ed6";
                      mbrank = 0;
                      mbtype = 0;
                      name = "Jackson__Yang";
                      "online_status" = 0;
                      "pagefriends_count" = 1;
                      "profile_image_url" = "http://tva1.sinaimg.cn/crop.18.40.272.272.50/dbc425c9jw1ed1y9l3qq0j20aa0cdta4.jpg";
                      "profile_url" = "u/3687065033";
                      province = 100;
                      ptype = 0;
                      remark = "";
                      "screen_name" = "Jackson__Yang";
                      star = 0;
                      status =         {
                      "attitudes_count" = 0;
                      "biz_feature" = 0;
                      "comments_count" = 0;
                      "created_at" = "Thu Sep 01 08:53:43 +0800 2016";
                      "darwin_tags" =             (
                      );
                      favorited = 0;
                      geo = "<null>";
                      "gif_ids" = "";
                      hasActionTypeCard = 0;
                      "hot_weibo_tags" =             (
                      );
                      id = 4014820338215521;
                      idstr = 4014820338215521;
                      "in_reply_to_screen_name" = "";
                      "in_reply_to_status_id" = "";
                      "in_reply_to_user_id" = "";
                      isLongText = 0;
                      "is_show_bulletin" = 2;
                      mid = 4014820338215521;
                      mlevel = 0;
                      "pic_urls" =             (
                      );
                      "positive_recom_flag" = 0;
                      "reposts_count" = 0;
                      source = "<a href=\"http://app.weibo.com/t/feed/6vtZb0\" rel=\"nofollow\">\U5fae\U535a weibo.com</a>";
                      "source_allowclick" = 0;
                      "source_type" = 1;
                      text = "//@\U53f6\U5b64\U57ce___: \U8f6c\U53d1\U5fae\U535a";
                      "text_tag_tips" =             (
                      );
                      truncated = 0;
                      userType = 0;
                      visible =             {
                      "list_id" = 0;
                      type = 0;
                      };
                      };
                      "statuses_count" = 26;
                      urank = 6;
                      url = "";
                      "user_ability" = 0;
                      verified = 0;
                      "verified_reason" = "";
                      "verified_reason_url" = "";
                      "verified_source" = "";
                      "verified_source_url" = "";
                      "verified_trade" = "";
                      "verified_type" = "-1";
                      weihao = "";
                      };
                      username = "Jackson__Yang";
                      }*/
                     /**三方登陆的信息*/
                     [AVUser loginWithAuthData:authData platform:AVOSCloudSNSPlatformWeiBo block:^(AVUser *user, NSError *error) {
                         if (error)
                         {
                             // 登录失败，可能为网络问题或 authData 无效
                         } else
                         {
                             // 登录成功
                             /**打印此方法*/
                             NSLog(@"%s\n登录成功",__func__);
                             MainTabBarVC *mainVC = [MainTabBarVC new];
                             [self presentViewController:mainVC animated:YES completion:nil];
                             NSUserDefaults  *userDefaults = [NSUserDefaults standardUserDefaults];
                             NSString *username = authData[@"username"];
                             [userDefaults setObject:username forKey:@"username"];
                             //保存
                             [userDefaults synchronize];

                            
                         }
                     }];
                 }
                 else
                 {
                     /**打印此方法*/
                     NSLog(@"%s\n 错误提示%@",__func__,error);
                     
                     
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
        /**打印此方法*/
        NSLog(@"%s\n用户名或密码为空",__func__);
        [self ShowErrorString:@"用户名或密码为空"];
        return;
     }
     else
    {
        /**保存使用异步*/
        [AVUser logInWithUsernameInBackground:self.lblUserName.text password:self.lblPassWord.text block:^(AVUser *user, NSError *error) {
            if (user)
            {
                /**打印此方法*/
                NSLog(@"%s\n登录成功",__func__);
                MainTabBarVC *mainVC = [MainTabBarVC new];
                [self presentViewController:mainVC animated:YES completion:nil];
                //NSUserDefaults  *userDefaults = [NSUserDefaults standardUserDefaults];
               // [userDefaults setObject:self.lblUserName.text forKey:@"username"];
                //保存
               // [userDefaults synchronize];
            }
            else
            {
                NSLog(@"%@",error);
                [self ShowErrorString:@"用户名或密码错误"];
            }
        }];
    }
}
#pragma mark 错误提示
-(void)ShowErrorString:(NSString *)error
{
    /**弹框提示*/
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"登录失败" message:error preferredStyle:UIAlertControllerStyleAlert];
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
