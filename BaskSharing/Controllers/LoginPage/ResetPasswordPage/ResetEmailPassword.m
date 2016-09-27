//
//  ResetEmailPassword.m
//  BaskSharing
//
//  Created by Yang on 9/3/16.
//  Copyright © 2016 Jack_yy. All rights reserved.
//

#import "ResetEmailPassword.h"
#import "Common.h"
@interface ResetEmailPassword ()
@property (nonatomic ,weak) UITextField *textEmail;

@end

@implementation ResetEmailPassword


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBasicSetting];
}
#pragma mark 加载默认设置
-(void)loadBasicSetting
{
    self.navigationItem.title = @"邮箱密码重置";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UILabel *lblEmail = [[UILabel alloc]init];
    [self.view addSubview:lblEmail];
    lblEmail.text = @"邮箱:";
    [lblEmail mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.view).mas_offset(LYSCREEN_HEIGHT/2- LYSCREEN_WIDTH/2);
         make.leading.equalTo(self.view).mas_offset(LYSCREEN_WIDTH/8);
     }];
    UITextField *textEmail = [[UITextField alloc]init];
    textEmail.borderStyle =  UITextBorderStyleRoundedRect;
    [self.view addSubview:textEmail];
    _textEmail = textEmail;
    [textEmail mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(lblEmail);
         make.leading.equalTo(lblEmail.mas_trailing).mas_offset(8);
         make.width.mas_equalTo(LYSCREEN_WIDTH/2);
         make.height.mas_equalTo(30);
     }];
    /**重置密码*/
    UIButton *btnRegister = [[UIButton alloc]init];
    [self.view addSubview:btnRegister];
    [btnRegister setBackgroundColor:[UIColor brownColor]];
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(textEmail.mas_bottom).offset(25);
         make.leading.equalTo(textEmail);
         make.width.mas_equalTo(textEmail);
         make.height.mas_equalTo(textEmail);
     }];
    [btnRegister setTitle:@"发送验证码" forState:UIControlStateNormal];
    [btnRegister addTarget:self action:@selector(ResetEailBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    
}
-(void)ResetEailBtnAction:(UIButton *)button
{
//    [self.alertViewHelper showInputAlertViewWithMessage:@"请输入您的邮箱来登录" block:^(BOOL confirm, NSString *email) {
//        if (confirm) {
//            [AVUser logInWithUsernameInBackground:email password:kDemoPassword block:^(AVUser *user, NSError *error) {
//                if ([self filterError:error]) {
//                    [self log:@"登录成功 %@ ", user];
//                }
//            }];
//        }
//    }];
    [AVUser requestPasswordResetForEmailInBackground:self.textEmail.text block:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            NSLog(@"%s  验证码发送成功succeeded---%@",__func__,error);
            /**弹框提示*/
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"邮箱重置密码提示:" message:@"验证码发送成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alertVC addAction:action];
            [self presentViewController:alertVC animated:YES completion:nil];
            
        }
        else {
            
             NSLog(@"%s  用户名未注册---%@",__func__,error);
            /**弹框提示*/
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"邮箱重置密码提示:" message:@"用户名不存在或错误" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alertVC addAction:action];
            [self presentViewController:alertVC animated:YES completion:nil];
            

        }
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
