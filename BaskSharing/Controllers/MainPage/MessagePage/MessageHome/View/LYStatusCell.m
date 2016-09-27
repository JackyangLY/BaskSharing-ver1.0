//
//  LYStatusCell.m
//  青云微博
//
//  Created by qingyun on 16/7/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "LYStatusCell.h"
#import "LYStatusModel.h"
//#import "UIButton+WebCache.h"
#import "LYUserModel.h"
#import "ShareModel.h"

#import "Common.h"

// cell中所有的判断必须全面, 否则信息会部队称
@interface LYMessageCell ()
//发表时间
@property (weak, nonatomic) IBOutlet UILabel *updateTime;
//发表标题
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation LYMessageCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *strId = @"LYMessageCell";
    LYMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:strId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LYMessageCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

- (void)setStatus:(LYStatusModel *)status
{
    _status = status;
    //self.updateTime.text = status.strTimeCreatedAt;
    NSString *strDay = status.strTimeCreatedAt;
     self.updateTime.text = [self stringWithDate:strDay];
    
    self.lblTitle.text = status.StrContent;
    
}
-(NSString *)stringWithDate:(NSString *)string
{
    // 1, 获取当前的时间
    NSDate *dateNow = [NSDate date];
    
    // 2, 获得发布时间
    NSDateFormatter *formatter = [NSDateFormatter new];
    //formatter.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *datePunlish = [formatter dateFromString:string];
    //NSDate *datePunlish = [NSDate dateWithTimeIntervalSinceNow:-100];
    
    // 3, 计算两个时间的时间差
    NSTimeInterval interval =[dateNow timeIntervalSinceDate:datePunlish];
    
    // 4, 根据时间差的结果进行分类, 刚刚(1分钟内), 几分钟前, 几个小时之前, 几天前.....

    NSString *strDay = nil;
    if (interval <= 60 * 4) { // 4分钟内
        strDay = @"刚刚";
    } else if (interval <= 60 * 60) { // 一个小时内
        strDay = [NSString stringWithFormat:@"%ld分钟前", (NSInteger)interval / 60 + 1];
    } else if (interval <= 60 * 60 * 24) { // 几个小时之前
        strDay = [NSString stringWithFormat:@"%ld小时前", (NSInteger)interval / (60 * 60) + 1];
    } else { // 几天前
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        strDay = [formatter stringFromDate:datePunlish];
    }
    
    return strDay;
}

@end
@interface LYStatusCell ()

/** 头像按钮 */
//@property (weak, nonatomic) IBOutlet UIButton *btnHead;
/** 博主昵称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 创建时间 */
//@property (weak, nonatomic) IBOutlet UILabel *lblTime;
/** 发布来源 */
@property (weak, nonatomic) IBOutlet UILabel *lblSource;
/** 微博主内容 */
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
/** 微博的图片 */
@property (weak, nonatomic) IBOutlet UIView *viewContentImages;
/** 转发的内容 */
@property (weak, nonatomic) IBOutlet UILabel *lblRetweetContent;
/** 转发内容中的图片 */
@property (weak, nonatomic) IBOutlet UIView *viewRetweetImages;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcContentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcRetweetHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcBottomRetweetContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lcBottomRetweetImage;

@end


@implementation LYStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *strId = @"LYStatusCell";
    LYStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:strId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LYStatusCell" owner:nil options:nil] firstObject];
    }
    return cell;
}

/** nib加载完毕的时候调用(所有的outlet属性都已经赋值) */
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btnHead.layer.cornerRadius = 25.0;
    self.btnHead.layer.masksToBounds = YES;
}
-(void)setShares:(ShareModel *)shares
{
    _shares = shares;
    //发表的用户名昵称
    NSString *shareName = @"匿名";
    //发表的用户头像
    UIImage *shareUseImage =[UIImage imageNamed:@"album_photo_camera_75x75_@1x"];
    
    AVUser *currentUser = [AVUser currentUser];
    //用户名 /username 不可更改 name可改
    NSString *username = currentUser[@"name"];//用户昵称
    NSData *userimage =currentUser[@"userImage"];//用户头像
    if(![shares.StrName isEqualToString:currentUser.username])
    {//说说中的名字与用户中的username不相同
        if ([shares.StrName isEqualToString:@""])
        {
            
        }
        if (shares.data == nil)
        {
            
        }
        else
        {
          shareName  = shares.StrName;
          shareUseImage = [UIImage imageWithData:shares.data];
        }
    }
    else
    {//说说中的名字与用户中的username相同
        
        shareName = username;
        shareUseImage = [UIImage imageWithData:userimage];
    }
        //用户名
//    self.lblName.text = shares.StrName;
    self.lblName.text = shareName;
    //头像
//    UIImage *image = [UIImage imageWithData:shares.data];
//    [self.btnHead setImage:image forState:UIControlStateNormal];
    [self.btnHead setImage:shareUseImage forState:UIControlStateNormal];
    //时间
    self.lblTime.text = shares.strTimeCreatedAt;
    //标题
    self.lblSource.text = shares.StrTitle;
    //内容
    self.lblContent.text = shares.StrContent;
    //内容图片
    [self loadImageDatas:shares.arrData forView:self.viewContentImages];
    
}

