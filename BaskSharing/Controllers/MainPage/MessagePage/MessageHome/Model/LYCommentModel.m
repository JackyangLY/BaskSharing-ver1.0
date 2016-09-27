//
//  QYCommentModel.m
//  青云微博
//
//  Created by qingyun on 16/7/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "LYCommentModel.h"
#import "LYUserModel.h"
//#import "NSString+QYString.h"

@implementation LYCommentModel

+ (instancetype)commentModelWithDictionary:(NSDictionary *)dicData {
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    LYCommentModel *comment = [self new];
    
    comment.user = [LYUserModel userModelWithDictionary:dicData[@"user"]];
    comment.strCreateAt = dicData[@"created_at"];
    comment.strText = dicData[@"text"];
    
    return comment;
}

- (void)setStrCreateAt:(NSString *)strCreateAt {
    _strCreateAt = [strCreateAt copy];
    //_strTimeDes = [NSString descriptionWithString:_strCreateAt];
}

@end
