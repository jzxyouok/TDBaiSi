//
//  UIBarButtonItem+TDItem.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/26.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "UIBarButtonItem+TDItem.h"

@implementation UIBarButtonItem (TDItem)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    // 监听点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 解决导航条按钮 点击范围过大的问题
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btnView];
    
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];
    // 监听点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 解决导航条按钮 点击范围过大的问题
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btnView];
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage selImage:(UIImage *)selImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];
    // 监听点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 解决导航条按钮 点击范围过大的问题
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btnView];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    // 注意:一定要在按钮内容有尺寸的时候,设置才有效果
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    // 监听点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 解决导航条按钮 点击范围过大的问题
    UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
    [btnView addSubview:btn];
   
    return [[UIBarButtonItem alloc] initWithCustomView:btnView];
}



@end
