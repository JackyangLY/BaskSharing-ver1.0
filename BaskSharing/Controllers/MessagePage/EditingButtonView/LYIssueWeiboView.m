//
//  ZFIssueWeiboView.m
//  ZFIsuueWeiboDemo
//
//  Created by 张锋 on 16/5/24.
//  Copyright © 2016年 张锋. All rights reserved.
//

#import "LYIssueWeiboView.h"
#import "LYWeiboButton.h"
#import "UIView+ZF.h"
#import "Common.h"

#define buttonWH 100 // 按钮宽高
static CGFloat const tabbarH = 40.;
static CGFloat const tabbarImgWH = 30.;
static NSInteger const ButtonTag = 100;


@interface LYIssueWeiboView ()  <ZFWeiboButtonDelegate>
@property (nonatomic, strong) UIView *tabbar;
@property (nonatomic, strong) UIImageView *inerImgView;
@property (nonatomic, strong) UIVisualEffectView *backView;
@end

@implementation LYIssueWeiboView

+ (instancetype)initIssueWeiboView
{
    return [[LYIssueWeiboView alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (UIView *)tabbar
{
    if (!_tabbar) {
        _tabbar = [[UIView alloc] init];
        _tabbar.frame = CGRectMake(0, LYSCREEN_HEIGHT - tabbarH, LYSCREEN_WIDTH, tabbarH);
        _tabbar.backgroundColor = [UIColor whiteColor];
        
        _inerImgView = [[UIImageView alloc] init];
        _inerImgView.frame = CGRectMake((LYSCREEN_WIDTH-tabbarImgWH) / 2,
                                        5,
                                        tabbarImgWH,
                                        tabbarImgWH);
        _inerImgView.image = [UIImage imageNamed:@"tabbar_compose_background_icon_add"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(tabbarClicked)];
        [_tabbar addSubview:_inerImgView];
        [_tabbar addGestureRecognizer:tap];
        
        [UIView animateWithDuration:0.2 animations:^{
            self.inerImgView.transform = CGAffineTransformMakeRotation(M_PI_4);
        }];
    }
    return _tabbar;
}

- (UIVisualEffectView *)backView
{
    if (!_backView) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        _backView = [[UIVisualEffectView alloc] initWithEffect:blur];
        _backView.frame = CGRectMake(0, 0, LYSCREEN_WIDTH, LYSCREEN_HEIGHT);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(viewHiddenAnimation)];
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

#pragma mark - tabbar点击事件
- (void)tabbarClicked
{
    [self viewHiddenAnimation];
}

#pragma mark - 视图消失动画
- (void)viewHiddenAnimation
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[LYWeiboButton class]]) {
            [tempArray addObject:view];
        }
    }
    NSArray *array = [[tempArray reverseObjectEnumerator] allObjects];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.tabbar.alpha = 0;
        self.inerImgView.transform = CGAffineTransformMakeRotation(- M_PI_4);
    } completion:nil];
    
    for (int i=0; i<array.count; i++) {
        LYWeiboButton *button =  (LYWeiboButton *)array[i];
        [UIView animateWithDuration:0.4 delay:0.05 * i  usingSpringWithDamping:0.7 initialSpringVelocity:15 options:UIViewAnimationOptionCurveLinear animations:^{
            button.y = LYSCREEN_HEIGHT;
        } completion:^(BOOL finished) {
            [button removeFromSuperview];
            [UIView animateWithDuration:0.1 animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
    }
}

- (void)createSubviews
{
    [self addSubview:self.backView];
    [self addSubview:self.tabbar];
    NSArray *titles = @[@"",@"",@"",@"新浪微博",@"Qzone",@"朋友圈"];
    NSArray *fImages = @[@"",@"",@"",@"weibo",
                         @"qqzone",
                         @"friendquan"];

//    NSArray *titles = @[@"新浪微博",@"Qzone",@"朋友圈",@"签到",@"评论",@"更多"];
//    NSArray *fImages = @[@"weibo",
//                         @"qqzone",
//                         @"friendquan",
//                         @"tabbar_compose_lbs",
//                         @"tabbar_compose_review",
//                         @"tabbar_compose_more"];
    if (!self.titles) {
        self.titles = titles;
    }
    if (!self.images) {
        self.images = fImages;
    }
    
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i=0; i<self.titles.count; i++) {
        CGFloat lefSpacing = (LYSCREEN_WIDTH - (buttonWH*3)) / 5;
        CGFloat midSpacing = lefSpacing * 1.5;
        CGFloat buttonX = lefSpacing + (midSpacing+buttonWH) * (i%3);
        
        LYWeiboButton *button = [LYWeiboButton buttonWithFrame:CGRectMake(buttonX,
                                                                LYSCREEN_HEIGHT,
                                                                buttonWH,
                                                                buttonWH)
                                               image:self.images[i]
                                               title:self.titles[i]];
        button.btnTag = ButtonTag + i;
        button.delegate = self;
        [mArray addObject:button];
        [self addSubview:button];
    }
    
    /**
     *  usingSpringWithDamping：0-1 数值越小，弹簧振动效果越明显
     *  initialSpringVelocity ：数值越大，一开始移动速度越快
     */
    for (int i=0; i<mArray.count; i++) {
        CGFloat topSpacing = (LYSCREEN_HEIGHT-40) / 2;
        CGFloat buttonY = topSpacing + (buttonWH+30) * (i/3);
        LYWeiboButton *button = mArray[i];
        
        [UIView animateWithDuration:0.3 delay:0.05*i  usingSpringWithDamping:0.7 initialSpringVelocity:15 options:UIViewAnimationOptionCurveLinear animations:^{
            button.y = buttonY;
        } completion:nil];
    }
}

- (void)WeiboButtonClick:(LYWeiboButton *)button
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[LYWeiboButton class]]) {
            [array addObject:view];
        }
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        button.alpha = 0;
        button.transform = CGAffineTransformMakeScale(3.0, 3.0);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        for (int i=0; i<array.count; i++) {
            LYWeiboButton *wbButton = (LYWeiboButton *)array[i];
            if (button != wbButton) {
                wbButton.transform = CGAffineTransformMakeScale(0.3, 0.3);
                wbButton.alpha = 0;
            }
        }
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.delegate && [self.delegate respondsToSelector:@selector(animationHasFinishedWithButton:)]) {
            [self.delegate animationHasFinishedWithButton:button];
        }
    }];
}

@end
