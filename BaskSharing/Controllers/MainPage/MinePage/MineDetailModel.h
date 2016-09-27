//
//  MineDetailModel.h
//  BaskSharing
//
//  Created by Yang on 9/20/16.
//  Copyright © 2016 Jack_yy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineDetailModel : NSObject <NSCoding>
/**昵称*/
@property(nonatomic,strong) NSString *StrName;
/**性别*/
@property(nonatomic,strong) NSString *StrSex;
/**年龄*/
@property(nonatomic,strong) NSString *StrAge;
/**邮箱*/
@property(nonatomic,strong) NSString *StrEmail;

@end
