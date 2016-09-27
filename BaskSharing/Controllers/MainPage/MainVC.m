////
////  MainVC.m
////  BaskSharing
////
////  Created by 洋洋 on 16/8/18.
////  Copyright © 2016年 Jack_yy. All rights reserved.
////
//
//#import "MainVC.h"
//#import "Common.h"
//#import "EditingVC.h"
//#import "HomeViewCell.h"
//#import "PhotoViewController.h"
//@interface MainVC ()<UITableViewDataSource>
//@property (nonatomic ,weak) UITableView *commonTablewView;
//@property(nonatomic,strong) NSString *StrTitleName;
//@end
//
//@implementation MainVC
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    [self loadBasicSetting];
//    [self.view setBackgroundColor:[UIColor redColor]];
//    UIButton *chookbutton = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    chookbutton.tintColor = [UIColor cyanColor];
//    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:chookbutton];
//    [chookbutton addTarget:self action:@selector(editingBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *buttonN = [UIButton buttonWithType:UIButtonTypeCustom];
//    [buttonN setImage:[UIImage imageNamed:@"editer_mark_27x20_"] forState:UIControlStateNormal];
//    [buttonN setImage:[UIImage imageNamed:@"editer_mark_click_27x20_"] forState:UIControlStateHighlighted];
//    [buttonN sizeToFit];
//    //buttonN.frame = CGRectMake(0, 22, 36, 36);editer_mark_brush_30x30_
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:buttonN];
//    buttonN.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//    [buttonN addTarget:self action:@selector(ClickBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    
//   // NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    //NSString *user = [userDefaults objectForKey:@"username"];
//    AVUser *currentUser = [AVUser currentUser];
//    //用户名
//    NSString *user = currentUser[@"username"];
//    if (currentUser != nil) {
//        // 跳转到首页
//        /**弹框提示*/
//        NSString *message  = [NSString stringWithFormat:@"'%@'欢迎来到晒分享，您已登录成功",user];
//        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"登录提示:" message:message preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
//        [alertVC addAction:okaction];
//        [self presentViewController:alertVC animated:YES completion:nil];
//    } else {
//        //缓存用户对象为空时，可打开用户注册界面…
//    }
////    if (user)
////    {
////        
////    }
////    [buttonN mas_makeConstraints:^(MASConstraintMaker *make)
////    {
////      make.top.equalTo(self.view).offset(22);
////     make.top.equalTo(self.navigationItem).offset(22);
////        make.width.height.mas_equalTo(36);
////    }];
//   
//        // Do any additional setup after loading the view from its nib.
//}
//
//#pragma mark 加载默认设置
//-(void)loadBasicSetting
//{
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.244 green:0.476 blue:1.000 alpha:0.200]];
//    NSArray *titles = @[@"首页", @"朋友圈", @"我的关注", @"明星", @"家人朋友"];
//   // [self addCommonTableView];
//    LYDropdownMenuView *menuView = [[LYDropdownMenuView alloc] initWithFrame:CGRectMake(0, 0,100, 44) titles:titles];
//      __weak typeof(self) weakSelf = self;
//    menuView.selectedAtIndex = ^(int index)
//    {
//        NSLog(@"selected title:%@", titles[index]);
//        NSString *strName = titles[index];
//        _StrTitleName =strName;
//        if ([strName isEqualToString:@"首页"])
//        {
//            [weakSelf addCommonTableView];
//            
//
//        }
//        
//        else if ([strName isEqualToString:@"朋友圈"])
//        {
//            
//        }
//        else if ([strName isEqualToString:@"我的关注"])
//        {
//            
//        }
//        else if ([strName isEqualToString:@"明星"])
//        {
//            
//        }
//        else if ([strName isEqualToString:@"家人朋友"])
//        {
//            
//        }
//    };
//    menuView.width = 300;
//    self.navigationItem.titleView = menuView;
//        
//    
////    UIButton *chookbutton = [UIButton buttonWithType:UIButtonTypeContactAdd];
////    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:chookbutton];
////    UIButton *buttonN = [UIButton buttonWithType:UIButtonTypeCustom];
////    [buttonN setImage:[UIImage imageNamed:@"editer_mark_27x20_"] forState:UIControlStateNormal];
////    [buttonN setImage:[UIImage imageNamed:@"editer_mark_click_27x20_"] forState:UIControlStateHighlighted];
////    [buttonN addTarget:self action:@selector(ClickBtnAction) forControlEvents:UIControlEventTouchUpInside];
////    [buttonN sizeToFit];
////    //buttonN.frame = CGRectMake(0, 22, 36, 36);
////    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:buttonN];
////    buttonN.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
////    
//
//}
//#pragma  mark 设置comontableView
//-(void)addCommonTableView
//{
//    UITableView *tableview = [[UITableView alloc]initWithFrame:self.view.frame];
//    [self.view addSubview:tableview];
//    self.commonTablewView = tableview;
//    self.commonTablewView.dataSource = self;
//    tableview.estimatedRowHeight = 100;
//    tableview.contentInset = UIEdgeInsetsMake(64, 0, 50, 0);
//}
//#pragma  mark tableViewDataSoure
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    NSInteger index = arc4random_uniform(10);
//    return index<1?1:index;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([_StrTitleName isEqualToString:@"首页"])
//    {
//        
//        HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeViewCell"];
//        if (!cell)
//        {
//            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeViewCell" owner:self options:nil]firstObject];
//        }
//        return cell;
//        
//    }
//    else if ([_StrTitleName isEqualToString:@"朋友圈"])
//    {
//        
//        
//    }
//    else if ([_StrTitleName isEqualToString:@"我的关注"])
//    {
//        
//    }
//    else if ([_StrTitleName isEqualToString:@"明星"])
//    {
//        
//    }
//    else if ([_StrTitleName isEqualToString:@"家人朋友"])
//    {
//        
//    }
//    else
//    {
//        HomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeViewCell"];
//        if (!cell)
//        {
//            cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeViewCell" owner:self options:nil]firstObject];
//        }
//        return cell;
//    }
//    return nil;
//}
//#pragma  mark 左侧按钮点击事件
////左侧的按钮
//-(void)ClickBtnAction
//{
//    LYNSlog;
//}
//#pragma  mark 右侧编辑按钮点击事件
////编辑按钮
//-(void)editingBtnAction
//{
//    PhotoViewController *photoVC = [[PhotoViewController alloc]init];
//    [self.navigationController pushViewController:photoVC animated:YES];
// 
//   // EditingVC *editingVC = [[EditingVC alloc]init];
//   // [self.navigationController pushViewController:editingVC animated:YES];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//    
//}
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
