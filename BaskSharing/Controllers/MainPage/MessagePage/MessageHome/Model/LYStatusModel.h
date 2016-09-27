//
//  QYStatusModel.h
//  青云微博
//
//  Created by qingyun on 16/7/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LYUserModel;

@interface LYStatusModel : NSObject

/*说说*/
/*content = "\U8bf4\U70b9\U4ec0\U4e48\U5427nihao";
 name = 18037458635;
 title = "\U8bf4\U8bf4";
 }, estimatedData:{
 }, relationData:{
 }>
*/
/**内容*/
@property (nonatomic,strong) NSString *StrContent;
/**用户名*/
@property (nonatomic,strong) NSString *StrName;
/**标题*/
@property (nonatomic,strong) NSString *StrTitle;
/**用户图片*/
@property (nonatomic,strong) NSData *data;
/**发表图片*/
@property (nonatomic,copy) NSArray *arrData;
/**发表时间*/
@property (nonatomic, strong) NSString *strTimeCreatedAt;
/*estimatedDataModel*/

/*relationDataModel*/




/** QYStatusModel模型初始化方法 */
+ (instancetype)statusModelWithDictionary:(NSDictionary *)dicData;

@end
