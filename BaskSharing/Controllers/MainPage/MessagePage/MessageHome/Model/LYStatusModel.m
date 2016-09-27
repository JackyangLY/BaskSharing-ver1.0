//
//  QYStatusModel.m
//  青云微博
//
//  Created by qingyun on 16/7/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "LYStatusModel.h"
#import "LYUserModel.h"
#import "Common.h"
#import "AVOSCloud/AVQuery.h"

//#import "NSString+QYString.h"

@implementation LYStatusModel

+ (instancetype)statusModelWithDictionary:(NSDictionary *)dicData {
    //NSAssert(dicData != nil, @"阿萨德GV是vasev8是v");
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    LYStatusModel *status = [self new];
    
    
    /*content = "\U8bf4\U70b9\U4ec0\U4e48\U5427nihao";
     name = 18037458635;
     title = "\U8bf4\U8bf4";
     }, estimatedData:{
     }, relationData:{
     }>*/
    /**服务器获取的用户名*/
    NSString *strName = dicData[@"name"];
    AVUser *currentUser = [AVUser currentUser];
    //用户名
//    NSString *user = currentUser.username;
    //    NSString *Name = currentUser[@"name"];
//    if([strName isEqualToString:user])
//    {
    status.StrTitle = dicData[@"title"];
    status.StrName = strName;
    status.StrContent = dicData[@"content"];
    status.data = currentUser[@"userImage"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    status.strTimeCreatedAt = [formatter stringFromDate:dicData[@"currentTimeDate"]];
    NSArray *arr = dicData[@"nameimage"];
    if (arr.count)
    {
        status.arrData = dicData[@"nameimage"];
        
    }
    else
    {
        status.arrData = nil;
    }
//    }
//    else
//    {
//        NSLog(@"%s 有误",__func__);
//        NSString *Name = currentUser[@"username"];
//        status.StrName = Name;
//    }

    return status;
}


@end
