//
//  TDTabBar.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/26.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDTabBar.h"

@interface TDTabBar ()

@property (nonatomic, weak) UIButton *publishBtn;
@end

@implementation TDTabBar

#pragma mark 重新布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.items.count + 1;
    
    //设置内部子控件的位置
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.td_width / count;
    CGFloat btnH = self.td_height;
    
    //遍历子控件
    //UITabBarButton是私有类，且不是UIButton的子类
    int i = 0;
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (i == 2) {
                i += 1;
            }
            
            btnX = btnW * i;
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            
            i ++;
        }
        
    }
    
    //设置加号按钮居中
    self.publishBtn.center = CGPointMake(self.td_width * 0.5, self.td_height * 0.5);
    //    self.publishBtn.center = self.center; //错误，坐标系变化
}

#pragma mark 懒加载
- (UIButton *)publishBtn {
    if (!_publishBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];//根据内容自适应尺寸
        
        [self addSubview:btn];
        _publishBtn = btn;
    }
    return _publishBtn;
}

@end
