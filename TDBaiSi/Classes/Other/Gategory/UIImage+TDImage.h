//
//  UIImage+TDImage.h
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/25.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TDImage)

// 图片不要渲染 1.Assets里设置图片 2.通过代码设置图片
/** 生成不要渲染图片 */
+ (UIImage *)imageNameWithOriginal:(NSString *)imageName;

/** 生成可拉伸图片 */
+ (UIImage *)resizingImageWithImageName:(UIImage *)image;

/** 生成圆角图片 */
- (UIImage *)circleImage;

@end
