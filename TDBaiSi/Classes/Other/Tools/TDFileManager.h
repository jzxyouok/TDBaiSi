//
//  TDFileManager.h
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/30.
//  Copyright © 2016年 Frank. All rights reserved.
//  专门处理文件业务

#import <Foundation/Foundation.h>

@interface TDFileManager : NSObject

/** 删除文件 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

/** 获取文件大小 */
+ (NSInteger)getDirectorySize:(NSString *)directoryPath;

/** 转换大小的可读性 */
+ (NSString *)readableStringFromBytes:(NSInteger)byteCount;

@end
