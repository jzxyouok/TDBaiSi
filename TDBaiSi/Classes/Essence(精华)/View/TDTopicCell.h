//
//  TDTopicCell.h
//  TDBaiSi
//
//  Created by 谢欣 on 16/6/5.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TDTopicModel;
@interface TDTopicCell : UITableViewCell

/** 帖子模型 */
@property (nonatomic, strong) TDTopicModel *topicModel;

@end
