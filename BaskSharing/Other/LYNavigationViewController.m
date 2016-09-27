//
//  LYNavigationViewController.m
//  BaskSharing
//
//  Created by 洋洋 on 16/8/20.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "LYNavigationViewController.h"
#import "Common.h"
@interface LYNavigationViewController ()<UIGestureRecognizerDelegate>

@end
/**
 *  重写push方法的目的：；拦截所有push进来的子控制器
 *@param viewcontroller 刚刚push进来的子控制器
 */
@implementation LYNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interactivePopGestureRecognizer.delegate = self;
    //导航栏透明度
    self.navigationController.navigationBar.translucent = YES;

    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"10"] forBarMetrics:UIBarMetricsDefault];
    /**隐藏底部的工具条*/
   // self.hidesBottomBarWhenPushed = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0)
    {//如果ViewController不是最早Push进来的控制器
        /**左上角*/
        UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backbutton setImage:[UIImage imageNamed:@"navigationButtonReturn_15x21_"] forState:UIControlStateNormal];
        [backbutton setImage:[UIImage imageNamed:@"navigationButtonReturnClick_15x21_@1x"] forState:UIControlStateHighlighted];
        [backbutton setTitle:@"返回" forState:UIControlStateNormal];
        [backbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backbutton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backbutton sizeToFit];
        //backbutton.frame = CGSizeMake(36, 36);
        [backbutton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbutton];
        backbutton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//        __weak typeof(self) weakSelf = self;
//        [backbutton mas_makeConstraints:^(MASConstraintMaker *make)
//         {
//             //make.center.equalTo(weakSelf);
//             make.size.mas_equalTo(CGSizeMake(70, 28));
//
//        }];
        
        /**隐藏底部的工具条*/
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}
-(void)back
{
    [self popViewControllerAnimated:YES];
}
#pragma  mark UIGestureRecognizerDelegate
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
//    if (self.childViewControllers.count)
//    {
//        return NO;
//    }
//    return YES;
    /**当导航控制器的子控制器个数>1时 有效*/
    return self.childViewControllers.count > 1;
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
