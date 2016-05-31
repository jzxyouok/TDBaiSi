//
//  TDSubTagTableViewController.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/28.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDSubTagViewController.h"
#import "TDSubTagModel.h"
#import "TDSubTagCell.h"
#import "TDHttpTool.h"
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface TDSubTagViewController ()

//模型数组
@property (nonatomic,strong) NSArray *subtags;
@property (nonatomic, weak) NSURLSessionDataTask *dateTask;
@end

static NSString * const ID0 = @"header";
static NSString * const ID1 = @"subTag";
@implementation TDSubTagViewController

/* 让分割线全屏 -> 1.自定义分割线 2.利用系统属性(iOS6->iOS7 , iOS7 -> iOS8)不能支持iOS8 3.重写cell的setFrame1.取消系统的分割线 2.设置tableView背景色为分割线颜色
 */
#pragma mark -------------------
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TDSubTagCell" bundle:nil] forCellReuseIdentifier:ID1];
    
    // 显示界面
    [self setUpShowingView];
    
    // 加载数据
    [self loadSubTagData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //移除指示器
    [SVProgressHUD dismiss];
    //取消请求
    [self.dateTask cancel]; //万一网络速度不好
}

#pragma mark - 加载数据
- (void)loadSubTagData {
    
    //1.创建请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    parameters[@"action"] = @"sub";
    
    // 提示用户
    [SVProgressHUD showWithStatus:@"正在加载ing......."];
    
    //2.发送GET请求
    self.dateTask =[TDHttpTool get:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(id responseObject) {
        
        // 移除指示器
        [SVProgressHUD dismiss];
        
        //字典数组转模型数组
        self.subtags = [TDSubTagModel mj_objectArrayWithKeyValuesArray: responseObject];
        
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        // 移除指示器
        [SVProgressHUD dismiss];
    }];
    
}

#pragma mark -------------------
#pragma mark 搭建界面
/** 界面设置 */
- (void)setUpShowingView {
    
    //1.头部view
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    searchBar.placeholder = @"搜索标签";
    self.tableView.tableHeaderView = searchBar;
    self.tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    
    //2.设置全屏分割线（自定义cell才有效）
//    self.tableView.separatorInset = UIEdgeInsetsZero;
    //取消系统分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置tableView背景色
    self.tableView.backgroundColor = TDColor(215, 215, 215);
    
    //3.调整tableView
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.subtags.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        //推荐标识（用不同的组cell显示）
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID0];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        cell.textLabel.text = @"推荐标签";

        return cell;
    }
    else {
        TDSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID1 forIndexPath:indexPath];
        cell.model = self.subtags[indexPath.row];
        
        return cell;
    }
    
    //（iOS8之后设置分割线）
//    cell.layoutMargins = UIEdgeInsetsZero;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 点击完成没有阴影效果
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

// 返回单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40;
    }
    return 60;
}


@end
