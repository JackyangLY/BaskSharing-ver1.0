//
//  LYRefreshHeader.m
//  BaskSharing
//
//  Created by Yang on 9/6/16.
//  Copyright © 2016 Jack_yy. All rights reserved.
//封装MJRefresh

#import "LYRefreshHeader.h"
#import "Common.h"
@interface LYRefreshHeader ()
@property (nonatomic ,weak) UIImageView *logoImage;
@end
@implementation LYRefreshHeader
//初始化
-(void)prepare
{
    [super prepare];

    //自动切换透明度

    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor cyanColor];
    self.stateLabel.textColor = [UIColor cyanColor];
    /** 普通闲置状态 */
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    /** 松开就可以进行刷新的状态 */
    [self setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    /** 正在刷新中的状态 */
    [self setTitle:@"小Y正在为你拼命加载" forState:MJRefreshStateRefreshing];
    
    UIImageView *logoImage = [[UIImageView alloc]init];
    logoImage.image = [UIImage imageNamed:@"app_slogan_202x20_@1x"];
    [self addSubview:logoImage];
    self.logoImage = logoImage;
    
 
}
#pragma  mark 布局子视图
-(void)placeSubviews
{
    [super placeSubviews];
    self.logoImage.LY_wideth = self.LY_wideth;
    self.logoImage.LY_height = 50;
    self.logoImage.LY_X = 0;
    self.logoImage.LY_Y = -50;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
