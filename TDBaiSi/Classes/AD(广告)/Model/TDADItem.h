//
//  TDADItem.h
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/28.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>

// w_picurl,ori_curl:广告界面跳转地址,w,h
@interface TDADItem : NSObject

/** 广告图片 */
@property (nonatomic ,strong) NSString *w_picurl;
/** 广告界面跳转地址 */
@property (nonatomic ,strong) NSString *ori_curl;
/** 宽 */
@property (nonatomic, assign) CGFloat w;
/** 高 */
@property (nonatomic, assign) CGFloat h;

@end
