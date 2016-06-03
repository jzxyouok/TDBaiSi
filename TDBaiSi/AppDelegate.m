//
//  AppDelegate.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/25.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "AppDelegate.h"
#import "TDADViewController.h"
#import "TDTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/**
 *  可以在这个AppDelegate方法中监听到状态栏的点击
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([touches.anyObject locationInView:nil].y > 20) return;
    
//    TDLog(@"点击了状态栏")
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.创建主窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.设置根控制器
    TDTabBarController *tabBarVc = [[TDTabBarController alloc] init];
    self.window.rootViewController = tabBarVc;
//    TDADViewController *adVc = [[TDADViewController alloc] init];
//    self.window.rootViewController = adVc;
    
    //3.显示主窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
