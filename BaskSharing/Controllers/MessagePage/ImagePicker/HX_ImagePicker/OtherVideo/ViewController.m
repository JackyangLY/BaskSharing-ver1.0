//
//  ViewController.m
//  HX_ImagePickerController
//
//  Created by 洪欣 on 16/8/25.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "ViewController.h"
#import "PhotoAndVideoViewController.h"
#import "PhotoViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    NSArray *titles = @[@"选择照片 和 选择视频",@"选择照片and视频  和  选择视频"];
    
    for (int i = 0 ; i < titles.count; i++) {
        UIButton *one = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [one setTitle:titles[i] forState:UIControlStateNormal];
        
        [one setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [one addTarget:self action:@selector(goVC:) forControlEvents:UIControlEventTouchUpInside];
        one.tag = i;
        one.frame = CGRectMake(0, 100 + i*100, width, 50);
        [self.view addSubview:one];
    }
}

- (void)goVC:(UIButton *)button
{
    if (button.tag == 0) {
        PhotoViewController *vc = [[PhotoViewController alloc] init];
         [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 1) {
        PhotoAndVideoViewController *vc = [[PhotoAndVideoViewController alloc] init];
         [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
