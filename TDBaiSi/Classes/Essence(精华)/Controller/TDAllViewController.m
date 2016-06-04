//
//  TDAllViewController.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/6/1.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDAllViewController.h"
#import "TDTopicModel.h"
#import "TDHttpTool.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface TDAllViewController ()

//所有的帖子数据
@property (nonatomic, strong) NSMutableArray *topics;
//用来加载下一页数据的参数
@property (nonatomic, copy) NSString *maxtime;

/** 用来下拉加载新数据的header */
@property (nonatomic, weak) UILabel *header;
/** 是否正在加载新数据... */
@property (nonatomic, assign, getter=isHeaderRefreshing) BOOL headerRefreshing;

/** 用来上拉加载更多数据的footer */
@property (nonatomic, weak) UILabel *footer;
/** 是否正在加载更多数据... */
@property (nonatomic, assign, getter=isFooterRefreshing) BOOL footerRefreshing;
@end

@implementation TDAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    // 0.调整tableView的位置
    self.tableView.contentInset = UIEdgeInsetsMake(NavBarH + TitlesViewH, 0, TabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset; //滚动条
    
    // 添加刷新控件
    [self setUpRefresh];
    
    // 监听通知
    [self setupNote];
    
}

- (void)dealloc
{   //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -------------------
#pragma mark 监听方法
- (void)setupNote
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:TDTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:TDTitleButtonDidRepeatClickNotification object:nil];
}

/** titleButton被重复点击 */
- (void)titleButtonDidRepeatClick
{
    [self tabBarButtonDidRepeatClick];
}

/**
 *  tabBarButton被重复点击
 */
- (void)tabBarButtonDidRepeatClick
{
    //if (当前控制器的界面不在屏幕正中间) return;
    if (self.tableView.scrollsToTop == NO) return;
    
    //if (当前控制器的界面不在窗口上) return;
    if (self.tableView.window == nil) return;
    
    // 进入下拉刷新
    [self headerBeginRefreshing];
}

#pragma mark -------------------
#pragma mark 加载数据
/**
 *  加载最新的数据
 */
- (void)loadNewTopics
{
    //请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"31";
    
    //发送请求
    [TDHttpTool get:TDRequestURL parameters:parameters success:^(id responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组转模型数据
        self.topics = [TDTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(恢复刷新控件的状态)
        self.headerRefreshing = NO;
        
        // 结束刷新(恢复刷新控件的状态)
        [self headerEndRefreshing];
        
    } failure:^(NSError *error) {
        // 结束刷新(恢复刷新控件的状态)
        [self headerEndRefreshing];
        
        // 如果是因为取消任务来到failure这个block, 就直接返回, 不需要提醒错误信息
        if (error.code == NSURLErrorCancelled) return;
        
        // 请求失败的提醒
        [SVProgressHUD showErrorWithStatus:@"网络繁忙,请稍后再试!"];
    }];
    
}

/**
 *  加载更多的数据
 */
- (void)loadMoreTopics
{
    //请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"31";
    parameters[@"maxtime"] = self.maxtime;
    
    //发送请求
    [TDHttpTool get:TDRequestURL parameters:parameters success:^(id responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组转模型数据
        NSArray *moreTopics = [TDTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(恢复刷新控件的状态)
        [self footerEndRefreshing];
        
    } failure:^(NSError *error) {
        // 结束刷新(恢复刷新控件的状态)
        [self footerEndRefreshing];
        
        // 如果是因为取消任务来到failure这个block, 就直接返回, 不需要提醒错误信息
        if (error.code == NSURLErrorCancelled) return;
        
        // 请求失败的提醒
        [SVProgressHUD showErrorWithStatus:@"网络繁忙,请稍后再试!"];
    }];
    
}

#pragma mark -------------------
#pragma mark 搭建界面
/**
 *  添加刷新控件
 */
- (void)setUpRefresh
{
    //下拉刷新控件
    UILabel *header = [[UILabel alloc] init];
    header.textAlignment = NSTextAlignmentCenter;
    header.textColor = [UIColor whiteColor];
    header.text = @"下拉可以刷新";
    header.backgroundColor = [UIColor redColor];
    header.td_height = 50;
    header.td_y = - header.td_height;
    header.td_width = self.tableView.td_width;
    [self.tableView addSubview:header];
    self.header = header;
    
    // 初始化就要加载最新数据
    [self headerBeginRefreshing];
    
    //广告
    UILabel *ad = [[UILabel alloc] init];
    ad.textAlignment = NSTextAlignmentCenter;
    ad.textColor = [UIColor whiteColor];
    ad.text = @"广告广告广告广告广告";
    ad.backgroundColor = [UIColor grayColor];
    ad.td_height = 35;
    self.tableView.tableHeaderView = ad;
    
    //上拉刷新控件
    UILabel *footer = [[UILabel alloc] init];
    footer.backgroundColor = [UIColor redColor];
    footer.textColor = [UIColor whiteColor];
    footer.textAlignment = NSTextAlignmentCenter;
    footer.text = @"上拉加载更多数据";
    footer.td_height = 35;
    self.tableView.tableFooterView = footer;
    self.footer = footer;
}

#pragma mark - 下拉控件
/**
 *  处理header
 */
- (void)dealHeader {
    
    // header还没有被创建, 直接返回
    if (self.header == nil) return;
    
    // 如果正在刷新, 直接返回
    if (self.isHeaderRefreshing) return;
    
    // 计算偏移量
    CGFloat offsetY = - (self.tableView.contentInset.top + self.header.td_height);
    
    if (self.tableView.contentOffset.y <= offsetY) { //header完全出现的时候
        self.header.text = @"松开立即刷新";
        self.header.backgroundColor = [UIColor purpleColor];
    } else {
        self.header.text = @"下拉可以刷新";
        self.header.backgroundColor = [UIColor redColor];
    }
}

/**
 *  header进入刷新状态
 */
- (void)headerBeginRefreshing
{
    if (self.isHeaderRefreshing) return;
    if (self.isFooterRefreshing) return;
    
    self.headerRefreshing = YES;
    self.header.text = @"正在刷新数据...";
    self.header.backgroundColor = [UIColor blueColor];
    
    // 增大内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.header.td_height;
        self.tableView.contentInset = inset;
        
        //重新计算tableView的偏移量
        CGPoint offset = self.tableView.contentOffset;
        offset.y = - inset.top;
        self.tableView.contentOffset = offset;
    }];
    
    // 发送请求给服务器
    [self loadNewTopics];
}

