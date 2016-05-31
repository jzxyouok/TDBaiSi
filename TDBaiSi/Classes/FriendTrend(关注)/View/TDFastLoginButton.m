//
//  TDFastLoginButton.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/29.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDFastLoginButton.h"

@implementation TDFastLoginButton

// 布局自定义按钮子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.td_centerX = self.td_width * 0.5;
    self.imageView.td_y = 0;
    
    //根据文字内容计算下label,设置好label尺寸
    [self.titleLabel sizeToFit];
    self.titleLabel.td_centerX = self.td_width * 0.5;
    self.titleLabel.td_y = self.td_height - self.titleLabel.td_height;
    
    //文字显示不出来:label尺寸不够 -> label跟文字一样
    //label宽度 => 计算文字宽度
}

@end
