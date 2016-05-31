//
//  TDNewViewController.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/25.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDNewViewController.h"
#import "TDSubTagViewController.h"

@implementation TDNewViewController

#pragma mark -------------------
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TDRandomColor;
    
    // 设置导航条内容
    [self setUpNavigationBar];
}

#pragma mark -------------------
#pragma mark 监听方法
// 订阅标签
- (void)subTag {
    //创建订阅控制器
    TDSubTagViewController *subTagVc = [[TDSubTagViewController alloc] init];
    //跳转
    [self.navigationController pushViewController:subTagVc animated:YES];
}

#pragma mark -------------------
#pragma mark 搭建界面
// 设置导航条
- (void)setUpNavigationBar {
    
    //左边
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(subTag)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //中间
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}


@end
