//
//  TDSettingViewController.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/26.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDSettingViewController.h"
#import "TDSubTagCell.h"
#import "TDFileManager.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define cachePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]

@interface TDSettingViewController ()

//缓存单元格
@property (weak, nonatomic) IBOutlet UITableViewCell *cacheCell;
//记录缓存大小
@property (nonatomic, assign) NSInteger totalSize;
@end

//static NSString *const ID = @"settingCell";
@implementation TDSettingViewController

#pragma mark -------------------
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = TDRandomColor;

    // 通过这个方式去设置导航标题，外层不可以这样设置
    self.title = @"设置";
//    self.navigationItem.title = @"设置";
    
    // 设置表格样式
//    self.tableView = [[UITableView alloc] initWithFrame:ScreenB style:UITableViewStyleGrouped];
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    // 显示缓存
    [self showCacheCell];

}

#pragma mark -------------------
#pragma mark 搭建界面
// 计算缓存大小
- (void)showCacheCell {
    self.totalSize = [TDFileManager getDirectorySize:cachePath];
    ;
    NSString *cache = [TDFileManager readableStringFromBytes:self.totalSize];
    self.cacheCell.textLabel.text = [NSString stringWithFormat:@"清除缓存%@", cache];
}

#pragma mark - UITableViewDelegate
// 返回点击行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击完成没有阴影效果
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showWithStatus:@"正在清除缓存..."];
        //清空缓存
        [TDFileManager removeDirectoryPath:cachePath];
        
        if (self.totalSize == 0)
            [SVProgressHUD showSuccessWithStatus:@"清除完成"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        //重新计算
        [self showCacheCell];
        
        //刷新表格
//        [self.tableView reloadData];
    }
    
}

// 返回组标行高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

/*
// 返回组标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"功能设置";
    } else {
        return @"其他";
    }
}
*/

#pragma mark - UITableViewDataSource
/*
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 return 2;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 if (section == 0) {
 return 2;
 } else {
 return 7;
 }
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
 
 if (indexPath.section == 1 && indexPath.row == 0) {
 //显示缓存大小
 self.totalSize = [TDFileManager getDirectorySize:cachePath];
 ;
 NSString *cache = [TDFileManager readableStringFromBytes:self.totalSize];
 cell.textLabel.text = [NSString stringWithFormat:@"清除缓存%@", cache];
 }
 
 return cell;
 }
 */


@end
