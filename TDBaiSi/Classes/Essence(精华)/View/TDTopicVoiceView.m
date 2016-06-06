//
//  TDTopicVoiceView.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/6/6.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDTopicVoiceView.h"
#import "TDTopicModel.h"
#import <UIImageView+WebCache.h>

@interface TDTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation TDTopicVoiceView

/** 模型数据显示 */
- (void)setTopicModel:(TDTopicModel *)topicModel {
    _topicModel = topicModel;
    
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.image2] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    //播放次数
    if (topicModel.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万次播放", topicModel.playcount/10000.0];
    } else {
        self.playcountLabel.text = [NSString stringWithFormat:@"%ld播放", topicModel.playcount];
    }
    
    //播放时间
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", topicModel.voicetime/60, topicModel.voicetime%60];

}

@end