- (void)setStatus:(LYStatusModel *)status {
    _status = status;
    
    // 设置头像
   // NSURL *url = [NSURL URLWithString:status.user.strProfileImageUrl];
    //[self.btnHead sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
    
    // 设置昵称
    //self.lblName.text = status.user.strScreenName;
    

    self.lblName.text = [[AVUser currentUser]objectForKey:@"name"];
    UIImage *image = [UIImage imageWithData:status.data];
    
    [self.btnHead setImage:image forState:UIControlStateNormal];
    // 设置创建时间
   // self.lblTime.text = status.strTimeDes;
   // NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //fmt.dateFormat = @"yyyy/MM/dd : HH:mm:ss";
    //self.lblTime.text = [NSString stringWithFormat:@"%@",[fmt stringFromDate: status.strTimeCreatedAt]];
    self.lblTime.text = status.strTimeCreatedAt;
    
    // 设置来源
    //self.lblSource.text = status.strSourceDes;
    self.lblSource.text = status.StrTitle;
    
    // 设置微博内容
    //self.lblContent.text = status.strText;
    self.lblContent.text = status.StrContent;
    //微博图片
    [self loadImageDatas:status.arrData forView:self.viewContentImages];
//    // 转发
//    LYStatusModel *retweetedStatus = status.retweetedStatus;
//    if (retweetedStatus == nil) { // 没有转发
//        self.lblRetweetContent.text = nil;
//        
//        // 如果有图片就设置图片
//        [self loadImageDatas:status.arrData forView:self.viewContentImages];
//       // [self loadImageURLs:status.arrPicUrls forView:self.viewContentImages];
//        [self loadImageURLs:nil forView:self.viewRetweetImages];
//        self.lcBottomRetweetImage.constant = 0;
//        self.lcBottomRetweetContent.constant = 0;
//        
//    } else { // 转发
//        self.lblRetweetContent.text = retweetedStatus.strText;
//        
//        [self loadImageURLs:nil forView:self.viewContentImages];
//        [self loadImageURLs:retweetedStatus.arrPicUrls forView:self.viewRetweetImages];
//        
//        self.lcBottomRetweetImage.constant = 8;
//        self.lcBottomRetweetContent.constant = 8;
//    }
}
- (void)loadImageDatas:(NSArray *)arrDatas forView:(UIView *)view {
    // 清除之前添加的所有的ImageView
    [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger count = arrDatas.count;
    NSInteger lineCount = 3;
    CGFloat space = 8;
    CGFloat width = (LYSCREEN_WIDTH - 4 * space) / lineCount;
    CGFloat height = width;
    
    // 调整view的高度
    // 有多少行
    NSInteger line = (count + lineCount - 1) / lineCount;
    CGFloat heightView = 0;
    if (line) {
        heightView = space + (space + height) * line;
    }
    
    if (view == self.viewContentImages) {
        self.lcContentHeight.constant = heightView;
    } else {
        self.lcRetweetHeight.constant = heightView;
    }
    
    // 如果图片的数量是0 直接返回
    if (count == 0) return;
    
    // 添加ImageView
    for (NSUInteger index = 0; index < count; index ++) {
        UIImageView *imageView = [UIImageView new];
        //[imageView sd_setImageWithURL:[NSURL URLWithString:arrURLs[index][@"thumbnail_pic"]] placeholderImage:[UIImage imageNamed:@"social-placeholder"]];
        UIImage *imageData = [UIImage imageWithData:arrDatas[index]];
        imageView.image = imageData;
            [view addSubview:imageView];
        CGFloat X = space + (index % lineCount) * (width + space);
        CGFloat Y = space + (index / lineCount) * (height + space);
        imageView.frame = CGRectMake(X, Y, width, height);
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
    }
}

@end
