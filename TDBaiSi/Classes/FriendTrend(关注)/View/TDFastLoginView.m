//
//  TDFastLoginView.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/29.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDFastLoginView.h"

@implementation TDFastLoginView

// 类方法创建
+ (instancetype)fastLoginView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
