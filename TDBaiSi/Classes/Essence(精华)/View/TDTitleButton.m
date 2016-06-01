//
//  TDTitleButton.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/6/1.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDTitleButton.h"

@implementation TDTitleButton

// 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        // 文字颜色
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

// 禁止高亮
- (void)setHighlighted:(BOOL)highlighted {}

@end
