//
//  ShareModel.m
//  BaskSharing
//
//  Created by Yang on 9/18/16.
//  Copyright © 2016 Jack_yy. All rights reserved.
//

#import "ShareModel.h"
#import "Common.h"
#import "AVOSCloud/AVQuery.h"

@implementation ShareModel
+ (instancetype)shareModelWithDictionary:(NSDictionary *)dicData
{
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    ShareModel *model = [self new];
    
    /**服务器获取的用户名*/
        NSString *strName = dicData[@"name"];
        model.StrName = strName;
        model.data = dicData[@"userImage"];
        model.StrTitle = dicData[@"title"];
        model.StrContent = dicData[@"content"];
    
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        model.strTimeCreatedAt = [formatter stringFromDate:dicData[@"currentTimeDate"]];
        NSArray *arr = dicData[@"nameimage"];
        if (arr.count)
        {
            model.arrData = dicData[@"nameimage"];
        }
        else
        {
            model.arrData = nil;
        }
    return model;
}
@end
