//
//  EditingVC.m
//  BaskSharing
//
//  Created by Yang on 8/31/16.
//  Copyright © 2016 Jack_yy. All rights reserved.
//

#import "EditingVC.h"
#import "Common.h"
#import "LYWeiboButton.h"
#import "LYIssueWeiboView.h"
#import "Common.h"
#import "WriteVC.h"
#import "ViewController.h"
#import "PhotoViewController.h"

@interface EditingVC ()<ZFIssueWeiboViewDelegate,UITextViewDelegate>
@property (nonatomic ,assign) NSInteger count;
@property (nonatomic ,strong) NSString *StrcontentText;
@end

@implementation EditingVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBasicSetting];
}
#pragma mark 加载默认设置
-(void)loadBasicSetting
{
    _count = 0;
    self.navigationItem.title = @"分享";
    /**右上角保存*/
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setImage:[UIImage imageNamed:@"save_50x33_"] forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [saveButton sizeToFit];
    //saveButton.frame = CGSizeMake(36, 36);
    [saveButton addTarget:self action:@selector(saveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveButton];
    saveButton.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    

    PhotoViewController *photoVC = [[PhotoViewController alloc]init];
   // [self.navigationController pushViewController:photoVC animated:YES];
    [self.view addSubview:photoVC.view];
    __weak typeof(self) weakSelf = self;
    [photoVC.view mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.size.equalTo(weakSelf.view);
         make.top.equalTo(weakSelf.view).mas_offset(64);
         make.leading.equalTo(weakSelf.view);
     }];
    photoVC.PhotoTextView.delegate = self;


    //[self setupUI];
}
-(void)setupUI
{
    LYIssueWeiboView *Editingview = [LYIssueWeiboView initIssueWeiboView];
    Editingview.frame = CGRectMake(0, 0, LYSCREEN_WIDTH, LYSCREEN_HEIGHT);
    Editingview.delegate = self;
    [self.view addSubview:Editingview];
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"em_comment_none"]];
    [Editingview addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerY.equalTo(Editingview).mas_offset(-140);
         make.centerX.equalTo(Editingview);
         make.width.height.equalTo(imageview);
     }];
}
- (void)animationHasFinishedWithButton:(LYWeiboButton *)button
{
//    NSLog(@"%zd", button.tag);
    NSInteger index = button.tag;
    if (index == 100)
    {//文字
        WriteVC  *write = [[WriteVC alloc]init];
       // PhotoViewController *photoVC = [[PhotoViewController alloc]init];
        [self.view addSubview:write.view];
          __weak typeof(self) weakSelf = self;
        [write.view mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.size.equalTo(weakSelf.view);
            make.top.equalTo(weakSelf.view).mas_offset(64);
            make.leading.equalTo(weakSelf.view);
            
        }];
        
        
    }
    else if(index == 101)
    {//照片，视频
       
        
    }
    else if (index == 102)
    {//头条文章
        PhotoViewController *photoVC = [[PhotoViewController alloc]init];
        [self.view addSubview:photoVC.view];
        __weak typeof(self) weakSelf = self;
        [photoVC.view mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.size.equalTo(weakSelf.view);
             make.top.equalTo(weakSelf.view).mas_offset(64);
             make.leading.equalTo(weakSelf.view);
         }];
        
    }
    else if (index == 103)
    {//签到
        
    }
    else if (index == 104)
    {//评论
        
    }
    else if (index == 105)
    {//更多
        
    }
}

    

#pragma  mark UITextViewDelegate
//结束改变
-(void)textViewDidChange:(UITextView*)textView
{
    /**打印此方法*/
//    NSLog(@"%s",__func__);
    self.StrcontentText = textView.text;
    
    
}
//正在改变
- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    /**打印此方法*/
//    NSLog(@"%s",__func__);
    
    return YES;
    
}

#pragma  mark 保存按钮事件
-(void)saveBtnAction:(UIButton *)button
{
    _count += 1;
    button.enabled = YES;
    if (!button.selected)
    {
        if (_count%2 ==1)
        {
            button.enabled = NO;
        }
        button.enabled = YES;
    }
    else
    {
        button.enabled = NO;
        
    }
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
