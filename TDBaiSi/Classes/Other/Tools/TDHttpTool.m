//
//  TDHttpTool.m
//  网络请求工具类，负责整个项目中所有的Http网络请求
//

#import "TDHttpTool.h"

@implementation TDHttpTool

+ (NSURLSessionDataTask *)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
   
    //请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //发送GET请求
    NSURLSessionDataTask *dataTask = [mgr GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        if (failure) {
            failure(error);
        }
    }];
    
    return dataTask;
}

+ (NSURLSessionDataTask *)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    //请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //发送POST请求
    NSURLSessionDataTask *dataTask = [mgr POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        if (failure) {
            failure(error);
        }
    }];
    
    return dataTask;
}

@end
