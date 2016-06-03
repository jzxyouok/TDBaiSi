//
//  TDEssenceViewController.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/25.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDEssenceViewController.h"
#import "TDTitleButton.h"
#import "TDAllViewController.h"
#import "TDPictureViewController.h"
#import "TDVideoViewController.h"
#import "TDVoiceViewController.h"
#import "TDWordViewController.h"

@interface TDEssenceViewController () <UIScrollViewDelegate>

//标题容器view
@property (nonatomic, weak) UIView *titlesView;
//下划线view
@property (nonatomic, weak) UIView *indictorView;
//记录按钮点击
@property (nonatomic, weak) TDTitleButton *selectButton;
//容器显示view
@property (nonatomic, weak) UIScrollView *scrollView;
//记录子view
@property (nonatomic, weak) UIScrollView *scrollViewChild;
@end

@implementation TDEssenceViewController

#pragma mark -------------------
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = TDRandomColor;
    
    // 设置导航条内容
    [self setUpNavigationBar];
    
    // 初始化子控制器
    [self setUpAllChildVc];
    // 设置容器scrollView
    [self setUpScrollView];
    // 设置标题栏
    [self setUpTitlesView];
    
    // 初始显示第一个界面
    [self addChildVcViewIntoScrollView:0];
}

/*
 UITabBarItem:决定tabBar上按钮的内容
 UINavigationItem:决定导航条上内容,左边,右边,中间有内容
 UIBarButtonItem:决定导航条上按钮具体内容
 */
#pragma mark -------------------
#pragma mark 搭建界面
/** 设置导航条 */
- (void)setUpNavigationBar
{
    //左边
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右边
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //中间
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

#pragma mark - 内容界面
/**
 *  添加子控制器
 */
- (void)setUpAllChildVc
{
    [self addChildViewController:[[TDAllViewController alloc] init]];
    [self addChildViewController:[[TDPictureViewController alloc] init]];
    [self addChildViewController:[[TDVideoViewController alloc] init]];
    [self addChildViewController:[[TDVoiceViewController alloc] init]];
    [self addChildViewController:[[TDWordViewController alloc] init]];
}

/**
 *  在scrollView显示子控制器view
 */
- (void)setUpScrollView
{
    //0.不要去自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSInteger count = self.childViewControllers.count;
    //1.创建ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor greenColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //2.其他设置
    scrollView.contentSize = CGSizeMake(scrollView.td_width * count, 0);
    // 点击状态栏时,这个scrollView不需要滚动到顶部
    scrollView.scrollsToTop = NO;
    scrollView.pagingEnabled = YES;
//    scrollView.scrollEnabled = NO;
}

#pragma mark - 标题view
/**
 *  标题view
 */
- (void)setUpTitlesView
{
    //1.创建标题容器view
    UIView *titlesView = [[UIView alloc] init];
    self.titlesView = titlesView;
    titlesView.frame = CGRectMake(0, NavBarH, self.view.td_width, TitlesViewH);
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [self.view addSubview:titlesView];
    
    //2.添加标题按钮
    [self setUpTitleButtons];
    
    //3.添加下划线
    [self setUpTitleIndictorView];
    
}

/**
 *  标题按钮
 */
- (void)setUpTitleButtons
{
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    
    NSInteger count = titles.count;
    CGFloat titleButtonW = self.titlesView.td_width / count;
    CGFloat titleButtonH = self.titlesView.td_height;
    
    for (int i = 0; i < count; i++) {
        TDTitleButton *titleButton = [[TDTitleButton alloc] init];
        titleButton.tag = i;
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        [self.titlesView addSubview:titleButton];
    }
}

/**
 *  下划线
 */
- (void)setUpTitleIndictorView
{
    //1.取出标题按钮
    TDTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    //2.创建下划线
    UIView *indictorView = [[UIView alloc] init];
    CGFloat indictorViewH = 2;
    CGFloat indictorViewY = self.titlesView.td_height - indictorViewH;
    indictorView.frame = CGRectMake(0, indictorViewY, 0, indictorViewH);
    indictorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:indictorView];
    self.indictorView = indictorView;
    
    //3.跟随按钮下划线确定位置
    [firstTitleButton.titleLabel sizeToFit];
    indictorView.td_width = firstTitleButton.titleLabel.td_width;
    indictorView.td_centerX = firstTitleButton.td_centerX;
    
    //4.初始点击的按钮
    firstTitleButton.selected = YES;
    self.selectButton = firstTitleButton;
    
    
}

#pragma mark -------------------
#pragma mark 监听点击
// 点击标题按钮
- (void)titleButtonClick:(TDTitleButton *)titleButton
{
    //1.修改按钮状态
    self.selectButton.selected = NO;
    titleButton.selected = YES;
    self.selectButton = titleButton;
    
    NSInteger index = titleButton.tag;
    //2.下划线View的动画移动
    [UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:10 options:kNilOptions animations:^{
        self.indictorView.td_width = titleButton.titleLabel.td_width;
        self.indictorView.td_centerX = titleButton.td_centerX;
    } completion:^(BOOL finished) {
        //3.界面的移动
        self.scrollView.contentOffset = CGPointMake(index * self.scrollView.td_width, 0);
//        CGPoint offset = self.scrollView.contentOffset;
//        offset.x = titleButton.tag * self.scrollView.td_width;
//        self.scrollView.contentOffset = offset;
        //4.添加显示的view
        [self addChildVcViewIntoScrollView:index];
    }];
    
    //5.控制scrollView的scrollsToTop属性
    /*
//    for (int i = 0; i < self.childViewControllers.count; i++) {
//        UIViewController *childVc = self.childViewControllers[i];
//        // 如果控制器的view没有被创建,跳过
//        if (!childVc.isViewLoaded) continue;
//        // 如果控制器的view不是scrollView,就跳过
//        if (![childVc.view isKindOfClass:[UIScrollView class]]) continue;
//        // 如果控制器的view是scrollView
//        UIScrollView *scrollView = (UIScrollView *)childVc.view;
//        scrollView.scrollsToTop = (i == index);
//    } 
     */
    
}

// 游戏按钮
- (void)game
{
    NSLog(@"%s", __func__);
}


#pragma mark - UIScrollViewDelegate
/**
 *  scrollView滑动完毕的时候调用(速度减为0的时候调用)
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //滑动scrollView改变按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.td_width;
    TDTitleButton *titleButton = self.titlesView.subviews[index];
    [self titleButtonClick:titleButton];
}

#pragma mark -------------------
#pragma mark 其他
/**
 *  添加索引所代表的子控制器view到ScrollView中
 */
- (void)addChildVcViewIntoScrollView:(NSInteger)index
{
    UIViewController *childVc = self.childViewControllers[index];
    //判断加载过就不加载了
    if (childVc.isViewLoaded) return;
//    if (childVc.view.superview) return;
//    if (childVc.view.window) return;
//    if ([self.scrollView.subviews containsObject:childVc.view]) return;
    
    childVc.view.frame = CGRectMake(self.scrollView.td_width * index, 0, self.scrollView.td_width, self.scrollView.td_height);
//        childVcView.frame = CGRectMake(i * scrollView.xmg_width, 99, scrollView.xmg_width, scrollView.xmg_height - 99 - 49); //错误
    
    //5.控制scrollView的scrollsToTop属性
    self.scrollViewChild.scrollsToTop = !self.scrollViewChild.scrollsToTop;
    // 如果控制器的view是scrollView
    UIScrollView *scrollView = (UIScrollView *)childVc.view;
    self.scrollViewChild = scrollView;
    
    [self.scrollView addSubview:childVc.view];

}


@end
