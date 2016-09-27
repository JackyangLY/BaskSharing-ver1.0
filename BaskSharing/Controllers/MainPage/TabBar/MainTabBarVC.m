//
//  ViewController.m
//  BaskSharing
//
//  Created by 洋洋 on 16/8/17.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//首页TabBar控制器

#import "Common.h"
#import "MainTabBarVC.h"
#import "LoginPageVC.h"
#import "MainVC.h"
#import "ShareVC.h"
#import "MineVC.h"
#import "MineExplainTableVC.h"
#import "LYHomeViewController.h"
@interface MainTabBarVC ()

@end

@implementation MainTabBarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDefaultsting];
    self.tabBar.tintColor = [UIColor redColor];
}

-(void)loadDefaultsting
{
    //self.title = @"首页";
    //MainVC  *mianvc = [[MainVC alloc]init];
    //[self addViewController:mianvc imageName:@"tabHome" title:@"首页"];
    //根据对应的Storyboard选择VC
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *homeVC = [story instantiateViewControllerWithIdentifier:@"HomeVC"];
    //[self.view addSubview:VC.view];
    //[self presentViewController:VC animated:YES completion:nil];
    [self addViewController:homeVC imageName:@"tabHome" title:@"首页"];


//    LYNSlog
    UIViewController *TopUserVC = [story instantiateViewControllerWithIdentifier:@"TopUserVC"];
   // FindVC  *findvc = [[FindVC alloc]init];
    [self addViewController:TopUserVC imageName:@"tab_explore" title:@"发现"];
    
//    LYNSlog
    //CollectionViewController *collection = [[CollectionViewController alloc] init];
    
    ShareVC *sharevc = [[ShareVC alloc]init];
    [self addViewController:sharevc imageName:@"tab_activity" title:@"一起"];
//    LYNSlog
    //TableViewController *table = [[TableViewController alloc] init];

    LYHomeViewController *messagevc = [[LYHomeViewController alloc]init];
   // MessageVC *messagevc = [[MessageVC alloc]init];
    [self addViewController:messagevc imageName:@"tab_info" title:@"消息"];
//    LYNSlog
    MineExplainTableVC *minevc = [[MineExplainTableVC alloc]init];
   // MineVC *minevc = [[MineVC alloc]init];
    [self addViewController:minevc imageName:@"tab_me" title:@"我的"];
//    LYNSlog
    
    
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeInfoLight];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    [leftBtn addTarget:self action:@selector(ClickLeftBtnAction) forControlEvents:UIControlEventTouchUpInside];
 }
- (void)addViewController:(UIViewController *)viewController imageName:(NSString *)imageName title:(NSString *)title {
    /**普通状态下的文字属性*/
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    /**选中状态下的文字属性*/
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    
    [viewController.tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [viewController.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", imageName]];
    //viewController.tabBarItem.title = title;
    viewController.title = title;
    viewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -1);
    //[self addChildViewController:viewController];
    // 创建一个导航控制器
    LYNavigationViewController *vcNav = [[LYNavigationViewController alloc] initWithRootViewController:viewController];
    
    // 把导航控制器添加到TanBarController中
    [self addChildViewController:vcNav];
}

#pragma  mark 点击左边的按钮
-(void)ClickLeftBtnAction
{
    /**打印此方法*/
//    NSLog(@"%s",__func__);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    LoginPageVC *loginVC = [LoginPageVC new];
//    [self presentViewController:loginVC animated:YES completion:nil];
    /**打印此方法*/
//    NSLog(@"%s 点击屏幕",__func__);
    //获取UserDefaults单例
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //移除UserDefaults中存储的用户信息
    [userDefaults removeObjectForKey:@"name"];
    [userDefaults removeObjectForKey:@"password"];
    [userDefaults synchronize];
}
@end
