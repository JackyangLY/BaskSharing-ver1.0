//
//  MineVC.m
//  BaskSharing
//
//  Created by 洋洋 on 16/8/18.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//
#import "Common.h"
#import "MineVC.h"
#import "LoginPageVC.h"
#import "MineExplainTableVC.h"
#import "MineExplainCell.h"
@interface MineVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) UITableView *mineTableView;
@property (nonatomic ,strong) UIView *backview;
@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBasicSetting];

        //self.navigationItem.rightBarButtonItems = @[moonItem,cancelItem];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark 加载默认设置
-(void)loadBasicSetting
{
    self.navigationItem.title = @"我的";
    [self.view setBackgroundColor:[UIColor cyanColor]];
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //NSString *name = [userDefaults objectForKey:@"username"];
    AVUser *currentUser = [AVUser currentUser];
    //用户名
    NSString *name = currentUser[@"username"];

    if (!name)
    {
       [self.view removeFromSuperview];
        [self addLoginButton];
    }
    else
    {
        /**右上角*/
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setTitle:@"注销" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [cancelButton setImage:[UIImage imageNamed:@"navigationButtonReturnN_15x21_@1x"] forState:UIControlStateNormal];
        [cancelButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick_15x21_"] forState:UIControlStateHighlighted];
        //backbutton.frame = CGSizeMake(36, 36);
        [cancelButton sizeToFit];
        cancelButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithCustomView:cancelButton];
        self.navigationItem.leftBarButtonItem = cancelItem;
        [cancelButton addTarget:self action:@selector(clickBtnCancelAction) forControlEvents:UIControlEventTouchUpInside];
        //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancelButton];
        //    //backbutton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        //     // __weak typeof(self) weakSelf = self;
        //    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make)
        //     {
        //         make.size.mas_equalTo(CGSizeMake(60, 30));
        //         //make.top.mas_equalTo(weakSelf.navigationController.navigationBar).offset(22);
        //     }];
        UIButton *sebutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [sebutton setImage:[UIImage imageNamed:@"mymassage-setting_21x44_"] forState:UIControlStateNormal];
        [sebutton setImage:[UIImage imageNamed:@"mymassage-setting-selected_21x44_"] forState:UIControlStateHighlighted];
        [sebutton sizeToFit];
        UIBarButtonItem *moonItem = [[UIBarButtonItem alloc]initWithCustomView:sebutton];
        self.navigationItem.rightBarButtonItem = moonItem;
        [self addBackLoginView];

    }
    
 
}
#pragma  mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        NSString *strCell = @"mineCell";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:strCell];
        if (!cell)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MineCell" owner:self options:nil]lastObject];
        }
        return cell;
    }
    else
    {
        MineExplainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineExplainCell"];
        if (!cell)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MineExplainCell" owner:nil options:nil] firstObject];
        }
//        cell.textLabel.text = @"个人主页";
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld----%ld",indexPath.section,indexPath.row];
//        cell.backgroundColor = [UIColor grayColor];
//        cell.imageView.image = [UIImage imageNamed:@"ABookicon_57x57_"];
       // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1)
    {
        
        return 250.0f;
    }
    return 80;
}

#pragma  mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        MineExplainTableVC *mineVC = [[MineExplainTableVC alloc]init];
       [self.navigationController pushViewController:mineVC animated:YES];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MineExplainVC"]) {
