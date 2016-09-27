//
//  recommendVC.m
//  BaskSharing
//
//  Created by Yang on 8/28/16.
//  Copyright © 2016 Jack_yy. All rights reserved.
//推荐页面

#import "recommendVC.h"
#import "recommendCell.h"
#import "hotCell.h"
/**随机色*/
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
@interface recommendVC ()<UITableViewDataSource>

@property (nonatomic , weak) UITableView *tableview;

@end

@implementation recommendVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadBasicSetting];
}
#pragma mark 加载默认设置
-(void)loadBasicSetting
{
    self.view.backgroundColor = [UIColor blueColor];
    UITableView *tableview = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    tableview.dataSource = self;
    tableview.estimatedRowHeight = 100;
    tableview.contentInset = UIEdgeInsetsMake(0, 0, 160, 0);
    tableview.showsVerticalScrollIndicator = NO;
    self.tableview = tableview;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arc4random_uniform(10);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        hotCell *headercell = [tableView dequeueReusableCellWithIdentifier:@"hotCell"];
        
        if (!headercell)
        {
            
            headercell = [[[NSBundle mainBundle] loadNibNamed:@"hotCell" owner:self options:nil]firstObject];
        }
        return headercell;
    }
    else
    {
    recommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommendCell"];

    if (!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"recommendCell" owner:nil options:nil] firstObject];
    }
    cell.backgroundColor =RandomColor;
    return cell;
    }
     
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
