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

@interface TDAllViewController ()

//所有的帖子数据
@property (nonatomic, strong) NSMutableArray *topics;
//用来加载下一页数据的参数
@property (nonatomic, copy) NSString *maxtime;

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
    
    // 最新的帖子数据
    [self loadNewTopics];
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
        
    } failure:^(NSError *error) {
        
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
        self.footerRefreshing = NO;
        self.footer.text = @"上拉加载更多数据";
        self.footer.backgroundColor = [UIColor redColor];
        
    } failure:^(NSError *error) {
        // 结束刷新(恢复刷新控件的状态)
        self.footerRefreshing = NO;
        self.footer.text = @"上拉加载更多数据";
        self.footer.backgroundColor = [UIColor redColor];
        
    }];
    
}

#pragma mark -------------------
#pragma mark 搭建界面
/**
 *  添加刷新控件
 */
- (void)setUpRefresh
{
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 发送请求给服务器, 加载更多的数据
//    [self loadMoreTopics];
    
    // 如果正在上拉刷新(加载更多数据), 直接返回
    if (self.isFooterRefreshing) return;
    
    //根据偏移量进行刷新
    CGFloat offsetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.td_height;
    
    //判断上拉刷新
    if (self.tableView.contentOffset.y >= offsetY) {
        // 进入刷新状态
        self.footerRefreshing = YES;
        self.footer.text = @"正在加载更多数据...";
        self.footer.backgroundColor = [UIColor blueColor];
        
        // 发送请求给服务器, 加载更多的数据
        [self loadMoreTopics];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        NSLog(@"%ld", self.topics.count);
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
