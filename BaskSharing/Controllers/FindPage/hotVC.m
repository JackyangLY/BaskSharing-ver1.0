//
//  hotVC.m
//  BaskSharing
//
//  Created by Yang on 8/28/16.
//  Copyright © 2016 Jack_yy. All rights reserved.
//热点页面

#import "hotVC.h"
#import "hotCell.h"
#import "Common.h"
@interface hotVC ()<UITableViewDataSource>
@property (nonatomic ,strong) UITableView *hotTableView;

@end

@implementation hotVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBasicSetting];
}
#pragma mark 加载默认设置
-(void)loadBasicSetting
{
    self.view.backgroundColor = [UIColor redColor];
    UITableView *tabelview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tabelview];
    tabelview.dataSource = self;
    tabelview.estimatedRowHeight = 100;
    tabelview.contentInset = UIEdgeInsetsMake(0, 0, 160, 0);
    tabelview.showsVerticalScrollIndicator = NO;
    self.hotTableView = tabelview;
    /**添加刷新*/
    self.hotTableView.mj_header =[LYRefreshHeader headerWithRefreshingBlock:^
    {
        LYNSlog
        
    }];
    //进入刷新状态
    [self.hotTableView.mj_header beginRefreshing];
    /**结束刷新*/
    //[self.hotTableView.mj_header endRefreshing];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strCell = @"hotCell";
    hotCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (!cell)
    {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"hotCell" owner:self options:nil]firstObject];
    }
    cell.backgroundColor = [UIColor cyanColor];
    return cell;
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
