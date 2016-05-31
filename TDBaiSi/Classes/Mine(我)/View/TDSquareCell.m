//
//  TDSquareCell.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/29.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDSquareCell.h"
#import "TDSquareModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TDSquareCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@end

@implementation TDSquareCell

// 初始化方法
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}

// 传递数据
- (void)setModel:(TDSquareModel *)model {
    _model = model;
    
    //头像
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    //名字
    _nameView.text = model.name;
}

@end
