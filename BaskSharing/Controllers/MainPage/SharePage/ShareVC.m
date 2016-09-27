//
//  ShareVC.m
//  BaskSharing
//
//  Created by 洋洋 on 16/8/18.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//
#import "Common.h"
#import "ShareVC.h"
#import "ShareModel.h"
#import "LYStatusCell.h"
#import "AVOSCloud/AVQuery.h"
#import "AVCloud.h"

@interface ShareVC ()<UITableViewDataSource>
/** 很多条微博的模型 */
@property ( nonatomic, copy ) NSArray *arrStatusModels;
@property ( nonatomic, copy ) NSMutableArray *ArrInfo;
@property ( nonatomic,strong ) UITableView *tableview;

@end

@implementation ShareVC

- (NSArray *)arrStatusModels
{
    if (!_arrStatusModels)
    {
        
        _arrStatusModels = [NSArray array];
    }
    return _arrStatusModels;
}
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
    
    [self loadDefaultSetting];

    // Do any additional setup after loading the view from its nib.
}

/** 加载默认设置和UI */
- (void)loadDefaultSetting {
    [self.view setBackgroundColor:[UIColor blueColor]];
    // 自动设置当前控制器中的ScrollView的内边距(UIEdgeInsets)
    //[self setAutomaticallyAdjustsScrollViewInsets:NO];
    UITableView *tableview = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    self.tableview =tableview;
    tableview.dataSource = self;
    tableview.contentInset = UIEdgeInsetsMake(0, 0, 90, 0);
    /**添加刷新*/
    tableview.mj_header =[LYRefreshHeader headerWithRefreshingBlock:^
                               {
//                                   LYNSlog
                                   if (self.ArrInfo.count !=0)
                                   {
                                       [self requestHomeList];
                                       //[self.tableView.mj_header endRefreshing];
                                   }
                                   else
                                   {
                                       [self requestHomeList];
                                   }
                                   
                               }];
    //进入刷新状态
    [tableview.mj_header beginRefreshing];
    /**结束刷新*/
    //[self.tableView.mj_header endRefreshing];
    
    tableview.estimatedRowHeight = 40;
    tableview.sectionFooterHeight = 30;
}

-(void) requestHomeList{
      __weak typeof(self) weakSelf = self;
    AVQuery *query = [AVQuery queryWithClassName:@"Todo"];
    //小到大[query orderByAscending:@"createdAt"];
    
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
                 ShareModel *model = [ShareModel shareModelWithDictionary:dictLocalData];
                 [arrTemp addObject:model];
              }
             //刷新ui
             dispatch_async(dispatch_get_main_queue(), ^{
                 weakSelf.arrStatusModels = [arrTemp copy];
                 [weakSelf.tableview reloadData];
                 /**结束刷新*/
                 [weakSelf.tableview.mj_header endRefreshing];
             });
         }
         else
         {
//             NSLog(@"%s---%@",__FUNCTION__,error);
             /**弹框提示*/
             UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示:" message:@"您的网络信号差或已断开连接" preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
             [alertVC addAction:action];
             [self presentViewController:alertVC animated:YES completion:nil];
             /**结束刷新*/
             [weakSelf.tableview.mj_header endRefreshing];
         }
         
     }];
    
}
#pragma mark - 🔌 Delegate Methods
/** TableView中有多少个Section(分组) */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return self.arrStatusModels.count;
    return  self.arrStatusModels.count;
}
/** 在当前的Section中有多少cell(row) */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

// 只要dequeue的方法中有IndexPath, 就说明, 这个cell不是通过注册, 就是通过Storyboard中ProtoType类型创建的
/** 在IndexPath位置显示的cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYStatusCell *cell = [LYStatusCell cellWithTableView:tableView];
    
    //    LYStatusModel *status = self.arrStatusModels[indexPath.section];
    ShareModel *shares = self.arrStatusModels[indexPath.section];
    
    cell.shares = shares;
    //[cell.btnHead setImage:[UIImage imageWithData:shares.data ]forState:UIControlStateNormal];
  
    //// textLabel是懒加载的
    //cell.textLabel.text = status.strText;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消IndexPath位置cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
        return 20;
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
