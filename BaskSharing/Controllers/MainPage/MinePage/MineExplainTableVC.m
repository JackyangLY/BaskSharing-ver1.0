//
//  MineExplainTableVC.m
//  BaskSharing
//
//  Created by Yang on 8/26/6.
//  Copyright © 206 Jack_yy. All rights reserved.
//个人说明
#import <Photos/Photos.h>
#import "MineExplainTableVC.h"
#import "Common.h"
#import "LoginPageVC.h"
#import "MineExplainCell.h"
#import "MineDetailVC.h"
#import "MineDetailModel.h"
// 宏定义一个高度
#define pictureHeight 200
#define  buttonWidth 90
#define  MineDetailFileName @"MineDetailFile"

@interface MineExplainTableVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) UIButton *button;
@property (nonatomic, strong) UIImageView  *imageName;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (nonatomic, strong) UIImageView *pictureImageView;
//头像view
@property (nonatomic, strong) UIView *header;
/**文件路径*/
@property (nonatomic ,strong )NSString *filePath;
@end

@implementation MineExplainTableVC
/**懒加载filePath*/
-(NSString *)filePath
{
    if (!_filePath)
    {
        /**1.获取*/
        NSString *strDocPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        /**2合并文件路径*/
        _filePath =[strDocPath stringByAppendingPathComponent:MineDetailFileName];
    }
    return _filePath;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
- (void)addSubViews{
    __weak typeof(self) weakSelf = self;
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    [self.view addSubview:tableView];
    self.tableView=tableView;
    _tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor orangeColor];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.estimatedRowHeight = 100;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(weakSelf.view).offset(8);
        make.bottom.leading.trailing.mas_equalTo(weakSelf.view);
    }];
    // 添加头视图 在头视图上添加ImageView
    self.header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, pictureHeight)];
    _pictureImageView = [[UIImageView alloc] initWithFrame:_header.bounds];
    _pictureImageView.image = [UIImage imageNamed:@"Snip20160824_6"];
    /*
     重要的属性设置
     */
    //这个属性的值决定了 当视图的几何形状变化时如何复用它的内容 这里用 UIViewContentModeScaleAspectFill 意思是保持内容高宽比 缩放内容 超出视图的部分内容会被裁减 填充UIView
    _pictureImageView.contentMode = UIViewContentModeScaleAspectFill;
    // 这个属性决定了子视图的显示范围 取值为YES时，剪裁超出父视图范围的子视图部分.这里就是裁剪了_pictureImageView超出_header范围的部分.
    _pictureImageView.clipsToBounds = YES;
    [_header addSubview:_pictureImageView];
    self.tableView.tableHeaderView = _header;
    //save_50x33_
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

    UIButton *button=[UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.header addSubview:button];
    button.backgroundColor = [UIColor grayColor];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"userImage"];
    if (data)
    {
        UIImage *image = [UIImage imageWithData:data];
        [button setBackgroundImage:image forState:UIControlStateNormal];
    }else
    {
        [button setBackgroundImage:[UIImage imageNamed:@"album_photo_camera_75x75_@1x"] forState:UIControlStateNormal];
    }
    //[button setImage:[UIImage imageNamed:@"album_photo_camera_75x75_@1x"] forState:UIControlStateNormal];
    self.button=button;
    [button mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(weakSelf.header).offset(buttonWidth/2);
         make.centerX.mas_equalTo(weakSelf.header);
         //.mas_offset(-60)
         // make.leading.mas_equalTo(weakSelf.view).mas_offset(8);
         make.width.equalTo(@(buttonWidth));
         make.height.equalTo(button.mas_width);
     }];
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 1.0;
    button.layer.cornerRadius = buttonWidth/2;
    button.clipsToBounds = YES;
    [button addTarget:self action:@selector(CilckBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma  mark 保存
-(void)saveBtnAction: (UIButton *)button
{
    if (![AVUser currentUser].username)
    {
        [self showAlterControllerWithString:@"保存提示：" titleWithMessage:@"保存失败，用户未登录"];
        return;
    }
    else
    {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *DataImageName = UIImageJPEGRepresentation(_imageName.image, 1.0);
    [userDefaults setObject:DataImageName forKey:@"userImage"];
    [userDefaults synchronize];
    [[AVUser currentUser] setObject:DataImageName forKey:@"userImage"];
    [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (succeeded)
         {
             [[AVUser currentUser] setObject: DataImageName forKey:@"userImage"];
             [[AVUser currentUser] saveInBackground];
         }
         else
         {
             [self showAlterControllerWithString:@"保存提示：" titleWithMessage:@"保存失败"];
             
         }
     }];

    [self showAlterControllerWithString:@"保存提示:" titleWithMessage:@"保存成功"];
    }
}
-(void)showAlterControllerWithString :(NSString *)title titleWithMessage:(NSString *)message
{
    /**弹框提示*/
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}
#pragma  mark 选择图像事件
-(void)CilckBtnAction:(UIButton *)button
{
    //UIImageWriteToSavedPhotosAlbum(<#UIImage * _Nonnull image#>, <#id  _Nullable completionTarget#>, <#SEL  _Nullable completionSelector#>, <#void * _Nullable contextInfo#>)
    [self setSystemImage];
}
#pragma  mark 进入系统相册
-(void)setSystemImage
{
    //创建ImagePickController
    UIImagePickerController *myPicker = [[UIImagePickerController alloc]init];
    
    //创建源类型
    UIImagePickerControllerSourceType mySourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    myPicker.sourceType = mySourceType;
    
    //设置代理
    myPicker.delegate = self;
    //设置可编辑
    myPicker.allowsEditing = YES;
    //通过模态的方式推出系统相册
    [self presentViewController:myPicker animated:YES completion:^{
//        NSLog(@"进入相册");
    }];
    
}
#pragma mark -- 实现imagePicker的代理方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //取得所选取的图片,原大小,可编辑等，info是选取的图片的信息字典
    UIImage *selectImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //设置图片进相框
    //self.button.image = selectImage;
    _imageName = [[UIImageView alloc]initWithImage:selectImage];
    //_imageName.image = selectImage;
    [_button setBackgroundImage:selectImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:^{
//        NSLog(@"模态返回") ;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadBasicSetting];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

#pragma mark 加载默认设置
-(void)loadBasicSetting
{
    self.navigationItem.title = @"个人说明";
    [self addSubViews];
    self.view.backgroundColor = [UIColor whiteColor];
    // 下面两个属性的设置是与translucent为NO,坐标变换的效果一样
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    AVUser *currentUser = [AVUser currentUser];
    //用户名
    NSString *name = currentUser[@"username"];
    
    if (!name)
    {
        [self addLoginButton];
    }
    else
    {
        
        /**左上角*/
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
//        UIButton *sebutton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [sebutton setImage:[UIImage imageNamed:@"mymassage-setting_21x44_"] forState:UIControlStateNormal];
//        [sebutton setImage:[UIImage imageNamed:@"mymassage-setting-selected_21x44_"] forState:UIControlStateHighlighted];
//        [sebutton sizeToFit];
//        UIBarButtonItem *moonItem = [[UIBarButtonItem alloc]initWithCustomView:sebutton];
//        self.navigationItem.rightBarButtonItem = moonItem;
        
    }

    
}
#pragma mark 添加登录按钮
-(void)addLoginButton
{
    UIView *tmpView = [[UIView alloc]init];
    [self.view addSubview:tmpView];
    [self.view bringSubviewToFront:tmpView];
    __weak typeof(self) weakSelf = self;
//    tmpView.frame = self.view.frame;
    tmpView.backgroundColor= [UIColor whiteColor];
    [tmpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(weakSelf.view.frame.size.width, weakSelf.view.frame.size.height));
        
    }];
    
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"em_me_spe_none_text"]];
    //[self.view addSubview:imageview];
    [tmpView addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.center.equalTo(weakSelf.view);
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

#pragma  mark 登录按钮的点击事件
-(void)loginBtnAction
{
    
    LoginPageVC *loginVC = [[LoginPageVC alloc]init];
    // [self presentViewController:loginVC animated:YES completion:nil];
    [self.navigationController pushViewController:loginVC animated:YES];
}
#pragma  mark 注销按钮的点击事件
-(void)clickBtnCancelAction
{
//    LYNSlog
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
                           //   AVUser *currentUser = [AVUser currentUser]; // 现在的currentUser是nil了
                             // NSLog(@"%s===%@",__func__,currentUser);
                              
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.dataArr.count;
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineExplainCell *cell = [MineExplainCell cellWithTableview:tableView];
    //.接档操作的
    MineDetailModel *mineModel = [NSKeyedUnarchiver unarchiveObjectWithFile:self.filePath];
    if (mineModel)
    {
        if([mineModel.StrName isEqualToString:@""])
        {
            cell.userName.text =[AVUser currentUser].username;
            
        }else
        {
        cell.userName.text = mineModel.StrName;
        }
        cell.Age.text = mineModel.StrAge;
        cell.sex.text = mineModel.StrSex;
        cell.email.text = mineModel.StrEmail;
    }
    else
    {
        
        cell.userName.text = [AVUser currentUser].username;
    }
    if ([cell.userName.text isEqualToString:@""])
    {
        cell.userName.text = [AVUser currentUser].username;

    }
   
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 250.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MineDetailVC *mineDetaillvc = [[MineDetailVC alloc]init];
    [self.navigationController pushViewController:mineDetaillvc animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    /**
     *  这里的偏移量是纵向从contentInset算起 则一开始偏移就是0 向下为负 上为正 下拉
     */
    
    // 获取到tableView偏移量
    CGFloat Offset_y = scrollView.contentOffset.y;
    // 下拉 纵向偏移量变小 变成负的
    if ( Offset_y < 0) {
        // 拉伸后图片的高度
        CGFloat totalOffset = pictureHeight - Offset_y;
        // 图片放大比例
        CGFloat scale = totalOffset / pictureHeight;
        CGFloat width = LYSCREEN_WIDTH;
        // 拉伸后图片位置
        _pictureImageView.frame = CGRectMake(-(width * scale - width) / 2, Offset_y, width * scale, totalOffset);
        
        
         // 拉伸后button位置
        CGFloat buttonX = (LYSCREEN_WIDTH-buttonWidth)/2;
            _button.frame = CGRectMake(buttonX+(buttonWidth*(1-scale))/2, buttonWidth/2+(buttonWidth*(1-scale))/2, buttonWidth*scale, buttonWidth*scale);
        
        _button.layer.cornerRadius = buttonWidth*scale/2;
        
    }
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
