//
//  TDLoginTextField.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/29.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDLoginTextField.h"
#import "UITextField+Placeholder.h"

@implementation TDLoginTextField

/*
 1.文本框的光标变成白色:设置一次
 2.当文本框开始编辑的时候,让占位文字颜色变成白色(3种)
  快速去设置占位文字颜色 -> 拿到占位文字控件(UILabel) -> 查看下类里面有没有提供这样一个属性 给我们获取占位文字label
  如何以后想要知道一个类里面有哪些私有属性,可以采取断点方式
  获取占位文字label
*/

// 加载xib的时候调用
- (void)awakeFromNib {
    
    //1.改变光标的颜色
    self.tintColor = [UIColor whiteColor];
    
    //2.改变占位文字颜色 1.代理 2.target 3.通知
    //自己不能成为自己的代理,用监听这里，通知亦可以
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    //占位文字初始化颜色
    self.attributedPlaceholder = [UITextField attrWithString:self.placeholder color:[UIColor lightGrayColor]];
}

// 文本编辑开始
- (void)textBegin {
    self.attributedPlaceholder = [UITextField attrWithString:self.placeholder color:[UIColor whiteColor]];
}

// 文本编辑结束
- (void)textEnd {
    self.attributedPlaceholder = [UITextField attrWithString:self.placeholder color:[UIColor lightGrayColor]];
}



@end
