//
//  TDFileManager.m
//  TDBaiSi
//
//  Created by 谢欣 on 16/5/30.
//  Copyright © 2016年 Frank. All rights reserved.
//

#import "TDFileManager.h"

@implementation TDFileManager

#pragma mark - 删除文件
+ (void)removeDirectoryPath:(NSString *)directoryPath {
    // 获取文件管理者
    NSFileManager *manager = [NSFileManager defaultManager];
    
#ifdef DEBUG 
    /*
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    if (!isExist || !isDirectory) {
         报错:抛异常
        NSException *excp = [NSException exceptionWithName:@"filePathError" reason:@"传错,必须传文件夹路径" userInfo:nil];
        [excp raise];
    }
    */
#else
#endif
    
    // 获取文件夹下所有文件
    NSArray *subpaths = [manager contentsOfDirectoryAtPath:directoryPath error:nil];
    // 遍历删除文件
    for (NSString *subPath in subpaths) {
        
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    
}

#pragma mark - 获取文件大小
+ (NSInteger)getDirectorySize:(NSString *)directoryPath {
    
    // 1.获取文件管理者
    NSFileManager *manger = [NSFileManager defaultManager];
    
    // 2.获取文件夹下所有文件
    NSArray *subpaths = [manger subpathsAtPath:directoryPath];
    
    // 3.遍历文件累加大小
    NSInteger totalSize = 0;
    for (NSString *subpath in subpaths) {
        //(1)拼接文件全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subpath];
        
        //(2)判断排除
        BOOL isDirectory;
        BOOL isExist = [manger fileExistsAtPath:filePath isDirectory:&isDirectory];
        BOOL isDS = [filePath containsString:@".DS"];
        if (!isExist || isDirectory || isDS) continue;
        
        //(3)获取路径下文件的属性
        NSDictionary *attrDict = [manger attributesOfItemAtPath:filePath error:nil];
        
        //(4)计算大小
        totalSize += [attrDict fileSize];
    }
    
    // 4.返回文件大小
    return totalSize;
}

#pragma mark - 转换大小的可读性
+ (NSString *)readableStringFromBytes:(NSInteger)byteCount {
    
    if (byteCount == 0) return @"";
    //换算单位
    float numberBytes = byteCount;
    int multiplyP = 0;
    NSArray *array = [NSArray arrayWithObjects:@"B",@"KB", @"MB", @"GB", @"TB", nil];
    
    while (numberBytes > 1000) {
        numberBytes /= 1000;
        multiplyP++;
    }
    
    return [NSString stringWithFormat:@"（%.2f%@）", numberBytes, array[multiplyP]];
}

@end
