//
//  AppDelegate.m
//  NIMOnlyRTC
//
//  Created by Nick Deng on 2017/6/28.
//  Copyright © 2017年 Nick Deng. All rights reserved.
//

/*
 
 *************************** 注意！ *****************************
 
                   注意！注意！注意！注意！注意！
 
 该demo旨在最简化一对一音视频通话流程，便于其他开发者快速上手一对一音视频通话
 
 流程，不可在线上项目中直接使用！线上场景复杂需要考虑的因素较多，建议直接参考
 
 云信官网即时通讯IMdemo：netease.im/im-sdk-demo?solutionType=0#solution
 
 
 
 ***************************************************************
 
 */

#import "AppDelegate.h"
#import <NIMSDK/NIMSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //这里默认配置的是云信demo的AppKey，通过云信demo进行注册的账号可以直接在该demo下登录。
    //如果是切换为自己的appkey，需要自行实现服务端api调用创建云信ACCID
    NIMSDKOption *option = [NIMSDKOption optionWithAppKey:@"45c6af3c98409b18a84451215d0bdd6e"];
    
    //打印SDK版本
    NSLog(@"SDK VERSION:%@",[NIMSDK sharedSDK].sdkVersion);
    
    [[NIMSDK sharedSDK] registerWithOption:option];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
