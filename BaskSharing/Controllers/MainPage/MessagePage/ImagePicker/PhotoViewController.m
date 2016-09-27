//
//  PhotoViewController.m
//  HX_ImagePickerController
//
//  Created by 洪欣 on 16/8/31.
//  Copyright © 2016年 洪欣. All rights reserved.
//
#import "Common.h"
#import "PhotoViewController.h"
#import "HX_AddPhotoView.h"
#import "LYWeiboButton.h"
#import "LYIssueWeiboView.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import "HX_AlbumViewController.h"
#import "HX_AssetManager.h"
#import "HX_AddPhotoViewCell.h"
#import "HX_AssetContainerVC.h"
#import "MBProgressHUD.h"
#import "HX_AssetContainerVC.h"
#import "HX_VideoManager.h"

#define kNormalGrap 8
@interface PhotoViewController ()<HX_AddPhotoViewDelegate,UITextViewDelegate,ZFIssueWeiboViewDelegate,UMSocialUIDelegate>

@property (nonatomic ,assign) NSInteger count;
@property (nonatomic ,strong) NSString *StrcontentText;
//添加图片的view
@property (nonatomic,weak) HX_AddPhotoView *addPhotoView;
//存图片的数组
@property (nonatomic,copy) NSMutableArray *ArrMuImageContent;

@property (nonatomic,weak) UITextView *textview;

@end

@implementation PhotoViewController
//懒加载照片数组
-(NSMutableArray *)ArrMuImageContent
{
    if (!_ArrMuImageContent)
    {
        _ArrMuImageContent = [[NSMutableArray alloc]init];
    }
    return _ArrMuImageContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetBackImageView];
    [self setTopBtn];
    //    // 只选择视频
    //    HX_AddPhotoView *addVideoView = [[HX_AddPhotoView alloc] initWithMaxPhotoNum:1 WithSelectType:SelectVideo];
    //    addVideoView.delegate = self;
    //    addVideoView.frame = CGRectMake(5, 550, width - 10, 0);
    //    addVideoView.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:addVideoView];
    //
    //    [addVideoView setSelectVideo:^(NSArray *video) {
    //        NSLog(@"video - %@",video);
    //        [video enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
    //
    //            // 缩略图
    //            //            UIImage *image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
    //
    //            // 原图
    //            //            CGImageRef fullImage = [[asset defaultRepresentation] fullResolutionImage];
    //
    //            // url
    //            //            NSURL *url = [[asset defaultRepresentation] url];
    //
    //        }];
    //    }];
}

