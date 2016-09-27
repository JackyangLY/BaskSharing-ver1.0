//
//  FindVC.m
//  BaskSharing
//
//  Created by 洋洋 on 16/8/18.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//
#import "Common.h"
#import "FindVC.h"
#import "SearchViewController.h"
#import "recommendVC.h"
#import "hotVC.h"
#import "collectVC.h"

static CGFloat const labelW = 100;

static CGFloat const radio = 1.3;
@interface FindVC ()<UIScrollViewDelegate>
@property (nonatomic, weak) UILabel *selLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollvVew;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic ,strong)NSMutableArray *titleLabels;

@end

@implementation FindVC
#pragma  mark 懒加载
-(NSMutableArray *)titleLabels
{
    if (!_titleLabels)
    {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发现";
    //[self.view setBackgroundColor:[UIColor blueColor]];
    UIButton *chookbutton = [[UIButton alloc]init];
    //UIButton *chookbutton = [[UIButton alloc]initWithFrame:CGRectMake(337, 11, 35, 35)];
    [chookbutton setImage:[UIImage imageNamed:@"tab_explore"] forState:UIControlStateNormal];
    [chookbutton setImage:[UIImage imageNamed:@"tabAll_pressed"] forState:UIControlStateHighlighted];
    [chookbutton sizeToFit];
    [chookbutton addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:chookbutton];
//    [chookbutton mas_makeConstraints:^(MASConstraintMaker *make)
//     {
//         //make.top.equalTo(self.navigationItem).offset(11);
//         //make.top.equalTo(self.navigationItem).offset(11);
//        // make.right.equalTo(self.navigationItem).offset(-38);
//         make.width.height.mas_equalTo(22);
//     }];
    // Do any additional setup after loading the view from its nib.
    [self loadBasicSetting];
}
#pragma mark 加载默认设置
-(void)loadBasicSetting
{
   // self.titleScrollvVew.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    // 1.添加所有子控制器
    [self setUpChildViewController];
    
    // 2.添加所有子控制器对应标题
    [self setUpTitleLabel];
    
    // iOS7会给导航控制器下所有的UIScrollView顶部添加额外滚动区域
    // 不想要添加
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 3.初始化UIScrollView
    [self setUpScrollView];

    
}

-(void)clickBtnAction:(UIButton *)button
{
    SearchViewController *btnVC = [SearchViewController new];
    [self.navigationController pushViewController:btnVC animated:YES];
    btnVC.view.backgroundColor = [UIColor yellowColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 初始化UIScrollView
- (void)setUpScrollView
{
    NSUInteger count = self.childViewControllers.count;
    /**设置标题滚动*/
    self.titleScrollvVew.contentSize = CGSizeMake(count * labelW, 0);
    self.titleScrollvVew.showsHorizontalScrollIndicator = NO;
    //设置内容滚动条
    self.contentScrollView.contentSize = CGSizeMake(count * LYSCREEN_WIDTH, 0);
    //开启分页
    self.contentScrollView.pagingEnabled = YES;
    //没有弹簧效果
    self.contentScrollView.bounces = NO;
    //隐藏水平滚动条
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    //设置代理
    self.contentScrollView.delegate = self;


}
// 添加所有子控制器对应标题
- (void)setUpTitleLabel
{
    NSUInteger count = self.childViewControllers.count;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelH = 44;
    for (NSInteger index = 0; index < count; index++)
    {
        //获取对应自控制器
        UIViewController *vc = self.childViewControllers[index];
        //创建label
        UILabel *label = [[UILabel alloc]init];
        labelX = index * labelW;
        //设置尺寸
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        //设置label文字
        label.text = vc.title;
        //设置高亮文字颜色
        label.highlightedTextColor = [UIColor redColor];
        //设置label的tag
        label.tag = index;
        //设置用户的交互
        label.userInteractionEnabled = YES;
        //文字居中
        label.textAlignment = NSTextAlignmentCenter;
        // 添加到titleLabels数组
        [self.titleLabels addObject:label];
        
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:tap];
        
        // 默认选中第0个label
        if (index == 0) {
            [self titleClick:tap];
        }
        
        // 添加label到标题滚动条上
        [self.titleScrollvVew addSubview:label];

    }


}
// 设置标题居中
- (void)setUpTitleCenter:(UILabel *)centerLabel
{
    // 计算偏移量
    CGFloat offsetX = centerLabel.center.x - LYSCREEN_WIDTH * 0.5;
    
    if (offsetX < 0) offsetX = 0;
    
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.titleScrollvVew.contentSize.width - LYSCREEN_WIDTH;
    
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    
    
    // 滚动标题滚动条
    [self.titleScrollvVew setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}
#pragma mark - UIScrollViewDelegate
// scrollView一滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat curPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // 左边label角标
    NSInteger leftIndex = curPage;
    // 右边的label角标
    NSInteger rightIndex = leftIndex + 1;
    
    // 获取左边的label
    UILabel *leftLabel = self.titleLabels[leftIndex];
    
    // 获取右边的label
    UILabel *rightLabel;
    if (rightIndex < self.titleLabels.count - 1) {
        rightLabel = self.titleLabels[rightIndex];
    }
    
    // 计算下右边缩放比例
    CGFloat rightScale = curPage - leftIndex;
    NSLog(@"rightScale--%f",rightScale);
    
    // 计算下左边缩放比例
    CGFloat leftScale = 1 - rightScale;
    NSLog(@"leftScale--%f",leftScale);
    
    // 0 ~ 1
    // 1 ~ 2
    // 左边缩放
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * 0.3 + 1, leftScale * 0.3+ 1);
    
    // 右边缩放
    rightLabel.transform = CGAffineTransformMakeScale(rightScale * 0.3 + 1, rightScale * 0.3+ 1);
    
    // 设置文字颜色渐变
    /*
     R G B
     黑色 0 0 0
     红色 1 0 0
     */
    leftLabel.textColor = [UIColor colorWithRed:leftScale green:0 blue:0 alpha:1];
    rightLabel.textColor = [UIColor colorWithRed:rightScale green:0 blue:0 alpha:1];
    
    NSLog(@"%f",curPage);


}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    
    
    CGFloat offsetX = scrollView.contentOffset.x;
    /**打印此方法*/
    NSLog(@"%s\n%f",__func__,offsetX);
    

    
    // 1.添加子控制器view
    [self showVc:index];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.titleLabels[index];
    
    [self selectLabel:selLabel];
    
    // 3.让选中的标题居中
    [self setUpTitleCenter:selLabel];
    

}
// 显示控制器的view
- (void)showVc:(NSInteger)index
{
    CGFloat offsetX = index * LYSCREEN_WIDTH;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    
    
    [self.contentScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, LYSCREEN_WIDTH, LYSCREEN_HEIGHT);

    

}
// 点击标题的时候就会调用
- (void)titleClick:(UITapGestureRecognizer *)tap
{
    // 0.获取选中的label
    UILabel *selLabel = (UILabel *)tap.view;
    
    // 1.标题颜色变成红色,设置高亮状态下的颜色
    [self selectLabel:selLabel];
    
    // 2.滚动到对应的位置
    NSInteger index = selLabel.tag;
    // 2.1 计算滚动的位置
    CGFloat offsetX = index * LYSCREEN_WIDTH;
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 3.给对应位置添加对应子控制器
    [self showVc:index];
    
    // 4.让选中的标题居中
    [self setUpTitleCenter:selLabel];
    

}
// 选中label
- (void)selectLabel:(UILabel *)label
{
    // 取消高亮
    _selLabel.highlighted = NO;
    // 取消形变
    _selLabel.transform = CGAffineTransformIdentity;
    // 颜色恢复
    _selLabel.textColor = [UIColor blackColor];
    
    // 高亮
    label.highlighted = YES;
    // 形变
    label.transform = CGAffineTransformMakeScale(radio, radio);
    
    _selLabel = label;
    

    
}
// 添加所有子控制器
- (void)setUpChildViewController
{
    //推荐
    recommendVC *recomVC = [[recommendVC alloc]init];
    recomVC.title = @"推荐";
    [self addChildViewController:recomVC];
    //热点
    hotVC *hotvc = [[hotVC alloc]init];
    hotvc.title = @"热点";
    [self addChildViewController:hotvc];
    //收藏
    collectVC *collectvc =[[collectVC alloc]init];
    collectvc.title = @"收藏";
    [self addChildViewController:collectvc];
    //其他
    UIViewController *vc = [[UIViewController alloc]init];
    vc.title = @"其他";
    [self addChildViewController:vc];
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
