//
//  TDLoginRegisterView.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/29.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDLoginRegisterView.h"
//#import "UIImage+TDImage.h"

@interface TDLoginRegisterView ()

// 登录注册按钮
@property (weak, nonatomic) IBOutlet UIButton *loginRegisterBtn;
@end

@implementation TDLoginRegisterView

#pragma mark - 初始化
// 从xib加载就会调用,就会把xib所有的属性全部设置
- (void)awakeFromNib {
//    [super awakeFromNib];
    
#warning 实现不了效果
//    UIImage *image = self.loginRegisterBtn.currentBackgroundImage;
//    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
//    [self.loginRegisterBtn setBackgroundImage:image forState:UIControlStateNormal];
}

#pragma mark - 接口方法
// 登录
+ (instancetype)loginView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

// 注册
+ (instancetype)registerView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
