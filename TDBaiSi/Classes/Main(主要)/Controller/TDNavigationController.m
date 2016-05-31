//
//  TDNavigationController.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/26.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDNavigationController.h"

@interface TDNavigationController () <UIGestureRecognizerDelegate>

@end
@implementation TDNavigationController

#pragma mark -------------------
#pragma mark 生命周期
+ (void)load {
    //只要遵守了UIAppearance,就可以调用appearance获取全局外观（bug:可能会修改掉系统其他app的导航条）
//    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //获取当前类的导航条
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    //设置导航条标题的字体
    NSMutableDictionary *attrFont = [NSMutableDictionary dictionary];
    attrFont[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    navBar.titleTextAttributes = attrFont;
    
    //设置导航条的背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

/*2016-05-27 00:20:44.179 TDBaiSi[7786:242072] <UIScreenEdgePanGestureRecognizer: 0x7fe650cd6bf0; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fe650d3b050>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fe650cd8640>)>>  
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //恢复侧滑功能
    //清空手势代理,恢复滑动返回功能（bug:假死状态——程序一直在跑,但是界面死了）
//    self.interactivePopGestureRecognizer.delegate = nil; //bug
//    self.interactivePopGestureRecognizer.delegate = self;
    
    //实现全屏滑动
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    //控制器手势什么时候触发
    pan.delegate = self;
    //禁止系统原本的手势
    self.interactivePopGestureRecognizer.enabled = NO;//??
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 在根控制器下不要触发手势
    return self.childViewControllers.count > 1;
}

#pragma mark -------------------
#pragma mark 重写push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //设置返回按钮（排除根控制器）
    if (self.childViewControllers.count > 0) {
        //隐藏tabbar（push之前设置）
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *backItem = [UIBarButtonItem itemWithTitle:@"返回" image:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    
    // 这个方法才是真正执行跳转
    [super pushViewController:viewController animated:animated];
    
//    NSLog(@"%@", self.interactivePopGestureRecognizer);
}

// 返回按钮
- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
