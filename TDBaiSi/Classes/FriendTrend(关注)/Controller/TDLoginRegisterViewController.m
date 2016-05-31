//
//  TDLoginRegisterViewController.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/29.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDLoginRegisterViewController.h"
#import "TDLoginRegisterView.h"
#import "TDFastLoginView.h"

@interface TDLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
//middleView的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;
@end

@implementation TDLoginRegisterViewController

/*
 1.如果一个控件从xib加载,必须固定尺寸
 2.在viewDidLoad设置子控件位置,在viewDidLayoutSubviews布局子控件
 */
#pragma mark -------------------
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //默认一个view从xib加载,尺寸跟xib一样

    //添加登录view
    TDLoginRegisterView *loginView = [TDLoginRegisterView loginView];
    [self.middleView addSubview:loginView];
    
    //添加注册view
    TDLoginRegisterView *registerView = [TDLoginRegisterView registerView];
    [self.middleView addSubview:registerView];
    
    //添加快速登录view
    TDFastLoginView *fastView = [TDFastLoginView fastLoginView];
    [self.bottomView addSubview:fastView];
}

#pragma mark - 布局子控件
// 执行约束,里面尺寸才是最准确.
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //设置登录
    TDLoginRegisterView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.td_width, self.middleView.td_height);

    //设置注册
    TDLoginRegisterView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake(ScreenW, 0, self.middleView.td_width, self.middleView.td_height);
    
    //设置快速登录
    TDFastLoginView *fastView = self.bottomView.subviews[0];
    fastView.frame = self.bottomView.bounds;
}

#pragma mark -------------------
#pragma mark 监听方法
// 点击关闭
- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 点击注册账号
- (IBAction)registerClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    //移动中间的view
    self.leadCons.constant = self.leadCons.constant==0? -ScreenW * 2 : 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
