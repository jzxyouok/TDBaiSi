//
//  TDMineViewController.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/25.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDMineViewController.h"
#import "TDSettingViewController.h"
#import "TDWebViewController.h"
#import "TDLoginRegisterViewController.h"
#import "TDSquareCell.h"
#import "TDSquareModel.h"
#import "TDHttpTool.h"
#import <SafariServices/SafariServices.h>
#import <MJExtension/MJExtension.h>

//单元的宽高
#define itemWH ((ScreenW - ((cols-1) * margin)) / cols)
static NSInteger const cols = 4; //列数
static CGFloat const margin = 1; //间隔

@interface TDMineViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

/** 模型数组 */
@property (nonatomic, strong) NSMutableArray *squareItems;
@property (nonatomic, weak) UICollectionView *collectionView;
@end

static NSString *const ID = @"mineCell";
@implementation TDMineViewController
/* 问题
 1.collectionView高度 -> cell行数
 2.collectionView不能滚动
 */
#pragma mark -------------------
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = TDRandomColor;
    
    // 设置tableView组间距
    // 如果是分组样式,默认每一组都会有头部和尾部间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    // 设置顶部额外滚动区域-25
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    // 设置导航条内容
    [self setUpNavigationBar];
    
    // 设置底部界面
    [self setUpFootView];
    
    // 加载数据
    [self loadMineData];

    // 监听通知
    [self setupNote];
    
}

#pragma mark -------------------
#pragma mark 监听点击
// 设置按钮
- (void)setting {
    
    //加载设置控制器
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"TDSettingViewController" bundle:nil];
    TDSettingViewController *setting = [sb instantiateInitialViewController];
    //隐藏tabbar（push之前设置，重写push方法中实现）
//    setting.hidesBottomBarWhenPushed = YES;
    
    //跳转到设置界面
    [self.navigationController pushViewController:setting animated:YES];
}

// 夜间模式
- (void)night:(UIButton *)button {
    button.selected = !button.selected;
}

#pragma mark -------------------
#pragma mark 加载数据
- (void)loadMineData {
    
    //1.请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    //2.发送请求
    [TDHttpTool get:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(id responseObject) {
        //写成plist文件好阅读
//        [responseObject writeToFile:@"/Users/xiexin/Desktop/square.plist" atomically:YES];
        
        //1.获取字典数组
        NSArray *dictArr = responseObject[@"square_list"];
        
        //2.转模型数据
        self.squareItems = [TDSquareModel mj_objectArrayWithKeyValuesArray:dictArr];
        
        // 填充空白
        [self resolveData];
        
        //3.刷新表格
        [self.collectionView reloadData];
        
        // 重新设置collectionView的高度
        NSInteger count = self.squareItems.count;
        //两种情形如8或9
        NSInteger rows = (count - 1) / cols + 1;
        CGFloat collectionH = rows * itemWH + (rows - 1) * margin;
        self.collectionView.td_height = collectionH;
        
        //设置tableView滚动范围 => tableView滚动范围是系统会自动根据内容去计算
        self.tableView.tableFooterView = self.collectionView;
        
       
    } failure:^(NSError *error) {
        TDLog(@"%@", error);
    }];
    
}

// 处理数据
- (void)resolveData {
    
    NSInteger count = self.squareItems.count;
    
    NSInteger surplus = count % cols;
    if (surplus) {
        surplus = cols - surplus;
        
        //添加空白模型
        for (int i = 0; i < surplus; i++) {
            TDSquareModel *model = [[TDSquareModel alloc] init];
            [self.squareItems addObject:model];
        }
    }
    
}

#pragma mark -------------------
#pragma mark 搭建界面
/** 设置导航条 */
- (void)setUpNavigationBar {
    
    //右边
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] highImage:[UIImage imageNamed:@"mine-moon-icon-click"] selImage:[UIImage imageNamed:@"mine-sun-icon-click"] target:self action:@selector(night:)];

    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
    
    //中间
    self.navigationItem.title = @"我的";
    //    self.title = @"我的"; //有bug,会使tabbarItem的文字也变化
    //     NSLog(@"%p---%p",self.title, self.navigationItem.title);
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        TDLoginRegisterViewController *loginVc = [[TDLoginRegisterViewController alloc] init];
        [self presentViewController:loginVc animated:YES completion:nil];
    }
}

/*
 1.UICollectionView初始化必须要设置布局
 2.cell必须注册
 3.自定义cell
 */
/** 设置底部界面 */
- (void)setUpFootView {
    //1.流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    
    //2.创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.scrollsToTop = NO;
    collectionView.backgroundColor = [UIColor clearColor];

    //显示在tableView的底部视图上
    self.tableView.tableFooterView = collectionView;
    
    //3.注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"TDSquareCell" bundle:nil] forCellWithReuseIdentifier:ID];
    
    //4.设置数据源
    collectionView.dataSource = self;
    collectionView.delegate = self;
   
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TDSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    //设置数据
    cell.model = self.squareItems[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    //取出模型
    TDSquareModel *model = self.squareItems[indexPath.item];
    //安全判断
    if (![model.url containsString:@"http"]) return;
    
    NSURL *url = [NSURL URLWithString:model.url];
    // WKWebView:UIWebView升级版,监听进度条,数据缓存,iOS8才有
    TDWebViewController *webVc = [[TDWebViewController alloc] init];
    webVc.url = url;
    [self.navigationController pushViewController:webVc animated:YES];

}

#pragma mark -------------------
#pragma mark 监听通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupNote
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:TDTabBarButtonDidRepeatClickNotification object:nil];
}

/**
 *  tabBarButton被重复点击
 */
- (void)tabBarButtonDidRepeatClick
{
    if (self.view.window == nil) return;
    
    NSLog(@"%s", __func__);
}

#pragma mark -------------------
#pragma mark SFSafariViewController
/*
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%ld", indexPath.item);
    //获取模型
    TDSquareModel *model = self.squareItems[indexPath.row];

//     在当前应用打开网页,但是要有safari功能,自己去写
//     iOS9: SFSafariViewController:在当前应用打开网页,跟safari同样一样
//     第一步:导入#import <SafariServices/SafariServices.h>
//     注意:modal

    if (![model.url containsString:@"http"]) return;
    SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:model.url]];
    safariVc.delegate = self;
    
    //modal
    [self presentViewController:safariVc animated:YES completion:nil];
    
    //push
//    [self.navigationController pushViewController:safariVc animated:YES];
//    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - SFSafariViewControllerDelegate
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    TDLog(@"点击了done");
//    [self.navigationController popViewControllerAnimated:YES];
//    self.navigationController.navigationBarHidden = NO;
}
*/

@end
