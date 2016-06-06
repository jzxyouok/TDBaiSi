//
//  TDTopicCell.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/6/5.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDTopicCell.h"
#import "TDTopicModel.h"
#import <UIImageView+WebCache.h>
#import "TDTopicPictureView.h"
#import "TDTopicVideoView.h"
#import "TDTopicVoiceView.h"

@interface TDTopicCell ()

// 控件的命名 = 功能作用 + 控件类型
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

//中间控件
/** 图片控件 */
@property (nonatomic, weak) TDTopicPictureView *pictureView;
/** 声音控件 */
@property (nonatomic, weak) TDTopicVoiceView *voiceView;
/** 视频控件 */
@property (nonatomic, weak) TDTopicVideoView *videoView;

//最热评论
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;
@end

@implementation TDTopicCell

#pragma mark - 初始化
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

#pragma mark - 模型数据显示
- (void)setTopicModel:(TDTopicModel *)topicModel {
    _topicModel = topicModel;
    
    // 顶部内容
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topicModel.name;
    self.passtimeLabel.text = topicModel.passtime;
    self.text_label.text = topicModel.text;
    
    // 底部内容
    [self setUpButton:self.dingButton number:topicModel.ding placeholder:@"顶"];
    [self setUpButton:self.caiButton number:topicModel.cai placeholder:@"踩"];
    [self setUpButton:self.repostButton number:topicModel.repost placeholder:@"分享"];
    [self setUpButton:self.commentButton number:topicModel.comment placeholder:@"评论"];
    
    // 中间内容
    switch (topicModel.type) {
        case TDTopicTypePicture: { // 图片
            self.voiceView.hidden = YES;
            self.videoView.hidden = YES;
            self.pictureView.hidden = NO;
            break;
        }
            
        case TDTopicTypeVoice: { // 声音
            self.voiceView.hidden = NO;
            self.videoView.hidden = YES;
            self.pictureView.hidden = YES;
            self.voiceView.topicModel = topicModel;
            break;
        }
            
        case TDTopicTypeVideo: { // 视频
            self.voiceView.hidden = YES;
            self.videoView.hidden = NO;
            self.pictureView.hidden = YES;
            break;
        }
            
        case TDTopicTypeWord: { // 段子
            self.voiceView.hidden = YES;
            self.videoView.hidden = YES;
            self.pictureView.hidden = YES;
            break;
        }
            
        default: break;
    }
    
    
    // 最热评论
    if (topicModel.top_cmt.count) { // 有最热评论
        self.topCmtView.hidden = NO;
        
        NSString *username = topicModel.top_cmt.firstObject[@"user"][@"username"];
        NSString *content = topicModel.top_cmt.firstObject[@"content"];
        if (content.length == 0) { // 没有文字内容，是个语音评论
            content = @"[语音评论]";
        }
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
    } else {
        self.topCmtView.hidden = YES;
    }
}

#pragma mark - 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    switch (self.topicModel.type) {
        case TDTopicTypePicture: { // 图片
            self.pictureView.frame = self.topicModel.middleF;
            break;
        }
            
        case TDTopicTypeVoice: { // 声音
            self.voiceView.frame = self.topicModel.middleF;
            break;
        }
            
        case TDTopicTypeVideo: { // 视频
            self.videoView.frame = self.topicModel.middleF;
            break;
        }
            
        default: break;
    }
    
}

/**
 *  处理数字显示
 */
- (void)setUpButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number/10000.0] forState:UIControlStateNormal];
    } else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%ld", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

/**
 *  重写frame
 */
- (void)setFrame:(CGRect)frame {
    frame.size.height -= TDMargin;
    [super setFrame: frame];
}

#pragma mark -------------------
#pragma mark 懒加载
- (TDTopicPictureView *)pictureView {
    if (!_pictureView) {
        TDTopicPictureView *pictureView = [TDTopicPictureView td_viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (TDTopicVoiceView *)voiceView {
    if (!_voiceView) {
        TDTopicVoiceView *voiceView = [TDTopicVoiceView td_viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (TDTopicVideoView *)videoView {
    if (!_videoView) {
        TDTopicVideoView *videoView = [TDTopicVideoView td_viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

@end
