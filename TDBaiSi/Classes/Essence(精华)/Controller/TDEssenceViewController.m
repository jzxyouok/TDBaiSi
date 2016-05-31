//
//  TDEssenceViewController.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/25.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDEssenceViewController.h"

@implementation TDEssenceViewController

#pragma mark -------------------
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TDRandomColor;
    
    // 设置导航条内容
    [self setUpNavigationBar];
}

/*
 UITabBarItem:决定tabBar上按钮的内容
 UINavigationItem:决定导航条上内容,左边,右边,中间有内容
 UIBarButtonItem:决定导航条上按钮具体内容
 */
#pragma mark -------------------
#pragma mark 搭建界面
// 设置导航条
- (void)setUpNavigationBar {
    
    //左边
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右边
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //中间
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

#pragma mark 监听点击
// 游戏按钮
- (void)game {
    NSLog(@"%s", __func__);
}

@end
