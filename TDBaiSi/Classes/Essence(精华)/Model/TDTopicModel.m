//
//  TDTopicModel.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/6/3.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDTopicModel.h"

@implementation TDTopicModel

- (CGFloat)cellHeight {
    
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    
    // 文字的Y值
    _cellHeight += 55;
    
    // 文字的高度
    CGSize textMaxSize = CGSizeMake(ScreenW - 2 * TDMargin, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + TDMargin;
    
    // 中间内容高度
    if (self.type != TDTopicTypeWord) {
        // 非段子，可能是图片、声音、视频帖子
        CGFloat middleW = textMaxSize.width;
        CGFloat middleH = middleW * (self.height / self.width);
        CGFloat middleX = TDMargin;
        CGFloat middleY = _cellHeight;
        self.middleF = CGRectMake(middleX, middleY, middleW, middleH);
        
        _cellHeight += middleH + TDMargin;
    }
    
    // 最热评论高度
    if (self.top_cmt.count) { // 有最热评论
        _cellHeight += 21;
        
        NSString *username = self.top_cmt.firstObject[@"user"][@"username"];
        NSString *content = self.top_cmt.firstObject[@"content"];
        if (content.length == 0) { // 没有文字内容，是个语音评论
            content = @"[语音评论]";
        }
        NSString *topCmtText = [NSString stringWithFormat:@"%@ : %@", username, content];
        _cellHeight += [topCmtText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + TDMargin;
    }
    
    // 工具条的高度
    _cellHeight += 35 + TDMargin;
    
    return _cellHeight;
}

@end
