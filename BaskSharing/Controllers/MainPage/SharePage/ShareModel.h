//
//  ShareModel.h
//  BaskSharing
//
//  Created by Yang on 9/18/16.
//  Copyright © 2016 Jack_yy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareModel : NSObject
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
+ (instancetype)shareModelWithDictionary:(NSDictionary *)dicData;


@end
