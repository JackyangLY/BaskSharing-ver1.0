//
//  QYHomeViewController.m
//  青云微博
//
//  Created by qingyun on 16/7/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//消息


#import "LYHomeViewController.h"
#import "LYStatusModel.h"
#import "LYStatusCell.h"
#import "LYFooterView.h"
#import "LYDetailViewController.h"
#import "PhotoViewController.h"
#import "LoginPageVC.h"
#import "AVOSCloud/AVQuery.h"
#import "AVCloud.h"
#import "Common.h"

@interface LYHomeViewController () <NSObject>

/** 很多条微博的模型 */
@property (nonatomic, copy) NSArray *arrStatusModels;

@property (nonatomic ,copy) NSArray *arrTesting;
//发表时间
@property (nonatomic ,strong) NSDate *DataCreatedAT;

@property(nonatomic,copy) NSMutableArray *ArrInfo;

@end

@implementation LYHomeViewController
-(NSArray *)arrTesting
{
    if (!_arrTesting)
    {
        _arrTesting = [NSArray array];
    }
    return _arrTesting;
}

- (NSArray *)arrStatusModels {
    if (!_arrStatusModels) {
        NSString *strFilePath=[[NSBundle mainBundle] pathForResource:@"status" ofType:@"plist"];
        NSDictionary *dicStatuses=[NSDictionary dictionaryWithContentsOfFile:strFilePath];
        NSArray *arrStatuses=dicStatuses[@"statuses"];
        NSMutableArray *arrMStatusModels=[NSMutableArray arrayWithCapacity:arrStatuses.count];
        for (NSDictionary *dicData in arrStatuses) {
            LYStatusModel *status = [LYStatusModel statusModelWithDictionary:dicData];
            [arrMStatusModels addObject:status];
        }
        _arrStatusModels = [arrMStatusModels copy];
    }
    return _arrStatusModels;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDefaultSetting];
    [self loadBasicSetting];
   
}
- (void)viewWillAppear:(BOOL)animated{
//    //1.判断accessToken值是否存在
//    NSLog(@"viewWillAppear %@",[QYAccessToken shareInstance].access_token);
//    if ([QYAccessToken shareInstance].access_token) {
//        self.navigationItem.rightBarButtonItem=nil;
//        [self requestHomeList];
    //}
}

