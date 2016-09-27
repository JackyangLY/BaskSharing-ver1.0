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
@interface PhotoViewController ()<HX_AddPhotoViewDelegate,UITextViewDelegate,ZFIssueWeiboViewDelegate>

@property (nonatomic ,assign) NSInteger count;
@property (nonatomic ,strong) NSString *StrcontentText;
//添加图片的view
@property(nonatomic,weak) HX_AddPhotoView *addPhotoView;
//存图片的数组
@property(nonatomic,copy) NSMutableArray *ArrMuImageContent;


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
    /**右上角保存*/
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setImage:[UIImage imageNamed:@"save_50x33_"] forState:UIControlStateNormal];
    [saveButton setImage:[UIImage imageNamed:@"saveClick_50x33_"] forState:UIControlStateHighlighted];
    [saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [saveButton sizeToFit];
    //saveButton.frame = CGSizeMake(36, 36);
    [saveButton addTarget:self action:@selector(saveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:saveButton];
    saveButton.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    self.view.backgroundColor = [UIColor brownColor];
    //创建TextView
    UITextView *textView = [[UITextView alloc]init];
    textView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:textView];
    textView.text = @"说点什么吧";
    _PhotoTextView = textView;
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:14.0];
    __weak typeof(self) weakSelf = self;
    [textView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(weakSelf.view).mas_offset(kNormalGrap+64);
         make.leading.mas_equalTo(weakSelf.view).mas_offset(kNormalGrap);
         make.size.mas_equalTo(CGSizeMake(LYSCREEN_WIDTH-kNormalGrap*2, 60));
         
     }];
    UILabel *label = [[UILabel alloc]init];
    [self.view addSubview:label];
    label.text = @"点击添加图片";
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
    
    
    
    [addPhotoView setSelectPhotos:^(NSArray *photos, BOOL iforiginal)
     {
         NSLog(@"photo - %@",photos);
         [photos enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL * _Nonnull stop)
          {
              //NSData转换为UIImage
              //NSData *imageData = [NSData dataWithContentsOfFile: imagePath];
              // UIImage *image = [UIImage imageWithData: imageData];
              //UIImage转换为NSData
              //NSData *imageData = UIImagePNGRepresentation(aimae);
              
              
              /**  当前选择的个数  */
              NSInteger selectIndex  = weakSelf.addPhotoView.selectNum;
              
              // 缩略图
              UIImage *image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
              
              // 原图
              CGImageRef fullImage = [[asset defaultRepresentation] fullResolutionImage];
              
              
              [self.ArrMuImageContent addObject:UIImagePNGRepresentation(image)];
              
              // 获取资源图片的详细资源信息，其中 imageAsset 是某个资源的 ALAsset 对象
              //             ALAssetRepresentation *representation = [asset defaultRepresentation];
              // 获取资源图片的 fullScreenImage
              //             UIImage *contentImage = [UIImage imageWithCGImage:[representation fullScreenImage]];
              
              // url
              NSURL *url = [[asset defaultRepresentation] url];
              
              //             NSLog(@"%s---iamge:%@====fullimage:%@\n%@",__func__,image,fullImage,url);
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
    /**打印此方法*/
    NSLog(@"%s",__func__);
    self.StrcontentText = textView.text;
    
    
}
//正在改变
- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    /**打印此方法*/
    NSLog(@"%s",__func__);
    
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
            [self setupUI];
            button.enabled = NO;
            AVObject *todo = [AVObject objectWithClassName:@"Todo"];
            AVUser *currentUser = [AVUser currentUser];
            //用户名
            NSString *user = currentUser[@"username"];
            [todo setObject:user forKey:@"name"];
            [todo setObject:@"说说" forKey:@"title"];
            [todo setObject:self.PhotoTextView.text forKey:@"content"];
            [todo setObject:_ArrMuImageContent forKey:@"nameimage"];
            [todo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    // 存储成功
                    /**打印此方法*/
                    NSLog(@"%s\n 存储成功",__func__);
                    
                } else {
                    // 失败的话，请检查网络环境以及 SDK 配置是否正确
                    /**打印此方法*/
                    NSLog(@"%s\n --- %@",__func__,error);
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
    NSLog(@"%zd", button.tag);
    NSInteger index = button.tag;
    if (index == 100)
    {//文字
        
        
    }
    else if(index == 101)
    {//照片，视频
        
        
    }
    else if (index == 102)
    {//头条文章
        
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

- (void)updateViewFrame:(CGRect)frame WithView:(UIView *)view
{
    [self.view layoutSubviews];
}
-(void)dealloc
{
    LYNSlog
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

@end
