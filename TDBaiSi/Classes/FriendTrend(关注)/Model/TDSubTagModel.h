//
//  TDSubTagModel.h
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/28.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDSubTagModel : NSObject

/*** 头像图片 **/
@property (nonatomic ,strong) NSString *image_list;
/*** 姓名 **/
@property (nonatomic ,strong) NSString *theme_name;
/*** 订阅数量 **/
@property (nonatomic ,strong) NSString *sub_number;

@end
