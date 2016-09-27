//
//  SearchViewController.m
//  BaskSharing
//
//  Created by 洋洋 on 16/8/19.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchResultViewController.h"
@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBasicSetting];
}
#pragma mark 加载默认设置
-(void)loadBasicSetting
{
        self.navigationItem.title = @"搜索";
    /**隐藏底部的工具条*/
    self.hidesBottomBarWhenPushed = YES;
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SearchResultViewController *ResultVC = [[SearchResultViewController alloc]init];
    [self.navigationController pushViewController:ResultVC animated:YES];
    ResultVC.view.backgroundColor = [UIColor grayColor];
}
@end
