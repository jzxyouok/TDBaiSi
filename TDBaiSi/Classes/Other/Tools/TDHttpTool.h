//
//  TDHttpTool.m
//  网络请求工具类，负责整个项目中所有的Http网络请求
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface TDHttpTool : NSObject

/** 创建请求 */
//+ (instancetype)shareAFHTTPSessionManager;

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 *
 *  @return 返回一个会话任务
 */
+ (NSURLSessionDataTask *)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 *
 *  @return 返回一个会话任务
 */
+ (NSURLSessionDataTask *)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
