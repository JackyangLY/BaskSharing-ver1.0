//
//  QYCommentModel.h
//  青云微博
//
//  Created by qingyun on 16/7/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LYUserModel;

@interface LYCommentModel : NSObject

@property (nonatomic, strong) LYUserModel *user;

/** created_at: 创建时间 */
@property (nonatomic, copy) NSString *strCreateAt;
@property (nonatomic, copy, readonly) NSString *strTimeDes;

/** text: 评论文本 */
@property (nonatomic, copy) NSString *strText;

/** 评论模型的初始化方法 */
+ (instancetype)commentModelWithDictionary:(NSDictionary *)dicData;

@end
