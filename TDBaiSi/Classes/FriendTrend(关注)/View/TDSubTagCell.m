//
//  TDSubTagCell.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/28.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDSubTagCell.h"
#import "TDSubTagModel.h"
#import "UIImage+TDImage.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TDSubTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numView;
@end

@implementation TDSubTagCell

/*
 界面细节:
 1. 圆头像 
    1.修改控件的圆角半径 
    iOS9,帧数不会下降,苹果修复这个问题
    iOS8之前还是有问题
    2.裁剪图片生成一张新的圆角图片,图形上下文 (锯齿的问题)
 2.数字
 */
#pragma mark 初始化方法
// 从xib加载就会调用,只会调用一次
- (void)awakeFromNib {
    [super awakeFromNib];
    //设置圆角
    self.iconView.layer.cornerRadius = 10;
    self.iconView.layer.masksToBounds = YES;
    
    //设置字体
    self.numView.textColor = [UIColor grayColor];
    self.numView.font = [UIFont systemFontOfSize:13];

}

#pragma mark 接口方法
// 模型赋值
- (void)setModel:(TDSubTagModel *)model {
    _model = model;
    
    //头像
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
//        if (image == nil) return ;
//        
//        self.iconView.image =  [image circleImage];
        
    }];
    
    //姓名
    _nameView.text = model.theme_name;
    
    //订阅数量
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅", model.sub_number];
    
    NSInteger num = [numStr integerValue];
    if (num >= 10000) {
        CGFloat numF = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅", numF];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    _numView.text = numStr;

}


// 重写frame
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    
    // 给cellframe赋值
    [super setFrame:frame];
}


@end