-(void)SetBackImageView
{
    self.navigationItem.title = @"说说";
       self.view.backgroundColor = [UIColor whiteColor];
    //提示
    UILabel *tiLabel = [[UILabel alloc]init];
    [self.view addSubview:tiLabel];
    tiLabel.text = @"说点什么吧！";
    __weak typeof(self) weakSelf = self;
    [tiLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(weakSelf.view).mas_offset(kNormalGrap);
        make.leading.mas_equalTo(weakSelf.view).mas_offset(kNormalGrap);
        
    }];
    //创建TextView
    UITextView *textView = [[UITextView alloc]init];
    textView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:textView];
    self.textview = textView;
    textView.text = @"";
    _PhotoTextView = textView;
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:14.0];
    [textView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(tiLabel.mas_bottom).mas_offset(kNormalGrap);
         make.leading.mas_equalTo(tiLabel);
         make.size.mas_equalTo(CGSizeMake(LYSCREEN_WIDTH-kNormalGrap*2, 100));
         
     }];
    UILabel *label = [[UILabel alloc]init];
    [self.view addSubview:label];
    label.text = @"点击添加图片";
    label.textColor = [UIColor grayColor];
    [label mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(textView.mas_bottom).mas_offset(kNormalGrap);
         // make.top.mas_equalTo(100);
         make.leading.width.mas_equalTo(textView);
     }];
    // 只选择照片
    HX_AddPhotoView *addPhotoView = [[HX_AddPhotoView alloc] initWithMaxPhotoNum:9 WithSelectType:SelectPhoto];
    _addPhotoView = addPhotoView;
    addPhotoView.lineNum = 3;
    addPhotoView.delegate = self;
    addPhotoView.backgroundColor = [UIColor whiteColor];
    //addPhotoView.frame = CGRectMake(5, 150, width - 10, 0);
    [self.view addSubview:addPhotoView];
    [addPhotoView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         //        make.top.mas_equalTo(textView.mas_bottom).mas_offset(kNormalGrap);
         //        make.leading.width.mas_equalTo(textView);
         make.top.mas_equalTo(label.mas_bottom).mas_offset(8);
         // make.top.mas_equalTo(200);
         make.leading.mas_equalTo(label);
         make.width.mas_equalTo(LYSCREEN_WIDTH-kNormalGrap*2);
         make.height.mas_equalTo(150);
     }];
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [shareBtn sizeToFit];
    [self.view addSubview:shareBtn];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(addPhotoView.mas_bottom).mas_offset(8);
        make.leading.equalTo(addPhotoView);
        
    }];
    [shareBtn addTarget:self action:@selector(sharingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [addPhotoView setSelectPhotos:^(NSArray *photos, BOOL iforiginal)
     {
//         NSLog(@"photo - %@",photos);
         [photos enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL * _Nonnull stop)
          {
                    /**  当前选择的个数  */
              NSInteger selectIndex  = weakSelf.addPhotoView.selectNum;
              
              // 缩略图
              UIImage *image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
              
                [self.ArrMuImageContent addObject:UIImagePNGRepresentation(image)];
              // 第一行
              if (selectIndex <3)
              {
                  [weakSelf.addPhotoView mas_updateConstraints:^(MASConstraintMaker *make)
                   {
                       make.height.mas_equalTo(130);
                   }];
              }
              //第三行
              else if(selectIndex > 6)
              {
                  [weakSelf.addPhotoView mas_updateConstraints:^(MASConstraintMaker *make)
                   {
                       make.height.mas_equalTo(390);
                   }];
              }
              //第二行
              else
              {
                  [weakSelf.addPhotoView mas_updateConstraints:^(MASConstraintMaker *make)
                   {
                       make.height.mas_equalTo(260);
                   }];
              }
              
          }];
     }];
    
}
#pragma  mark UITextViewDelegate
//结束改变
-(void)textViewDidChange:(UITextView*)textView
{
    self.StrcontentText = textView.text;
}
//正在改变
- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    return YES;
}
//分享事件
-(void)sharingBtnAction
{
    [self setupUI];
}
#pragma  mark 保存按钮事件
-(void)saveBtnAction:(UIButton *)button
{
    if (! self.PhotoTextView.text)
    {
        /**弹框提示*/
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"发表提示:" message:@"您输入的内容为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    else
    {
    _count += 1;
    button.enabled = YES;
    if (!button.selected)
    {
        if (_count%2 ==1)
        {
            button.enabled = NO;
            
            //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            //NSData *dataImage  =[userDefaults objectForKey:@"userImage"];
            
            AVObject *todo = [AVObject objectWithClassName:@"Todo"];
            AVUser *currentUser = [AVUser currentUser];
            //用户名
            NSString *user = currentUser.username;
            NSDate *timeDate = [NSDate new];
            //[todo setObject:dataImage forKey:@"userImage"];
            [todo setObject:user forKey:@"name"];
            [todo setObject:timeDate forKey:@"currentTimeDate"];
            [todo setObject:@"说说" forKey:@"title"];
            [todo setObject:self.PhotoTextView.text forKey:@"content"];
            [todo setObject:_ArrMuImageContent forKey:@"nameimage"];
            [todo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded)
                {
                    // 存储成功
                    /**打印此方法*/
//                    NSLog(@"%s\n 存储成功",__func__);
                    [self ShowErrorString:@"成功!"];
                }
                else
                {
                    // 失败的话，请检查网络环境以及 SDK 配置是否正确
                    /**打印此方法*/
//                    NSLog(@"%s\n --- %@",__func__,error);
                    [self ShowErrorString:@"存储失败，请重新保存"];
                }
            }];
        }
        button.enabled = YES;
    }
    else
    {
        button.enabled = NO;
    }
    }
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
#pragma  mark 创建顶部的按钮
-(void)setTopBtn
{
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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backbutton];
    backbutton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);

    /**右上角保存*/
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setImage:[UIImage imageNamed:@"navigationButtonPublish_26x26_"] forState:UIControlStateNormal];
    [saveButton setImage:[UIImage imageNamed:@"navigationButtonPublishClick_26x26_"] forState:UIControlStateHighlighted];
    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [saveButton sizeToFit];
    [saveButton addTarget:self action:@selector(saveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveButton];
    saveButton.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    CGFloat width = [UIScreen mainScreen].bounds.size.width;
}
#pragma  mark 返回
-(void)back
{
    [self removeAllObjects];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)animationHasFinishedWithButton:(LYWeiboButton *)button
{
//    NSLog(@"%zd", button.tag);
    NSInteger index = button.tag;
    if (index == 100)
    {//
        return;
        
    }
    else if(index == 101)
    {//
        
        return;
    }
    else if (index == 102)
    {//
        return;
    }
    else if (index == 103)
    {//新浪微博 腾讯微博
        [UMSocialSnsService presentSnsIconSheetView:self appKey:UMengAppKey shareText:self.PhotoTextView.text shareImage:_ArrMuImageContent[0] shareToSnsNames:@[UMShareToSina,UMShareToTencent] delegate:self];
        
    }
    else if (index == 104)
    {//QQ 朋友圈

       /**
        弹出一个分享列表的类似iOS6的UIActivityViewController控件
        
        @param controller 在该controller弹出分享列表的UIActionSheet
        @param appKey 友盟appKey
        @param shareText  分享编辑页面的内嵌文字
        @param shareImage 分享内嵌图片,用户可以在编辑页面删除
        @param snsNames 你要分享到的sns平台类型，该NSArray值是`UMSocialSnsPlatformManager.h`定义的平台名的字符串常量，有UMShareToSina，UMShareToTencent，UMShareToRenren，UMShareToDouban，UMShareToQzone，UMShareToEmail，UMShareToSms等
        @param delegate 实现分享完成后的回调对象，如果不关注分享完成的状态，可以设为nil
        */
        
//        [UMSocialData defaultData].extConfig.title = @"分享";
//        [UMSocialData defaultData].extConfig.qzoneData.url = @"https://www.baidu.com";
//        [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"微信朋友圈title";
        
        [UMSocialSnsService presentSnsIconSheetView:self appKey:UMengAppKey shareText:self.PhotoTextView.text shareImage:_ArrMuImageContent[0] shareToSnsNames:@[UMShareToTencent,UMShareToWechatTimeline,UMShareToQQ] delegate:self];
        //分享png、jpg图片
//        [UMSocialSnsService presentSnsIconSheetView:self appKey:UMengAppKey shareText:shareText shareImage:[UIImage imageNamed:@"picName"] shareToSnsNames:@[UMShareToSina] delegate:self];
        
    }
    else if (index == 105)
    {//其他
        
        [UMSocialSnsService presentSnsIconSheetView:self appKey:UMengAppKey shareText:self.PhotoTextView.text shareImage:_ArrMuImageContent[0] shareToSnsNames:@[UMShareToSms,UMShareToEmail] delegate:self];

      
    }
    
}
-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType
{
//    fromViewControllerType = UMSViewControllerLogin;
}
//实现一个代理方法
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (response.responseCode == UMSResponseCodeSuccess) {
//        NSLog(@"分享成功");
    }
}
- (void)updateViewFrame:(CGRect)frame WithView:(UIView *)view
{
    [self.view layoutSubviews];
}
#pragma mark 提示
//pod 'TencentOpenAPI',
-(void)ShowErrorString:(NSString *)error
{
    /**弹框提示*/
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"发表说说" message:error preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
//    
//    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
//    shake.values = @[@-5,@0,@5,@0];
//    shake.repeatCount = 3;
//    shake.duration = 0.2;
//    [self.view.layer addAnimation:shake forKey:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textview resignFirstResponder];
}
#pragma  mark 移除监听
-(void)removeAllObjects
{
    HX_AssetManager *manager = [HX_AssetManager sharedManager];
    manager.ifRefresh = YES;
    for (HX_PhotoModel *model in manager.selectedPhotos) {
        model.ifAdd = NO;
        model.ifSelect = NO;
    }
    [manager.selectedPhotos removeAllObjects];
    
    manager.ifOriginal = NO;
    //是否重新加载图片
    [HX_VideoManager sharedManager].ifRefresh = YES;
    //移除选中的图片
    [[HX_VideoManager sharedManager].selectedPhotos removeAllObjects];
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)dealloc
{
//    LYNSlog
    [self removeAllObjects];
}

@end
