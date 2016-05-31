//
//  UIBarButtonItem+TDItem.h
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/26.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (TDItem)

/** 高亮图片 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;
/** 选中图片 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;
/** 高亮选中 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage selImage:(UIImage *)selImage target:(id)target action:(SEL)action;
/** 文字高亮 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;


@end
