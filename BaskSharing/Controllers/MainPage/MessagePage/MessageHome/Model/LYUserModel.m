//
//  QYUserModel.m
//  青云微博
//
//  Created by qingyun on 16/7/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "LYUserModel.h"

@implementation LYUserModel

+ (instancetype)userModelWithDictionary:(NSDictionary *)dicData {
    // 判断传进来的字典是否合, 如果不合法, 直接返回空
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    LYUserModel *user = [self new];
    
    /** idstr	string	字符串型的用户UserId */
    user.strIdstr = dicData[@"idstr"];
    
    /** screen_name	string	用户昵称, NickName */
    user.strScreenName = dicData[@"screen_name"];
    
    /** name	string	友好显示名称 */
    user.strName = dicData[@"name"];
    
    /** description	string	用户个人描述 */
    user.strUserDescription = dicData[@"description"];
    
    /** profile_image_url	string	用户头像地址（中图），50×50像素 */
    user.strProfileImageUrl = dicData[@"profile_image_url"];
    
    /** followers_count	int	粉丝数 */
    user.followersCount = [dicData[@"followers_count"] integerValue];
    
    /** friends_count	int	关注数 */
    user.friendsCount = [dicData[@"friends_count"] integerValue];
    
    /** statuses_count	int	微博数 */
    user.statusesCount = [dicData[@"statuses_count"] integerValue];
    
    /** favourites_count	int	收藏数 */
    user.favourites_count = [dicData[@"favourites_count"] integerValue];
    
    /** avatar_large	string	用户头像地址（大图），180×180像素 */
    user.strAvatarLarge = dicData[@"avatar_large"];
    
    /** avatar_hd	string	用户头像地址（高清），高清头像原图 */
    user.strAvatarHd = dicData[@"avatar_hd"];
    
    // 用下面这个方法的前提: key值必须和属性的名字一模一样
    //[user setValuesForKeysWithDictionary:<#(nonnull NSDictionary<NSString *,id> *)#>];
    // 利用循环解决
    //[user setValue:<#(nullable id)#> forKey:<#(nonnull NSString *)#>];
    
    return user;
}

@end
