//
//  AppDelegate.m
//  BaskSharing
//
//  Created by 洋洋 on 16/8/17.
//  Copyright © 2016年 Jack_yy. All rights reserved.
//
#import <AVOSCloud/AVOSCloud.h>
#import "Common.h"
#import "AppDelegate.h"
#import "LoginPageVC.h"
#import "MainTabBarVC.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialSnsService.h"
#import "Common.h"


@interface AppDelegate ()

@end

@implementation AppDelegate
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [AVOSCloudSNS handleOpenURL:url];
}

// When Build with IOS 9 SDK
// For application on system below ios 9
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [AVOSCloudSNS handleOpenURL:url];
}
// For application on system equals or larger ios 9
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [AVOSCloudSNS handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UMengAppKey];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WeixinAppID appSecret:WeixinAppSecret url:@""];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:QQAPPID appKey:QQAPPKEY url:@""];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:XinlangAPPKey
                                              secret:XinlangAppSecret
                                         RedirectURL:@"https://www.weibo.com"];
    //初始化 SDK
    // Override point for customization after application launch.
    // 如果使用美国站点，请加上下面这行代码：
    // [AVOSCloud setServiceRegion:AVServiceRegionUS];
    /**创建window*/
    _window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
      _window.backgroundColor = [UIColor whiteColor];
    [AVOSCloud setApplicationId:@"vKowORngzhqdK1IEf8LUOPia-gzGzoHsz" clientKey:@"0Eiq4pMyN2ioXEOQGEOAwlOY"];
    //跟踪统计应用的打开情况
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    //微信
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSWeiXin withAppKey:WeixinAppID andAppSecret:WeixinAppSecret andRedirectURI:@""];
    //QQ
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSQQ withAppKey:QQAPPID andAppSecret:QQAPPKEY andRedirectURI:@""];
    //新浪微博
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSSinaWeibo withAppKey:XinlangAPPKey andAppSecret:XinlangAppSecret andRedirectURI:@"https://www.weibo.com"];
    
    //NSUserDefaults *userDefault =[NSUserDefaults standardUserDefaults];
    //NSString *name = [userDefault objectForKey:@"username"];
   // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
  //  LoginPageVC *loginVC = [LoginPageVC new];
//    if (name == nil)
//    {
//        NSLog(@"%@",name);
//        UINavigationController *NaviVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
//    self.window.rootViewController = NaviVC;
//    }
//    else
//    {
//        /**打印此方法*/
//        NSLog(@"%s\n跳到首页",__func__);
//        MainTabBarVC *mainvc = [MainTabBarVC new];
//        //UINavigationController *NaviVC = [[UINavigationController alloc]initWithRootViewController:mainvc];
//        self.window.rootViewController = mainvc;
//    }
    /**
     * 添加延迟线程
     */
//           NSLog(@"%s\n跳到首页",__func__);
        /**设置根控制器*/
        MainTabBarVC *mainvc = [MainTabBarVC new];
        // LYNavigationViewController *NaviVC = [[LYNavigationViewController alloc]initWithRootViewController:mainvc];
        self.window.rootViewController = mainvc;
        /**显示在屏幕上*/
        [_window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}


@end
