//
//  TDTabBarController.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/25.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDTabBarController.h"
#import "TDEssenceViewController.h"
#import "TDNewViewController.h"
#import "TDFriendTrendViewController.h"
#import "TDMineViewController.h"
#import "TDPublishViewController.h"
#import "TDNavigationController.h"
#import "TDTabBar.h"

#import "UIImage+TDImage.h"

@implementation TDTabBarController

#pragma mark -------------------
#pragma mark 生命周期
+ (void)load {
    // 获取全局的tabBarItem
//    UITabBarItem *item = [UITabBarItem appearance];
    
    // 获取当前类的tabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    //修改文本的颜色
    NSMutableDictionary *attrColor = [NSMutableDictionary dictionary];
    attrColor[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrColor forState:UIControlStateSelected];
    
    //修改字体的大小（通过normal状态设置字体大小）
    NSMutableDictionary *attrFont = [NSMutableDictionary dictionary];
    attrFont[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrFont forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //替换系统的Tabbar
    [self setUpTabBar];
    
    //设置子控制器
    [self setUpAllChildVc];
    
  
    //添加子控制器
//    [self setUpAllChildViewController];
    //设置标题按钮
//    [self setUpAllTitleButton];
    
    //修改文本的颜色
//    self.tabBar.tintColor = [UIColor redColor];
//    self.tabBar.selectedImageTintColor = [UIColor redColor];
}

#pragma mark -------------------
#pragma mark 搭建界面
// 自定义Tabbar
- (void)setUpTabBar {
    
    TDTabBar *tabbar = [[TDTabBar alloc] init];
    //替换系统的Tabbar——使用KVC修改系统的readonly属性
    [self setValue:tabbar forKey:@"tabBar"];
    /*
     1.查找有没有set方法
     2.查找有没有tabBar
     3.查找有没有_tabBar
     */
}

#pragma mark 1
// 设置所有的子控制器
- (void)setUpAllChildVc {
    
    //精华
    TDEssenceViewController *essenceVc = [[TDEssenceViewController alloc] init];
    [self packVc:essenceVc title:@"精华" image:@"tabBar_essence_icon" selImage:@"tabBar_essence_click_icon"];
    
    //新帖
    TDNewViewController *newVc = [[TDNewViewController alloc] init];
    [self packVc:newVc title:@"新帖" image:@"tabBar_new_icon" selImage:@"tabBar_new_click_icon"];
    
    //关注
    TDFriendTrendViewController *friendTrendVc = [[TDFriendTrendViewController alloc] init];
    [self packVc:friendTrendVc title:@"关注" image:@"tabBar_friendTrends_icon" selImage:@"tabBar_friendTrends_click_icon"];
    
    //我
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TDMineViewController" bundle:nil]; //容易遗忘
    TDMineViewController *MineVc = [storyboard instantiateInitialViewController];
    [self packVc:MineVc title:@"我" image:@"tabBar_me_icon" selImage:@"tabBar_me_click_icon"];
    
}

// 包装子控制器
- (void)packVc:(UIViewController *)Vc title:(NSString *)title image:(NSString *)imageName selImage:(NSString *)selImageName {
    
    TDNavigationController *nav = [[TDNavigationController alloc] initWithRootViewController:Vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageName];
    nav.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:selImageName];
    
    [self addChildViewController:nav];
}

#pragma mark 2
// 创建所有的子控制器
- (void)setUpAllChildViewController {
    
    //精华
    TDEssenceViewController *essenceVc = [[TDEssenceViewController alloc] init];
    TDNavigationController *nav = [[TDNavigationController alloc] initWithRootViewController:essenceVc];
    [self addChildViewController:nav];
    
    //新帖
    TDNewViewController *newVc = [[TDNewViewController alloc] init];
    TDNavigationController *nav1 = [[TDNavigationController alloc] initWithRootViewController:newVc];
    [self addChildViewController:nav1];
    
    //关注
    TDFriendTrendViewController *friendTrendVc = [[TDFriendTrendViewController alloc] init];
    TDNavigationController *nav2 = [[TDNavigationController alloc] initWithRootViewController:friendTrendVc];
    [self addChildViewController:nav2];
    
    //我
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TDMineViewController" bundle:nil];
    TDMineViewController *MineVc = [storyboard instantiateInitialViewController];
    TDNavigationController *nav3 = [[TDNavigationController alloc] initWithRootViewController:MineVc];
    [self addChildViewController:nav3];
    
}

// 设置所有的标题按钮
- (void)setUpAllTitleButton {
    
    // 0:精华
    UINavigationController *nav = self.childViewControllers[0];
    // 标题
    nav.tabBarItem.title = @"精华";
    // 图片
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    // 选中（返回一个不渲染的图片）
    nav.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_essence_click_icon"];
    
    // 1:新帖
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_new_click_icon"];
    
    // 2:关注
    UINavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"关注";
    nav2.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav2.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_friendTrends_click_icon"];
    
    // 3:我
    UINavigationController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"我";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageNameWithOriginal:@"tabBar_me_click_icon"];
}

@end
