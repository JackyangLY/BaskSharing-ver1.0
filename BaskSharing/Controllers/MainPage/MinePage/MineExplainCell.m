//
//  MineExplainCell.m
//  BaskSharing
//
//  Created by Yang on 8/26/16.
//  Copyright © 2016 Jack_yy. All rights reserved.
//

#import "MineExplainCell.h"
#import "MineDetailModel.h"
#import "Common.h"

#define  MineDetailFileName @"MineDetailFile"
@interface MineExplainCell ()
/**文件路径*/
@property (nonatomic ,strong )NSString *filePath;

@end
@implementation MineExplainCell
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
+(instancetype)cellWithTableview:(UITableView *)tableview
{
    MineExplainCell *cell = [tableview dequeueReusableCellWithIdentifier:@"MineExplainCell"];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MineExplainCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;

}
/**纯代码创建时加载*/
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]  )
    {
        [self loadBasicSetting];
    }
    return self;
}
/**创建Xib时加载*/
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self loadBasicSetting];
    }
    return self;
}
/**加载默认设置UI*/
-(void)loadBasicSetting
{
    //.接档操作的
    MineDetailModel *mineModel = [NSKeyedUnarchiver unarchiveObjectWithFile:MineDetailFileName];
    if (mineModel)
    {
        self.userName.text = mineModel.StrName;
        self.Age.text = mineModel.StrAge;
        self.sex.text = mineModel.StrSex;
        self.email.text = mineModel.StrEmail;
    }
    else
    {
        
        self.userName.text = [AVUser currentUser].username;
    }
    
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    
}
//选择性别
- (IBAction)selectionSexAction:(UISegmentedControl *)segmentedControl
{//0 无 1 男 2 女
    NSInteger index = segmentedControl.selectedSegmentIndex;
    if (self.blockselectionSexAction)
    {
        self.blockselectionSexAction(index);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
