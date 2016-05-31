//
//  UIView+TDFrame.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/26.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "UIView+TDFrame.h"

@implementation UIView (TDFrame)

- (void)setTd_x:(CGFloat)td_x {
    CGRect frame = self.frame;
    frame.origin.x = td_x;
    self.frame = frame;
}
- (CGFloat)td_x {
    return self.frame.origin.x;
}

- (void)setTd_y:(CGFloat)td_y {
    CGRect frame = self.frame;
    frame.origin.y = td_y;
    self.frame = frame;
}
- (CGFloat)td_y {
    return self.frame.origin.y;
}

- (void)setTd_width:(CGFloat)td_width {
    CGRect frame = self.frame;
    frame.size.width = td_width;
    self.frame = frame;
}
- (CGFloat)td_width{
    return self.frame.size.width;
}

- (void)setTd_height:(CGFloat)td_height {
    CGRect frame = self.frame;
    frame.size.height = td_height;
    self.frame = frame;
}
- (CGFloat)td_height{
    return self.frame.size.height;
}

- (void)setTd_centerX:(CGFloat)td_centerX {
    CGPoint center = self.center;
    center.x = td_centerX;
    self.center = center;
}
- (CGFloat)td_centerX {
    return self.center.x;
}

- (void)setTd_centerY:(CGFloat)td_centerY{
    CGPoint center = self.center;
    center.y = td_centerY;
    self.center = center;
}
- (CGFloat)td_centerY {
    return self.center.y;
}

- (void)setTd_origin:(CGPoint)td_origin {
    CGRect frame = self.frame;
    frame.origin = td_origin;
    self.frame = frame;
}
- (CGPoint)td_origin {
    return self.frame.origin;
}

- (void)setTd_size:(CGSize)td_size {
    CGRect frame = self.frame;
    frame.size = td_size;
    self.frame = frame;
}
- (CGSize)td_size {
    return self.frame.size;
}

@end
