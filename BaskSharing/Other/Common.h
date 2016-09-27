//
//  Common.h
//  BaskSharing
//
//  Created by 洋洋 on 16/8/17.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//

#ifndef Common_h
#define Common_h
/**随机色*/
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
#define LYScreenbounds [UIScreen mainScreen].bounds

#define LYSCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define LYSCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define TextFeildWidth LYSCREEN_WIDTH/2
//QQ
#define QQAPPID @"1105642172"
#define  QQAPPKEY @"np9sfyAHaNC2F8dl"
//Weixin
#define WeixinAppID @"wx4f5469b9ab57f40d"
#define WeixinAppSecret @"cd5e9a6708a96acc66fcdb13f2470153"
//新浪
#define XinlangAppID @"1154334823"
#define XinlangAPPKey @"3736490958"
#define XinlangAppSecret @"32bebc11a42b2dbd411eb0c2f009ccab"
//友盟
#define UMengAppKey @"57b424f3e0f55a657400295c"


#import "LYRefreshHeader.h"
#import "NSString+Predicate.h"
/**打印此方法*/
#define   LYNSlog NSLog(@"%s",__func__);
#import "AVOSCloudSNS.h"
#import <LeanCloudSocial/AVUser+SNS.h>
#import <Masonry/Masonry.h>
#import "UIBarButtonItem+BarButtonItemManager.h"
#import "LYNavigationViewController.h"
#import "UITextField+LYExtxtension.h"
#import "UIView+LYExtension.h"
#import <UMSocial.h>




#endif /* Common_h */
