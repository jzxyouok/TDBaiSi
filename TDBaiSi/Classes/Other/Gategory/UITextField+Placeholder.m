//
//  UITextField+Placeholder.m
//  
//
//  Created by 谢欣 on 16/5/29.
//
//

#import "UITextField+Placeholder.h"

@implementation UITextField (Placeholder)

#pragma mark - KVC
// 设置占位文字颜色
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    if (self.placeholder == nil) {
        self.placeholder = @" ";
    }
    
//    //获取占位文字控件
//    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
//    //拿到控件去设置颜色
//    placeholderLabel.textColor = placeholderColor;
    
    //直接设置颜色
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

// 返回占位文字颜色
- (UIColor *)placeholderColor {
    return nil;
}

#pragma mark - 属性
// 通过NSAttributedString类型属性改变占位文字颜色
+ (NSAttributedString *)attrWithString:(NSString *)string color:(UIColor *)color {
    
    NSMutableDictionary *attrColor = [NSMutableDictionary dictionary];
    attrColor[NSForegroundColorAttributeName] = color;
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:string attributes:attrColor];
    
    return attr;
}

#pragma mark - runtime

@end
