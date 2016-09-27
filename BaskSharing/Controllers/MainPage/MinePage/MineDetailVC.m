//
//  MineDetailVC.m
//  BaskSharing
//
//  Created by Yang on 9/20/16.
//  Copyright © 2016 Jack_yy. All rights reserved.
//修改个人信息

#import "MineDetailVC.h"
#import "Common.h"
#import "MineDetailModel.h"
#define  MineDetailFileName @"MineDetailFile"
#define kGapWidth 10
#define kTextFeiledWidth 100
@interface MineDetailVC ()
/**文件路径*/
@property (nonatomic ,strong )NSString *filePath;
@property(nonatomic,weak) UITextField *textName;
@property(nonatomic,weak) UITextField *textSex;
@property(nonatomic,weak) UITextField *textAge;
@property(nonatomic,weak) UITextField *textEmail;

@property (nonatomic ,strong) UIDatePicker *datapicker;
@end

@implementation MineDetailVC

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBasicSetting];
}
#pragma mark 加载默认设置
-(void)loadBasicSetting
{
    self.navigationItem.title = @"修改个人信息";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setUI];
    
    
}
-(void)setUI
{

    UILabel *lblName = [[UILabel alloc]init];
    lblName.text = @"昵称:";
    [self.view addSubview:lblName];
      __weak typeof(self) weakSelf = self;
    [lblName mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.top.mas_equalTo(weakSelf.view).mas_offset(kGapWidth*10);
        make.centerX.mas_equalTo(weakSelf.view).mas_offset(-kGapWidth*8);
    }];
    
    UITextField *textName = [[UITextField alloc]init];
    [self.view addSubview:textName];
    self.textName =textName;
    [textName setBackgroundColor:[UIColor grayColor]];
    [textName mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.mas_equalTo(lblName);
        make.leading.mas_equalTo(lblName.mas_trailing).mas_offset(kGapWidth);
        make.width.mas_equalTo(kTextFeiledWidth);
        make.height.mas_equalTo(kGapWidth*3);
    }];
    
    UILabel *lblSex = [[UILabel alloc]init];
    [self.view addSubview:lblSex];
    lblSex.text = @"性别:";
    [lblSex mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.leading.mas_equalTo(lblName);
        make.top.mas_equalTo(lblName.mas_bottom).mas_offset(kGapWidth*5);
        
    }];
    
    UITextField *textSex = [[UITextField alloc]init];
    [self.view addSubview:textSex];
    self.textSex = textSex;
    [textSex setBackgroundColor:[UIColor grayColor]];
    [textSex mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.mas_equalTo(lblSex);
        make.leading.mas_equalTo(textName);
        make.width.height.mas_equalTo(textName);
    }];
    
    UILabel *lblAge = [[UILabel alloc]init];
    [self.view addSubview:lblAge];
    lblAge.text = @"生日:";
    [lblAge mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.leading.mas_equalTo(lblSex);
        make.top.mas_equalTo(lblSex.mas_bottom).mas_offset(kGapWidth*5);
        
    }];
    
    UITextField * textAge = [[UITextField alloc]init];
    [self.view addSubview:textAge];
    self.textAge = textAge;
    [textAge setBackgroundColor:[UIColor grayColor]];
    [textAge mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.leading.mas_equalTo(textSex);
         make.centerY.mas_equalTo(lblAge);
         make.width.height.mas_equalTo(textSex);
        
    }];
    UIDatePicker *datapicker = [UIDatePicker new];
    datapicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_ch"];
    datapicker.datePickerMode = UIDatePickerModeDate;//日期选择
    datapicker.date = [NSDate dateWithTimeIntervalSince1970:20*365*24*60*60];
    
    [datapicker addTarget:self action:@selector(changedValueAction:) forControlEvents:UIControlEventValueChanged];
    self.datapicker = datapicker;
    self.textAge.inputView = datapicker;
    
    UILabel *lblEail = [[UILabel alloc]init];
    [self.view addSubview:lblEail];
    lblEail.text = @"邮箱:";
    [lblEail mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.leading.mas_equalTo(lblAge);
        make.top.mas_equalTo(lblAge.mas_bottom).mas_offset(kGapWidth*5);
        
    }];
    UITextField *textEail = [[UITextField alloc]init];
    [self.view addSubview:textEail];
    self.textEmail = textEail;
    [textEail setBackgroundColor:[UIColor grayColor]];
    [textEail mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerY.mas_equalTo(lblEail);
        make.leading.mas_equalTo(textAge);
        make.width.height.mas_equalTo(textAge);
    }];
    
    UIButton *saveButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
    saveButton.layer.borderWidth = 2.0;
    saveButton.layer.cornerRadius = 10.0;
    saveButton.clipsToBounds = YES;
    [saveButton setTitle:@"确认信息" forState:UIControlStateNormal];
    [saveButton setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:saveButton];
    [saveButton addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(textEail.mas_bottom).mas_offset(kGapWidth*5);
    }];
}
#pragma  mark 年龄
- (void)changedValueAction:(UIDatePicker *)datapicker
{
    //NSLog(@"%s\n%@",__func__,datapicker.date);
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *strDate = [formatter stringFromDate:datapicker.date];
    self.textAge.text = strDate;
    
}

#pragma  mark 保存个人信息
-(void)saveBtnAction
{
    if ([self saveDataTolocation])
    {
        
//        NSString *strMessage = @"存储成功";
       // NSLog(@"%s归档序列化保存成功",__func__);
        /**弹框提示*/
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"保存提示:" message:@"储存成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)saveDataTolocation
{
    MineDetailModel *mineModel = [[MineDetailModel alloc]init];
    if (![self.textName.text isEqualToString:@""])
    {
        
        mineModel.StrName = self.textName.text;
        mineModel.StrAge = self.textAge.text;
        mineModel.StrSex = self.textSex.text;
        mineModel.StrEmail = self.textEmail.text;
        /**序列化操作，把实体model 存储到本地磁盘当中，操作时自动调用实体中encodeWithCoder(NSCoding协议)方法*/
        //    [[AVUser currentUser] setObject: self.textName.text forKey:@"name"];
        //    [[AVUser currentUser] setObject:self.textAge.text forKey:@"age"];
        //    [[AVUser currentUser] setObject:self.textSex.text forKey:@"sex"];
        //    [[AVUser currentUser] setObject:self.textEmail.text forKey:@"email"];
        [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         {
             if (succeeded)
             {
                 [[AVUser currentUser] setObject: self.textName.text forKey:@"name"];
                 [[AVUser currentUser] setObject:self.textAge.text forKey:@"age"];
                 [[AVUser currentUser] setObject:self.textSex.text forKey:@"sex"];
                 [[AVUser currentUser] setObject:self.textEmail.text forKey:@"useremail"];
                 [[AVUser currentUser] saveInBackground];
             }
             else
             {
                 /**弹框提示*/
                 UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示:" message:@"失败" preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction *action = [UIAlertAction actionWithTitle:@"重新修改" style:UIAlertActionStyleCancel handler:nil];
                 [alertVC addAction:action];
                 [self presentViewController:alertVC animated:YES completion:nil];
             }
         }];
        
    }
    else
    {
        /**弹框提示*/
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"修改信息:" message:@"失败，昵称不能为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
        

    }
    return [NSKeyedArchiver archiveRootObject:mineModel toFile:self.filePath];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textName resignFirstResponder];
    [_textAge resignFirstResponder];
    [_textSex resignFirstResponder];
    [_textEmail resignFirstResponder];
    
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
