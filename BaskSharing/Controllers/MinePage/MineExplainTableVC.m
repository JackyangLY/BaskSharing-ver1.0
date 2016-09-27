//
//  MineExplainTableVC.m
//  BaskSharing
//
//  Created by Yang on 8/26/6.
//  Copyright © 206 Jack_yy. All rights reserved.
//
#import <Photos/Photos.h>
#import "MineExplainTableVC.h"
#import "Common.h"
#import "MineExplainCell.h"
// 宏定义一个高度
#define pictureHeight 200
#define  buttonWidth 90
@interface MineExplainTableVC ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) UIButton *button;
@property (nonatomic, strong) UIImageView  *imageName;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArr;
@property (nonatomic, strong) UIImageView *pictureImageView;
@property (nonatomic, strong) UIView *header;

@end

@implementation MineExplainTableVC
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}
- (void)addSubViews{
//    UIButton *button=[UIButton buttonWithType:(UIButtonTypeSystem)];
//    [self.view addSubview:button];
//    button.backgroundColor = [UIColor blueColor];
//    self.button=button;
//    __weak typeof(self) weakSelf = self;
//    [button mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         make.top.mas_equalTo(weakSelf.view).offset(80);
//         make.centerX.mas_equalTo(weakSelf.view);
//         //.mas_offset(-60)
//        // make.leading.mas_equalTo(weakSelf.view).mas_offset(8);
//         make.width.equalTo(@(80));
//         make.height.equalTo(button.mas_width);
//     }];
//    button.layer.borderColor = [UIColor whiteColor].CGColor;
//    button.layer.borderWidth = 1.0;
//    button.layer.cornerRadius = 80/2;
//    [button addTarget:self action:@selector(CilckBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    
    
    
    __weak typeof(self) weakSelf = self;
    
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    [self.view addSubview:tableView];
    self.tableView=tableView;
    _tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = [UIColor orangeColor];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
//    self.tableView.estimatedRowHeight = 100;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(weakSelf.view).offset(8);
        make.bottom.leading.trailing.mas_equalTo(weakSelf.view);
    }];
    // 添加头视图 在头视图上添加ImageView
    self.header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LYSCREEN_WIDTH, pictureHeight)];
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
-(void)saveBtnAction: (UIButton *)button
{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *DataImageName = UIImageJPEGRepresentation(_imageName.image, 1.0);
   // [userDefaults setobject:DataImageName forKey:@"userImage"];
    [userDefaults setObject:DataImageName forKey:@"userImage"];
    [userDefaults synchronize];
    NSLog(@"%s---保存成功",__func__);
    
}
#pragma  mark 选择图像事件
-(void)CilckBtnAction:(UIButton *)button
{
    //UIImageWriteToSavedPhotosAlbum(<#UIImage * _Nonnull image#>, <#id  _Nullable completionTarget#>, <#SEL  _Nullable completionSelector#>, <#void * _Nullable contextInfo#>)
    [self setSystemImage];
}
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
        NSLog(@"进入相册");
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
        NSLog(@"模态返回") ;
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

#pragma mark 加载默认设置
-(void)loadBasicSetting
{
    self.navigationItem.title = @"个人说明";
    [self addSubViews];
    self.view.backgroundColor = [UIColor whiteColor];
    // 下面两个属性的设置是与translucent为NO,坐标变换的效果一样
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.dataArr.count;
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //随便给一个cell
    //UITableViewCell *cell=[UITableViewCell new];
    MineExplainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineExplainCell"];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MineExplainCell" owner:nil options:nil] firstObject];
    }
    //MineExplainCell
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 250.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"选择了某一行");
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
