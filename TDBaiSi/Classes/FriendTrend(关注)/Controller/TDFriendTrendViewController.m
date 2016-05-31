//
//  TDFriendTrendViewController.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/25.
//  Copyright © 2016年 Frank. All rights reserved.
// cmd + 回车 label换行

#import "TDFriendTrendViewController.h"
#import "TDLoginRegisterViewController.h"
#import "TDSubTagViewController.h"
#import "TDInviteView.h"

@interface TDFriendTrendViewController ()

//指示器view
@property (nonatomic, weak) UIView *indictorView;
//存放标题文字
@property (nonatomic, strong) NSArray *titleData;
//记录显示Vc
@property (nonatomic, weak) UIViewController *showingVc;
//容器显示view
@property (nonatomic, strong) UIView *containView;
@end

@implementation TDFriendTrendViewController

#pragma mark -------------------
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TDRandomColor;

    // 添加子控制器
    [self setUpChildVc];
    
    // 设置导航条内容
    [self setUpNavigationBar];
}

#pragma mark -------------------
#pragma mark 监听方法
// 朋友推荐
- (void)friendsRecomment {
    
}

#pragma mark -------------------
#pragma mark 搭建界面
/** 添加子控制器 */
- (void)setUpChildVc {
    
    TDSubTagViewController *subTagVc = [[TDSubTagViewController alloc] init];
    [self addChildViewController:subTagVc];
    [self.view addSubview:subTagVc.view];
//    [self.containView addSubview:subTagVc.view];
}

/** 设置导航条 */
- (void)setUpNavigationBar {
    
    // 左边
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // 中间
    self.navigationItem.titleView = [self setUpTitileView];

}

/** 标题view */
- (UIView *)setUpTitileView {
    
    // 1.容器view
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW * 0.4, 44)];
    
    // 2.指示器view
    UIView *indictorView = [[UIView alloc] init];
    self.indictorView = indictorView;
    indictorView.td_height = 2;
    indictorView.td_y = titleView.td_height - indictorView.td_height;
    indictorView.backgroundColor = [UIColor redColor];
    [titleView addSubview:indictorView];
    
    // 3.按钮
    NSInteger count = self.titleData.count;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = titleView.td_width / count;
    CGFloat btnH = indictorView.td_y;
    for (int i = 0; i < count; i++) {
        btnX = btnW * i;
        
        //设置按钮
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setTitle:self.titleData[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:btn];
        
        //按钮的标识
        btn.tag = i;
        
        //4.根据按钮文字最终确定指示器的位置
        if (i == 0) {
            btn.selected = YES;
            [btn.titleLabel sizeToFit];
            indictorView.td_width = btn.titleLabel.td_width;
            //宽度确定中心值
            indictorView.td_centerX = btn.td_centerX;
        }
    }
    
    return titleView;
}

// 监听标题按钮点击
- (void)btnClick:(UIButton *)btn {
    
//    [self.containView removeFromSuperview];
//    [self.showingVc.view removeFromSuperview];
    //移除前面显示的view
    for (UIView *subView in self.view.subviews) {
        [subView removeFromSuperview];
    }
    
    //指示器View的动画
    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:kNilOptions animations:^{
        self.indictorView.td_centerX = btn.td_centerX;
        self.indictorView.td_width = btn.titleLabel.td_width;
    } completion:nil];
    
    //点击切换界面
    if (btn.tag == 0) {
        self.showingVc = self.childViewControllers[0];
        [self.view addSubview:self.showingVc.view];
//        [self.containView addSubview:self.showingVc.view];
    }
    
    if (btn.tag == 1) {
        TDInviteView *inviteView = [TDInviteView inviteViewView];
        [self.view addSubview:inviteView];
//        [self.containView addSubview:inviteView];
    }
}

#pragma mark -------------------
#pragma mark 懒加载
//- (UIView *)containView {
//    if (!_containView) {
//        UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(0, NavBarH, ScreenW, ScreenH)];
//        containView.backgroundColor  = [UIColor redColor];
//        [self.view addSubview:containView];
//        _containView = containView;
//    }
//
//    return _containView;
//}

- (NSArray *)titleData {
    if (!_titleData) {
        _titleData = @[@"订阅", @"关注"];
    }
    return _titleData;
}

@end
