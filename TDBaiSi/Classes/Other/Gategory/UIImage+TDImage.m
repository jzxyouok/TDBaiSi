//
//  UIImage+TDImage.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/25.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "UIImage+TDImage.h"

@implementation UIImage (TDImage)

// 返回不渲染图片
+ (UIImage *)imageNameWithOriginal:(NSString *)imageName {
    
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

// 返回可拉伸图片
+ (UIImage *)resizingImageWithImageName:(UIImage *)image
{
    // 找到可拉伸的区域
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    // 创建可拉伸的图片
    UIImage *resizingIamge =  [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH * 0.5, imageW * 0.5, imageH * 0.5 - 1, imageW * 0.5 - 1) resizingMode:UIImageResizingModeTile];
    
    return resizingIamge;
    
}

// 返回一个圆角图片
- (UIImage *)circleImage {
    // 裁剪图片: 图形上下文
    //1.开启图形上下文
    // scale:比例因素 点:像素比例 0:自动识别比例因素
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //2.描述圆形裁剪路径
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //3.设置为裁剪区域
    [clipPath addClip];
    //4.画图片
    [self drawAtPoint:CGPointZero];
    //5.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