/**
 *  header结束刷新状态
 */
- (void)headerEndRefreshing
{
    self.headerRefreshing = NO;
    
    // 减小内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.header.td_height;
        self.tableView.contentInset = inset;
    }];
}

#pragma mark - 上拉控件
/**
 *  处理footer
 */
- (void)dealFooter {
    
    // 如果还没有数据, 不需要处理footer
    if (self.topics.count == 0) return;
    
    // 如果正在上拉刷新(加载更多数据), 直接返回
    if (self.isFooterRefreshing) return;
    
    //根据偏移量进行刷新
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.td_height;
    
    //判断上拉刷新
    if (self.tableView.contentOffset.y >= offsetY) {
        // 进入刷新状态
        [self footerBeginRefreshing];
    }
}

/**
 *  footer进入刷新状态
 */
- (void)footerBeginRefreshing
{
//    if (self.isHeaderRefreshing) return;
    if (self.isFooterRefreshing) return;
    
    self.footerRefreshing = YES;
    self.footer.text = @"正在加载更多数据...";
    self.footer.backgroundColor = [UIColor blueColor];
    
    // 发送请求给服务器, 加载更多的数据
    [self loadMoreTopics];
}

/**
 *  footer结束刷新状态
 */
- (void)footerEndRefreshing
{
    self.footerRefreshing = NO;
    self.footer.text = @"上拉加载更多数据";
    self.footer.backgroundColor = [UIColor redColor];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 处理Header
    [self dealHeader];
    
    // 处理footer
    [self dealFooter];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 如果正在刷新, 直接返回
    if (self.isHeaderRefreshing) return;
    
    // 当偏移量 <= offsetY时, 刷新header就完全出现
    CGFloat offsetY = - (self.tableView.contentInset.top + self.header.td_height);
    
    if (self.tableView.contentOffset.y <= offsetY) { // 刷新header完全出现了
        // 进入刷新状态
        [self headerBeginRefreshing];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //隐藏上拉刷新
    self.footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    // 显示数据
    TDTopicModel *topicModel = self.topics[indexPath.row];
    cell.textLabel.text = topicModel.name;
    cell.detailTextLabel.text = topicModel.text;
    
    return cell;
}

@end
