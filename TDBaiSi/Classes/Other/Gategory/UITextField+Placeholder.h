//
//  UITextField+Placeholder.h
//  
//
//  Created by 谢欣 on 16/5/29.
//
//

#import <UIKit/UIKit.h>

@interface UITextField (Placeholder)

/** 占位文字颜色 */
@property UIColor *placeholderColor;

/** 设置placeholder的颜色 */
+ (NSAttributedString *)attrWithString:(NSString *)string color:(UIColor *)color;

@end