//        LYNSlog
    }

}
#pragma  mark 登录按钮的点击事件
-(void)loginBtnAction
{
    
    LoginPageVC *loginVC = [[LoginPageVC alloc]init];
   // [self presentViewController:loginVC animated:YES completion:nil];
    [self.navigationController pushViewController:loginVC animated:YES];
}
-(void)addBackLoginView
{
    UIView *backview = [[UIView alloc]init];
    backview.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:backview];
    _backview = backview;
    __weak typeof(self) weakSelf = self;
    [backview mas_makeConstraints:^(MASConstraintMaker *make)
     {
//         make.size.mas_equalTo(CGSizeMake(LYSCREEN_WIDTH-10, LYSCREEN_WIDTH-10));
         make.size.mas_equalTo(CGSizeMake(LYSCREEN_WIDTH-10,LYSCREEN_HEIGHT-70));
         make.center.mas_equalTo(weakSelf.view);
         
     }];
    //        UITableView *tableview = [[UITableView alloc]initWithFrame:backview.frame style:UITableViewStyleGrouped];
    UITableView *tableview = [[UITableView alloc]initWithFrame:backview.frame style:UITableViewStyleGrouped];
    
    [self.view addSubview:tableview];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.size.mas_equalTo(backview);
         make.center.mas_equalTo(backview);
     }];
    self.mineTableView = tableview;
    self.mineTableView.rowHeight = UITableViewAutomaticDimension;
    self.mineTableView.estimatedRowHeight = 200;
   // self.mineTableView.sectionHeaderHeight = 0;
    //self.mineTableView.sectionFooterHeight = 10;
    self.mineTableView.showsVerticalScrollIndicator = NO;
    tableview.dataSource = self;
    tableview.delegate = self;
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = [UIColor redColor];
    footerView.LY_height = 200;
    self.mineTableView.tableFooterView = footerView;

}
#pragma  mark 注销按钮的点击事件
-(void)clickBtnCancelAction
{
    LYNSlog
    //获取UserDefaults单例
   
    //点击按钮的响应事件；
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //NSString *name = [userDefaults objectForKey:@"username"];
    AVUser *currentUser = [AVUser currentUser];
    NSString *name = currentUser[@"username"];
    if (name)
    {

        NSString *strBar = [NSString stringWithFormat:@"是否退出当前用户“%@”?",name];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注销提示:" message:strBar preferredStyle:  UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
        {
            [AVUser logOut];  //清除缓存用户对象
            AVUser *currentUser = [AVUser currentUser]; // 现在的currentUser是nil了
            [currentUser deleteAuthDataForPlatform:AVOSCloudSNSPlatformWeiBo block:^(AVUser *user, NSError *error) {
                if (error) {
                    // 解除失败，多数为网络问题
                } else {
                    // 解除成功
                }
            }];
            [currentUser deleteAuthDataForPlatform:AVOSCloudSNSPlatformQQ block:^(AVUser *user, NSError *error) {
                if (error) {
                    // 解除失败，多数为网络问题
                } else {
                    // 解除成功
                }
            }];

            NSLog(@"%s===%@",__func__,currentUser);
                    //移除UserDefaults中存储的用户信息
                    //   [userDefaults removeObjectForKey:@"username"];
                   //    [userDefaults removeObjectForKey:@"password"];
                    //    [userDefaults synchronize];
                   // [self.view removeFromSuperview];
                        [self addLoginButton];
            
                       }]];
        UIAlertAction *cancelaction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:cancelaction];

     /**弹出提示框*/
       [self presentViewController:alert animated:YES completion:nil];
     //   [self.navigationController pushViewController:alert animated:YES];
    }
    else
    {
            /**弹框提示*/
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"注销提示:" message:@"您当前并未登录！\n请登录后再注销" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];

    }

   
}
#pragma mark 添加登录按钮
-(void)addLoginButton
{
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"em_me_spe_none_text"]];
    [self.view addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.center.equalTo(self.view);
         make.width.height.equalTo(imageview);
     }];

    UIButton *logionbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [logionbutton setTitle:@"立即登录" forState:UIControlStateNormal];
    logionbutton.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:logionbutton];
    [logionbutton mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.equalTo(imageview.mas_top).offset(-8);
         make.centerX.equalTo(imageview);
         make.width.mas_equalTo(80);
         make.height.mas_equalTo(30);
     }];
    [logionbutton addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
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