#pragma mark 加载默认设置
-(void)loadBasicSetting
{
    self.navigationItem.title = @"消息";
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    UIButton *buttonN = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonN setImage:[UIImage imageNamed:@"comment-bar-write-icon_20x20_"] forState:UIControlStateNormal];
//    [buttonN setImage:[UIImage imageNamed:] forState:UIControlStateHighlighted];
    [buttonN setTitle:@"发表" forState:UIControlStateNormal];
    [buttonN sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:buttonN];
    buttonN.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [buttonN addTarget:self action:@selector(editingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

#pragma  mark 右侧编辑按钮点击事件
//编辑按钮
-(void)editingBtnAction
{
    if (![AVUser currentUser].username)
    {
        LoginPageVC *loginVC = [[LoginPageVC alloc]init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    else
    {
    PhotoViewController *photoVC = [[PhotoViewController alloc]init];
    [self.navigationController pushViewController:photoVC animated:YES];
    }
    
    // EditingVC *editingVC = [[EditingVC alloc]init];
    // [self.navigationController pushViewController:editingVC animated:YES];
}

/** 加载默认设置和UI */
- (void)loadDefaultSetting {
    [self.view setBackgroundColor:[UIColor blueColor]];
    // 自动设置当前控制器中的ScrollView的内边距(UIEdgeInsets)
    //[self setAutomaticallyAdjustsScrollViewInsets:NO];
    /**添加刷新*/
      __weak typeof(self) weakSelf = self;
    self.tableView.mj_header =[LYRefreshHeader headerWithRefreshingBlock:^
                                  {
                                      
                                      UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"em_info_none"]];
                                      if (weakSelf.arrStatusModels.count !=0)
                                      {
                                          
                                          [weakSelf requestHomeList];
                                          //[self.tableView.mj_header endRefreshing];
                                      }
                                      else
                                      {
                                          [weakSelf.view addSubview:imageview];
                                          [weakSelf.view sendSubviewToBack:imageview];
                                          [imageview mas_makeConstraints:^(MASConstraintMaker *make)
                                           {
                                               make.center.equalTo(weakSelf.view);
                                               make.width.height.equalTo(imageview);
                                           }];
                                      [weakSelf requestHomeList];
                                      }
                                      
                                  }];
    //进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    /**结束刷新*/
    //[self.tableView.mj_header endRefreshing];
    
    self.tableView.estimatedRowHeight = 40;
    self.tableView.sectionFooterHeight = 30;
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn:)];
    self.navigationItem.rightBarButtonItem=rightItem;
}
-(void)rightBtn:(UIBarButtonItem *)button
{
    LoginPageVC *pageVC = [[LoginPageVC alloc]init];
    [self.navigationController pushViewController:pageVC animated:YES];
}
#pragma  mark 请求数据📚
-(void) requestHomeList{
    __weak LYHomeViewController *home=self;
    AVQuery *query = [AVQuery queryWithClassName:@"Todo"];
    //小到大[query orderByAscending:@"createdAt"];
    //递增[query addAscendingOrder:@"createdAt"];
    [query orderByDescending:@"createdAt"];//递减
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {

         if (!error)
         {
             self.ArrInfo = [objects copy];
             
             NSArray<AVObject *> *todos = objects;
             NSMutableArray *arrTemp = [NSMutableArray arrayWithCapacity:todos.count];
             for (AVObject *todo in todos)
             {
                 NSDictionary *dictLocalData = todo[@"localData"];
                 LYStatusModel *model = [LYStatusModel statusModelWithDictionary:dictLocalData];
                 if([model.StrName isEqualToString:[AVUser currentUser].username])
                 {
                 [arrTemp addObject:model];
                 }
             }
             //刷新ui
             dispatch_async(dispatch_get_main_queue(), ^{
             home.arrTesting = [arrTemp copy];
             [home.tableView reloadData];
             /**结束刷新*/
             [home.tableView.mj_header endRefreshing];
             });
         }
         else
         {
//             NSLog(@"%s---%@",__FUNCTION__,error);
             UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示:" message:@"您的网络信号差或已断开连接" preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
             [alertVC addAction:action];
             [self presentViewController:alertVC animated:YES completion:nil];
             /**结束刷新*/
             [self.tableView.mj_header endRefreshing];

         }
         
     }];
}
#pragma mark - 🔌 Delegate Methods
/** TableView中有多少个Section(分组) */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return self.arrStatusModels.count;
    return  self.arrTesting.count;
}
/** 在当前的Section中有多少cell(row) */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

// 只要dequeue的方法中有IndexPath, 就说明, 这个cell不是通过注册, 就是通过Storyboard中ProtoType类型创建的
/** 在IndexPath位置显示的cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //LYStatusCell *cell = [LYStatusCell cellWithTableView:tableView];
    LYMessageCell *cell = [LYMessageCell cellWithTableView:tableView];
    
//    LYStatusModel *status = self.arrStatusModels[indexPath.section];
    LYStatusModel *status = self.arrTesting[indexPath.section];
    
    cell.status = status;
//    if(indexPath.section !=0)
//    {
//         LYStatusModel *status = self.arrTesting[0];
//        [cell.btnHead setImage:[UIImage imageWithData:status.data]forState:UIControlStateNormal];
//    }

    //// textLabel是懒加载的
    //cell.textLabel.text = status.strText;
    
  
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消IndexPath位置cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LYDetailViewController *vcDetail = [LYDetailViewController new];
   // vcDetail.status = self.arrStatusModels[indexPath.section];
    vcDetail.status = self.arrTesting[indexPath.section];
    [self.navigationController pushViewController:vcDetail animated:YES];
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    LYFooterView *footer = [LYFooterView footerViewWithTableView:tableView];
//    footer.contentView.backgroundColor = [UIColor whiteColor];
//    //footer.status = self.arrStatusModels[section];
//    return footer;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    } else {
//        return 20;
        return 0.01;
    }
}

@end
