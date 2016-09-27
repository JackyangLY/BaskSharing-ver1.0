//
//  MineDetailModel.m
//  BaskSharing
//
//  Created by Yang on 9/20/16.
//  Copyright © 2016 Jack_yy. All rights reserved.
//

#import "MineDetailModel.h"
#define StrName @"name"
#define StrAge  @"age"
#define StrSex @"sex"
#define StrEmail @"email"

@implementation MineDetailModel
#pragma  mark NSCoding
/**
 *  归档的操作 将内存中的实体对象转换成NSDate数据类型
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_StrName forKey:StrName];
    [aCoder encodeObject:_StrAge forKey:StrAge];
    [aCoder encodeObject:_StrSex forKey:StrSex];
    [aCoder encodeObject:_StrEmail forKey:StrEmail];
    
}
#pragma  mark NSCoding
/**
 *  归档的操作 将内存中的实体对象转换成NSDate数据类型
 */
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    _StrName = [aDecoder decodeObjectForKey:StrName];
    _StrAge = [aDecoder decodeObjectForKey:StrAge];
    _StrSex = [aDecoder decodeObjectForKey:StrSex];
    _StrEmail = [aDecoder decodeObjectForKey:StrEmail];
    return self;
    
}
@end
