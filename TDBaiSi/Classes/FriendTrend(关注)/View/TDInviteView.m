//
//  TDInviteView.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/31.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDInviteView.h"
#import "TDLoginRegisterViewController.h"

@implementation TDInviteView

// 登录注册
- (IBAction)loginRegister:(id)sender {
    //跳转登录注册界面
    TDLoginRegisterViewController *loginVc = [[TDLoginRegisterViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginVc animated:YES completion:nil];
}

// 类方法创建
+ (instancetype)inviteViewView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
