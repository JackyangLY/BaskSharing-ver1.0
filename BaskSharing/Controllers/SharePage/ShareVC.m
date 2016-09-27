//
//  ShareVC.m
//  BaskSharing
//
//  Created by 洋洋 on 16/8/18.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//
#import "Common.h"
#import "ShareVC.h"

@interface ShareVC ()

@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"一起";
      [self.view setBackgroundColor:[UIColor yellowColor]];
    UIImageView *BackImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"em_me_spe_none_568h"]];
    [self.view addSubview:BackImageView];
    [BackImageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.center.equalTo(self.view);
         make.width.height.equalTo(BackImageView);
     }];
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.image = [UIImage imageNamed:@"em_activity_none"];
    [imageview sizeToFit];
    self.navigationItem.titleView = imageview;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"em_info_none_text"]];

    // Do any additional setup after loading the view from its nib.
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
