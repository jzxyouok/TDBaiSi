//
//  TDTopicModel.h
//  TDBaiSi
//
//  Created by 谢欣 on 16/6/3.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TDTopicType) {
    /** 全部 */
    TDTopicTypeAll = 1,
    /** 图片 */
    TDTopicTypePicture = 10,
    /** 文字 */
    TDTopicTypeWord = 29,
    /** 声音 */
    TDTopicTypeVoice = 31,
    /** 视频 */
    TDTopicTypeVideo = 41
};

@interface TDTopicModel : NSObject

/** 帖子的类型 */
@property (nonatomic, assign) NSInteger type;
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 小图 */
@property (nonatomic, copy) NSString *image0;
/** 中图 */
@property (nonatomic, copy) NSString *image2;
/** 大图 */
@property (nonatomic, copy) NSString *image1;

/** 播放数量 */
@property (nonatomic, assign) NSInteger playcount;
/** 声音文件的长度 */
@property (nonatomic, assign) NSInteger voicetime;

/** 根据当前模型数据计算出来的cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect middleF;

@end
