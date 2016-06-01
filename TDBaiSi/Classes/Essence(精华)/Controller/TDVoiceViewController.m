//
//  TDVoiceViewController.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/6/1.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDVoiceViewController.h"

@interface TDVoiceViewController ()

@end

@implementation TDVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = TDRandomColor;
    
    // 调整tableView的位置
    self.tableView.contentInset = UIEdgeInsetsMake(NavBarH + TitlesViewH, 0, TabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset; //滚动条
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd", self.class, indexPath.row];
    
    return cell;
}

@end
